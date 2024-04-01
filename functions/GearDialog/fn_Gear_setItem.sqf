// AZ_GearDialog_fnc_Gear_setItem;
#include "..\macros.hpp"

params ["_display", "_gearSlotID", "_item"];

if (isNull _display) exitWith {false};

if (not([_gearSlotID, _item] call AZ_Unit_fnc_Gear_isCompatibleItem)) exitWith { false }; 

private _unit = _display call AZ_GearDialog_fnc_getUnit;

private _currentItem = [_unit, _gearSlotID] call AZ_Unit_fnc_getGear;
if (not isNil "_currentItem") exitWith {false}; 

if (not([_unit, _gearSlotID, _item] call AZ_Unit_fnc_setGear)) exitWith { false };

_this call AZ_GearDialog_fnc_Gear_OnSlotChanged;

true
