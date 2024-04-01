// AZ_GearDialog_fnc_Gear_getItem

#include "..\macros.hpp"

params ["_display", "_gearSlotID"];

if (isNull _display) exitWith {};

private _unit = _display call AZ_GearDialog_fnc_getUnit;

([_unit, _gearSlotID] call AZ_Unit_fnc_getGear)