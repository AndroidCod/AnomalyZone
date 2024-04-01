// az_fnc_AI_spotTarget = 
/*
az_fnc_AI_mulFactor =
{
	params ["_value", "_factor", ["_min", 0]];
	(_min max (_value * _factor))
};
*/
#define CALC(limit, v, f) (limit max (v * f))		

params ["_unit", "_target", "_fovFactor", "_rangeFactor", ["_unitIsMutant", false]];

private _isSpotted = false;

// Mutant Smell spot
if (_unitIsMutant) then
{
	private _range = (missionConfigFile >> "cfgMutants" >> (_unit getVariable "AZ_Type") >> "SmellSpotRange") call BIS_fnc_getCfgData; 
	if (_range > (_unit distance _target)) then {_isSpotted = true; };
};
if (_isSpotted) exitWith {true};

// Audible spot
if (vectorMagnitude(velocity _target) > 0.01) then 
{
	private _spotRange = AZ_AI_AudibleSpotRangeSTAND;
	switch (stance _target) do
	{
		case "STAND": { _spotRange = AZ_AI_AudibleSpotRangeSTAND; }; 
		case "CROUCH": { _spotRange = AZ_AI_AudibleSpotRangeCROUCH; };
		case "PRONE": { _spotRange = AZ_AI_AudibleSpotRangePRONE; };
		//case "UNDEFINED": {}
		default {};
	};
	_spotRange = _spotRange * (1 - Rain); 
	if (_unitIsMutant) then 
	{
		private _f = (missionConfigFile >> "cfgMutants" >> (_unit getVariable "AZ_Type") >> "AudibleSpotRangeFactor") call BIS_fnc_getCfgData;
		_spotRange = _spotRange * _f; 
	};
	if (_spotRange > (_unit distance _target)) then {_isSpotted = true; };
};
if (_isSpotted) exitWith {true};

// Углы обзора:
//	- оптика(PSO-1) - 6
//	- бинокль - до 50
// 	- обычное - 110
// 	- переферийное - 180

//(_this call az_fnc_AI_calcVision) params ["_fovFactor", "_rangeFactor"];
(_target call az_fnc_AI_calcVisionTarget) params ["_fovFactorTarget", "_rangeFactorTarget"];
_fovFactor = _fovFactor + _fovFactorTarget;
_rangeFactor = _rangeFactor + _rangeFactorTarget;

// Weapon Optics vision
// ???
	
// Binocular vision
if ((currentWeapon _unit) isKindOf ["Binocular", configFile >> "CfgWeapons"]) then
{
	private _fov = CALC(AZ_AI_MinFOV, AZ_AI_FOVBinocular, _fovFactor);
	private _range = CALC(AZ_AI_MinRange, AZ_AI_SpotRangeBinocular, _rangeFactor);
	_isSpotted = [_unit, _target, _fov, _range, AZ_AI_VisibilityThreshold] call az_fnc_AI_visualSpot;		
};
if (_isSpotted) exitWith {true};

// Normal vision
private _fov = CALC(AZ_AI_MinFOV, AZ_AI_FOVNormal, _fovFactor);
private _range = CALC(AZ_AI_MinRange, AZ_AI_SpotRangeNormal, _rangeFactor);
_isSpotted = ([_unit, _target, _fov, _range, AZ_AI_VisibilityThreshold] call az_fnc_AI_visualSpot);
if (_isSpotted) exitWith {true};

// Peripheral vision
_fov = CALC(AZ_AI_MinFOV, AZ_AI_FOVPeripheral, _fovFactor);
_range = CALC(AZ_AI_MinRange, AZ_AI_SpotRangePeripheral, _rangeFactor);
_isSpotted = ([_unit, _target, _fov, _range, AZ_AI_VisibilityThreshold] call az_fnc_AI_visualSpot);
if (_isSpotted) exitWith {true};


_isSpotted
