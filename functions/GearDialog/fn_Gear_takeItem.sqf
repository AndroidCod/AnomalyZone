//[_display, _ctrlIDC] call AZ_GearDialog_fnc_Gear_takeItem;
#include "..\macros.hpp"

params ["_display", "_gearSlotID"];

if (isNull _display) exitWith {};

private _unit = _display call AZ_GearDialog_fnc_getUnit;
private _deletedItem = [_unit, _gearSlotID] call AZ_Unit_fnc_takeGear;

_this call AZ_GearDialog_fnc_Gear_OnSlotChanged;

_deletedItem


