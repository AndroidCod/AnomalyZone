// AZ_fnc_Mutant_spotEnemy

params ["_unit"];

//private _config = missionConfigFile >> "cfgMutants" >> (typeOf _unit);
//private _spotRange = ((_config >> "spotRange") call BIS_fnc_getCfgData);

(_unit call az_fnc_AI_calcVision) params ["_fovFactor", "_rangeFactor"];

private _targetsList = [];
private _nearTarget = objNull;//
private _nearTargetRange = AZ_AI_SpotRangeNormal * 3;

// Check Mans
private _targets = _unit nearEntities ["CAManBase", (AZ_AI_MinRange max (AZ_AI_SpotRangeNormal * _rangeFactor))];
{
	private _target = _x;
	if ((_unit != _target) and (alive _target)) then
	{
		if ([_unit, _target] call AZ_fnc_Mutant_isEnemy) then
		{
			if ([_unit, _target, _fovFactor, _rangeFactor, true] call az_fnc_AI_spotTarget) then
			{
				//player groupChat format ["spotted: %1 ", name _target];
				private _dist = _unit distance _target;
				if (_dist < _nearTargetRange) then
				{
					if (not isNull _nearTarget) then { _targetsList pushBack _nearTarget; };
					_nearTarget = _target;
					_nearTargetRange = _dist;
				}
				else
				{
					_targetsList pushBack _target;
				};
			};
		};
	};

} forEach _targets;

// Check vehicles
// !maybe dont needed

if (not isNull _nearTarget) then { _targetsList insert [0, [_nearTarget]]; };

// return all spotted entities(not sorted by distance), where first element is the nearest object
_targetsList
