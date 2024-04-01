// [_display, _item] call AZ_GearDialog_fnc_addItemToContainer;
#define TRACE_MODE
#include "..\macros.hpp"

params ["_display", "_containerIDC", "_item", ["_position", nil]];

if (isNull _display) exitWith {};

private _itemID = nil;

switch (_containerIDC) do 
{
	// Drop on Container
	case GEAR_DIALOG_LEFT_CONTAINER_IDC: // Dro
	{
		private _container = [_display, _containerIDC] call AZ_GearDialog_fnc_Container_getData;
		if (isNil "_container") exitWith {};

		// add item to container
		_itemID = [_container, _item, _position] call AZ_ItemsContainer_fnc_addItem;
		if (isNil "_itemID") exitWith {};

		// create slot
		private _ctrlGroup = _display displayCtrl _containerIDC;
		private _slotRect = [_container, _itemID] call AZ_ItemsContainer_fnc_getItemSlotRect;
		[_display, _ctrlGroup, (_containerIDC + _itemID), _item, _slotRect] call AZ_GearDialog_fnc_createItemSlot;
	};
	case GEAR_DIALOG_UNIFORM_CONTAINER_IDC;
	case GEAR_DIALOG_VEST_CONTAINER_IDC;
	case GEAR_DIALOG_BACKPACK_CONTAINER_IDC: 
	{
		private _gearSlotID = switch (_containerIDC) do 
		{
			case GEAR_DIALOG_UNIFORM_CONTAINER_IDC:{GEAR_SLOT_ID_UNIFORM};	
			case GEAR_DIALOG_VEST_CONTAINER_IDC:{ GEAR_SLOT_ID_VEST};	
			case GEAR_DIALOG_BACKPACK_CONTAINER_IDC:{GEAR_SLOT_ID_BACKPACK};		
		};	
		private _unit = _display call AZ_GearDialog_fnc_getUnit;
		_itemID = [_unit, _gearSlotID, _item, _position] call AZ_Unit_fnc_addItem;
		if (isNil "_itemID") exitWith {};
		
		// create slot
		private _container = [_display, _containerIDC] call AZ_GearDialog_fnc_Container_getData;
		if (isNil "_container") exitWith { ERROR("container is nil"); };
		private _ctrlGroup = _display displayCtrl _containerIDC;
		private _slotRect = [_container, _itemID] call AZ_ItemsContainer_fnc_getItemSlotRect;
		[_display, _ctrlGroup, (_containerIDC + _itemID), _item, _slotRect] call AZ_GearDialog_fnc_createItemSlot;
		
		// Update gear slot
		[_display, _gearSlotID] call AZ_GearDialog_fnc_Gear_UpdateSlot;
	};
	default { ERROR_NO_IMPLEMENTATION; };
};

_itemID
