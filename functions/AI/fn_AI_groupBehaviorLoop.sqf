//
params ["_group"];


// 


// stop loop for dead group
//if ({alive _x} count units _group < 1) exitWith {0};

// spot radar
private _size = 0;
private _lastSpotedTime = 0;
{
	private _unit = _x;
	if (alive _unit) then 
	{
		_size = _size + 1;
		if (vehicle _unit == _unit) then // not in vehicle
		{
			// Hide itself
			if (captiveNum _unit == 0) then
			{
				private _spotedTime = _unit getVariable ["AZ_AI_SpotedTime", 0];
				if (CBA_MissionTime - _spotedTime >  AZ_AI_DelayToHidden) then
				{
					// set to hidden
					//player groupChat format ["hide: %1 ", name _unit];
					_unit setCaptive AZ_AI_CaptiveNumber;
				};
			};
		}
		else // unit inside vehicle
		{
			if (captiveNum _unit == AZ_AI_CaptiveNumber) then
			{
				_unit setCaptive 0;
				_unit setVariable ["AZ_AI_SpotedTime", CBA_MissionTime];
			};	
		};
	};
	
	if (_unit call az_fnc_AI_unitCanSpot) then 
	{		
		private _maxSpotRange = AZ_AI_SpotRangeNormal;
		if ((currentWeapon _unit) isKindOf ["Binocular", configFile >> "CfgWeapons"]) then
		{
			_maxSpotRange = _maxSpotRange max AZ_AI_SpotRangeBinocular;
		};
		(_unit call az_fnc_AI_calcVision) params ["_fovFactor", "_rangeFactor"];
		
		// !!! WARNING !!! nearEntities command doesn't return dead entities or entities inside vehicles.
		// Check Mans
		private _targets = _unit nearEntities ["CAManBase", (AZ_AI_MinRange max (_maxSpotRange * _rangeFactor))];
		
		{
			private _target = _x;
			if (_unit != _target and (alive _target)) then
			{
				if (([_unit, _target] call AZ_fnc_Mutant_isEnemy)) then 
				{
					if ([_unit, _target, _fovFactor, _rangeFactor] call az_fnc_AI_spotTarget) then
					{
						//player groupChat format ["spotted: %1 ", name _target];
						private _cap = captiveNum _target;
						if (_cap == AZ_AI_CaptiveNumber or _cap == 0) then
						{
							_target setCaptive 0;
							_target setVariable ["AZ_AI_SpotedTime", CBA_MissionTime];
							_lastSpotedTime = CBA_MissionTime;
						};					
					};
				};
			};

		} forEach _targets;
		
		// Check Vehicles
		// !!! Не проверяем сектор, видимость или шум. Тут не предполагается полное использование техники
		_targets = _unit nearEntities [["Car", "Motorcycle", "Air", "Ship", "Tank"], (AZ_AI_MinRange max (_maxSpotRange * _rangeFactor))];
		{			
			private _vehicle = _x;
			if (alive _vehicle) then
			{
				if (([side group _unit, side group _vehicle] call BIS_fnc_sideIsEnemy)) then // sideUnknown(CIV for Arma 3) if empty or dead crew, otherwise the appropriate side
				{
					//player groupChat format ["[%1] spoted enemy vehicle: %2", name _unit, _vehicle];
					_lastSpotedTime = CBA_MissionTime;					
				};
			};
			
		} forEach _targets;
	};
	

} forEach units _group;

if (_size < 1) exitWith {0};

if (_lastSpotedTime == 0) then
{
	_lastSpotedTime = _lastSpotedTime max (_group getVariable ["AZ_AI_LastSpottedTime", 0]);
}
else
{
	_group setVariable ["AZ_AI_LastSpottedTime", _lastSpotedTime];
};


//
private _spotDelay = AZ_AI_SpotDelaySafe; // sec
switch (combatBehaviour _group) do
{
	case "CARELESS";
	case "SAFE":
	{
	};	
	case "AWARE":
	{
		_spotDelay = AZ_AI_SpotDelayCombat;
		if (CBA_MissionTime - _lastSpotedTime > AZ_AI_DelayToSAFE) then
		{
			_group setBehaviourStrong "SAFE";
			_group setCombatMode "WHITE";
			{ _x setUnitCombatMode "WHITE"} forEach units _group;
			//_group setVariable ["AZ_AI_LastSpottedTime", CBA_MissionTime];
		};

	};
	case "COMBAT";
	case "STEALTH":
	{
		_spotDelay = AZ_AI_SpotDelayCombat;
		if (CBA_MissionTime - _lastSpotedTime > AZ_AI_DelayToAWARE) then
		{
			_group setBehaviourStrong "AWARE";
			_group setCombatMode "WHITE";
			{ _x setUnitCombatMode "WHITE"} forEach units _group;
			//_group setVariable ["AZ_AI_LastSpottedTime", CBA_MissionTime];
		};
	};
	case "ERROR":// - when not available
	default {};
};

//
if ((combatMode _group == "RED")) then
{
	_spotDelay = AZ_AI_SpotDelayCombat;
};

_spotDelay
// Schedule the loop to be executed again N sec later
//[az_fnc_AI_groupBehaviorLoop, _this, _spotDelay] call CBA_fnc_waitAndExecute;