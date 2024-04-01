// AZ_GearDialog_fnc_getUnit

#include "..\macros.hpp"

params ["_display"];

if (isNull _display) exitWith {};

private _unit = _display getVariable "unit";
if (isNil '_unit') exitWith { ERROR("GearDialog do not init 'Unit'"); nil};

_unit
