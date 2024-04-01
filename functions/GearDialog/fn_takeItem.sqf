// Take item
// [_display, _slotID, _controlsGroupIDC] call AZ_GearDialog_fnc_takeItem;

#define TRACE_MODE
#include "..\macros.hpp"

params ["_display", "_dragSlotID", "_dragSlotParentIDC"];

if (isNull _display) exitWith {};

// private _takedItem = nil;
// private _isDeleted = false;
// private _takedItemSlotRect = nil;
private _takeData = nil;


private _fnc_takePrimaryWeaponMag =
{
	params ["_muzzleIndex"];
	
	private _unit = _display call AZ_GearDialog_fnc_getUnit; 
	private _weapon = [_unit, GEAR_SLOT_ID_WEAPON_PRIMARY] call AZ_Unit_fnc_getGear;
	if (isNil "_weapon") exitWith {};
	private _magazine = [_weapon, _muzzleIndex] call AZ_Item_fnc_Weapon_getMagazine;
	if (isNil '_magazine') exitWith {};
	private _takedItem = nil;
	if (_magazine call AZ_Item_fnc_Magazine_isIntegral) then
	{
		_takedItem = [_unit, GEAR_SLOT_ID_WEAPON_PRIMARY, _muzzleIndex] call AZ_Unit_fnc_takeWeaponAmmo;
	}
	else
	{
		_takedItem = [_unit, GEAR_SLOT_ID_WEAPON_PRIMARY, _muzzleIndex] call AZ_Unit_fnc_takeWeaponMagazine;
	};
	if (not isNil '_takedItem') then 
	{
		_takeData = [_takedItem];
		[_display, GEAR_SLOT_ID_WEAPON_PRIMARY] call AZ_GearDialog_fnc_Gear_onSlotChanged;
	};
};
 
switch (_dragSlotParentIDC) do 
{
	case 0:
	{
		switch (_dragSlotID) do 
		{
			case GEAR_SLOT_ID_NVG;
			case GEAR_SLOT_ID_GOGGLE;
			case GEAR_SLOT_ID_UNIFORM;
			case GEAR_SLOT_ID_VEST;
			case GEAR_SLOT_ID_BACKPACK;
			case GEAR_SLOT_ID_HEADGEAR;
			case GEAR_SLOT_ID_WEAPON_PRIMARY;
			case GEAR_SLOT_ID_WEAPON_SECONDARY; 
			case GEAR_SLOT_ID_WEAPON_HANDGUN:
			{
				private _unit = _display call AZ_GearDialog_fnc_getUnit;
				private _takedItem = [_unit, _dragSlotID] call AZ_Unit_fnc_takeGear;
				if (isNil '_takedItem') exitWith { ERROR("Cant taked item"); };
				_takeData = [_takedItem];
				[_display, _dragSlotID] call AZ_GearDialog_fnc_Gear_OnSlotChanged;
			};					
			case GEAR_SLOT_ID_WEAPON_PRIMARY_MAG_0:
			{
				0 call _fnc_takePrimaryWeaponMag;				
			};
			case GEAR_SLOT_ID_WEAPON_PRIMARY_MAG_1:
			{
				1 call _fnc_takePrimaryWeaponMag;				
			};
			default {ERROR_NO_IMPLEMENTATION;};
		};
	};
	case GEAR_DIALOG_LEFT_CONTAINER_IDC:
	{
		private _container = [_display, _dragSlotParentIDC] call AZ_GearDialog_fnc_Container_getData;
		if (isNil "_container") exitWith {};
		private _itemID = _dragSlotID - _dragSlotParentIDC;
		_itemID = FLOOR_10(_itemID);
		_takeData = [_container, _itemID, ITEM_STACK_MAX] call AZ_ItemsContainer_fnc_takeItem;
		//_takeData params ["_item", "_isDeleted", "_rect"];
		//if (not _isDeleted) then { ERROR("Taked item must be deleted");	};
		//_takedItem = _item;
		//_takedItemSlotRect = _rect;
		[_display, _dragSlotID] call AZ_GUI_fnc_ItemSlot_Delete;		
		
	};
	case GEAR_DIALOG_UNIFORM_CONTAINER_IDC;
	case GEAR_DIALOG_VEST_CONTAINER_IDC;
	case GEAR_DIALOG_BACKPACK_CONTAINER_IDC:
	{
		private _gearSlotID = switch (_dragSlotParentIDC) do 
		{
			case GEAR_DIALOG_UNIFORM_CONTAINER_IDC:{GEAR_SLOT_ID_UNIFORM};	
			case GEAR_DIALOG_VEST_CONTAINER_IDC:{ GEAR_SLOT_ID_VEST};	
			case GEAR_DIALOG_BACKPACK_CONTAINER_IDC:{GEAR_SLOT_ID_BACKPACK};		
		};			
		private _itemID = _dragSlotID - _dragSlotParentIDC;
		_itemID = FLOOR_10(_itemID);		
		private _unit = _display call AZ_GearDialog_fnc_getUnit;
		_takeData = [_unit, _gearSlotID, _itemID, ITEM_STACK_MAX] call AZ_Unit_fnc_takeItem;
		// _takeData params ["_item", "_isDeleted", "_rect"];
		// if (not _isDeleted) then { ERROR("Taked item must be deleted");	};
		// _takedItem = _item;
		// _takedItemSlotRect = _rect;
		[_display, _dragSlotID] call AZ_GUI_fnc_ItemSlot_Delete;	
		[_display, _gearSlotID] call AZ_GearDialog_fnc_Gear_UpdateSlot;		
	};
	default {ERROR_NO_IMPLEMENTATION;};
};

//if (isNil '_takeData') then { ERROR("Take item fail"); };

_takeData
