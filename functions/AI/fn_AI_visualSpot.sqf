//az_fnc_AI_visualSpot = 

params ["_unit", "_target", "_fov", "_range", ["_visibilityThreshold", 0.5]];

//player groupChat format ["[%1]%2 FOV=%3 Distance=%4", diag_frameno, typeof _target, _fov, _range];

private _isSpotted = false;
//private _inSector = [getPosWorld _unit, eyeDirection _unit, _fov, getPosWorld _target] call BIS_fnc_inAngleSector;	
private _inSector = [eyePos _unit, eyeDirection _unit, _fov, getPosWorld _target] call az_fnc_inAngleSector;	
if (_inSector) then
{
	if ((_unit distance _target) < _range) then
	{
		_isSpotted = [_unit, _target, _visibilityThreshold] call az_fnc_AI_checkVisibility;		
	};		
};

_isSpotted

