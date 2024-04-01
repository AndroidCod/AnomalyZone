/**********************************************************************************
	Class Unit
/**********************************************************************************/

#include "..\macros.hpp"

params ["_unit", "_class"];

private _stat = (missionConfigFile >> "cfgUnits" >> _class) call az_fnc_loadConfigToHashMap;

// preload sum params

_unit setVariable ["AZ_UnitStat", _stat];

_unit allowDamage true;

// Init Gear
// private _gear = createHashMap;
_unit setVariable ["AZ_Unit_Gear", createHashMap];

private _index = _unit addEventHandler ["HandleDamage", az_Unit_fnc_onHandleDamage ];
_unit setVariable[ "AZ_HandleDamage_ID", _index, false];

_index = _unit addEventHandler ["Fired", AZ_Unit_fnc_onFired ];
_unit setVariable[ "AZ_Fired_ID", _index, false];

//_index = _unit addEventHandler ["Reload", {TRACE_1("%1", _this);}];

_index = _unit addEventHandler ["Reloaded", AZ_Unit_fnc_onReloaded];
_unit setVariable[ "AZ_Reloaded_ID", _index, false];