//AZ_GearDialog_fnc_getItemBySlotID =
#include "..\macros.hpp"

params ["_display", "_slotID"]; 

if (isNull _display) exitWith {};

//private _display = _this;
private _itemID = 0;
private _item = nil;
// find item 

private _fnc_getItem = 
{	
	_itemID = _slotID - _this;
	_itemID = FLOOR_10(_itemID);
	
	private _container = [_display, _this] call AZ_GearDialog_fnc_Container_getData;
	if (isNil "_container") exitWith {};
	_item = [_container, _itemID] call AZ_ItemsContainer_fnc_getItem;
};

private _fnc_getMagazine = 
{
	params ["_muzzleIndex"];
	private _weapon = [_display, GEAR_SLOT_ID_WEAPON_PRIMARY] call AZ_GearDialog_fnc_Gear_getItem;
	if (not isNil "_weapon") then
	{
		_item = [_weapon, _muzzleIndex] call AZ_Item_fnc_Weapon_getMagazine;
	};
};

switch true do
{
	case (_slotID > GEAR_DIALOG_VEST_CONTAINER_IDC and {_slotID < (GEAR_DIALOG_VEST_CONTAINER_IDC + GEAR_DIALOG_CONTAINER_IDC_CAPACITY)}) : 
	{
		GEAR_DIALOG_VEST_CONTAINER_IDC call _fnc_getItem;
	};
	case (_slotID > GEAR_DIALOG_UNIFORM_CONTAINER_IDC and {_slotID < (GEAR_DIALOG_UNIFORM_CONTAINER_IDC + GEAR_DIALOG_CONTAINER_IDC_CAPACITY)}) : 
	{
		GEAR_DIALOG_UNIFORM_CONTAINER_IDC call _fnc_getItem;
	};
	case (_slotID > GEAR_DIALOG_BACKPACK_CONTAINER_IDC and {_slotID < (GEAR_DIALOG_BACKPACK_CONTAINER_IDC + GEAR_DIALOG_CONTAINER_IDC_CAPACITY)}) : 
	{
		GEAR_DIALOG_BACKPACK_CONTAINER_IDC call _fnc_getItem;
	};
	case (_slotID > GEAR_DIALOG_LEFT_CONTAINER_IDC and {_slotID < (GEAR_DIALOG_LEFT_CONTAINER_IDC + GEAR_DIALOG_CONTAINER_IDC_CAPACITY)}) : 
	{
		GEAR_DIALOG_LEFT_CONTAINER_IDC call _fnc_getItem;
	};
	case (_slotID == GEAR_SLOT_ID_NVG);
	case (_slotID == GEAR_SLOT_ID_HEADGEAR);
	case (_slotID == GEAR_SLOT_ID_GOGGLE);
	case (_slotID == GEAR_SLOT_ID_UNIFORM);
	case (_slotID == GEAR_SLOT_ID_VEST);
	case (_slotID == GEAR_SLOT_ID_BACKPACK);
	case (_slotID == GEAR_SLOT_ID_WEAPON_PRIMARY);
	case (_slotID == GEAR_SLOT_ID_WEAPON_SECONDARY);
	case (_slotID == GEAR_SLOT_ID_WEAPON_HANDGUN):
	{
		_item = [_display, _slotID] call AZ_GearDialog_fnc_Gear_getItem;
	};
	case (_slotID == GEAR_SLOT_ID_WEAPON_PRIMARY_MAG_0):
	{
		0 call _fnc_getMagazine;
	};
	case (_slotID == GEAR_SLOT_ID_WEAPON_PRIMARY_MAG_1):
	{
		1 call _fnc_getMagazine;
	};
	default { ERROR_NO_IMPLEMENTATION };
};

//if (_itemID != 0) exitWith {};
_item
