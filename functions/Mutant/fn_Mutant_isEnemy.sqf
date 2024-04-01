// AZ_fnc_Mutant_isEnemy =

params ["_unit", "_target"];

private _unitIsMutant = _unit getVariable ["AZ_IsMutant", false]; //(typeOf _unit) isKindOf ["Mutant", _config];

private _isEnemy = if (_unitIsMutant) then
{
	//private _targetIsMutant = (typeOf _target) isKindOf ["Mutant", _config];
	private _targetIsMutant = _target getVariable ["AZ_IsMutant", false]; //(typeOf _target) isKindOf ["Mutant", _config];

	if (not _targetIsMutant) exitWith {true};

	//private _config = missionConfigFile >> "cfgMutants";
	private _enemyTypes = ((missionConfigFile >> "cfgMutants" >> (_unit getVariable "AZ_Type") >> "enemyTypes") call BIS_fnc_getCfgData);

	if (count _enemyTypes == 0) exitWith {false};

	(((_target getVariable "AZ_Type") in _enemyTypes))

}
else
{
	private _targetIsMutant = _target getVariable ["AZ_IsMutant", false];
	
	if (_targetIsMutant) exitWith {true};
	
	([side group _unit, side group _target] call BIS_fnc_sideIsEnemy)
};

/* if (_isEnemy) then
{
	player sideChat format ["[%1] Enemy to [%2]", name _target, name _unit];
}
else
{
	player sideChat format ["[%1] Friendly to [%2]", name _target, name _unit];
}; */
_isEnemy
