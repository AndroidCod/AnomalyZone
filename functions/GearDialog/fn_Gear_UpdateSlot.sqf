// AZ_GearDialog_fnc_Gear_UpdateSlot

#include "..\macros.hpp"

params ["_display", "_gearSlotID", ["_item", nil]];

if (isNull _display) exitWith {};

if (isNil '_item') then 
{
	_item = _this call AZ_GearDialog_fnc_Gear_getItem;
};

// AZ_SLOT_GEAR_WEAPON(GEAR_SLOT_ID_WEAPON_PRIMARY, 2, 18, 10, 4)

[_display, _gearSlotID, nil, _item] call AZ_GUI_fnc_ItemSlot_SetPosition;
[_display, _gearSlotID, _item] call AZ_GUI_fnc_ItemSlot_Update;



