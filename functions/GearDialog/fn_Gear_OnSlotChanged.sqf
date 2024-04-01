// [_display, _gearSlotID] call AZ_GearDialog_fnc_Gear_OnSlotChanged;

#include "..\macros.hpp"

params ["_display", "_gearSlotID"];

if (isNull _display) exitWith {};

private _item = _this call AZ_GearDialog_fnc_Gear_getItem;
[_display, _gearSlotID, _item] call AZ_GearDialog_fnc_Gear_UpdateSlot;

switch (_gearSlotID) do 
{
	case GEAR_SLOT_ID_UNIFORM:
	{
		[_display, GEAR_DIALOG_UNIFORM_CONTAINER_IDC] call AZ_GearDialog_fnc_Container_update;
	};
	case GEAR_SLOT_ID_VEST:
	{
		[_display, GEAR_DIALOG_VEST_CONTAINER_IDC] call AZ_GearDialog_fnc_Container_update;
	};
	case GEAR_SLOT_ID_BACKPACK:
	{
		[_display, GEAR_DIALOG_BACKPACK_CONTAINER_IDC] call AZ_GearDialog_fnc_Container_update;
	};
	case GEAR_SLOT_ID_WEAPON_PRIMARY:
	{
		private _muzzles = (_item get "config" get "muzzles");
		private _magazine = nil;
		if ((not isNil "_item") and {count _muzzles > 0}) then
		{	
			_magazine = [_item, 0] call AZ_Item_fnc_Weapon_getMagazine;
		};
		[_display, GEAR_SLOT_ID_WEAPON_PRIMARY_MAG_0, nil, _magazine] call AZ_GUI_fnc_ItemSlot_SetPosition;
		[_display, GEAR_SLOT_ID_WEAPON_PRIMARY_MAG_0, _magazine] call AZ_GUI_fnc_ItemSlot_Update;
		
		_magazine = nil;
		if ((not isNil "_item") and {count _muzzles > 1}) then
		{	
			_magazine = [_item, 1] call AZ_Item_fnc_Weapon_getMagazine;
		};
		[_display, GEAR_SLOT_ID_WEAPON_PRIMARY_MAG_1, nil, _magazine] call AZ_GUI_fnc_ItemSlot_SetPosition;
		[_display, GEAR_SLOT_ID_WEAPON_PRIMARY_MAG_1, _magazine] call AZ_GUI_fnc_ItemSlot_Update;
	};
	//default { ERROR_NO_IMPLEMENTATION; };
};

