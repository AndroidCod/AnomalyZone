// AZ_GearDialog_fnc_Container_takeItem

#include "..\macros.hpp"

params ["_display", "_containerIDC", "_slotID", ["_count", ITEM_STACK_MAX]];

if (isNull _display) exitWith {};

private _container = [_display, _containerIDC] call AZ_GearDialog_fnc_Container_getData;
if (isNil "_container") exitWith {};

private _itemID = _slotID - _containerIDC;
_itemID = FLOOR_10(_itemID);

//TRACE_1("%1", _itemID);


// take item from container
// private _slotRect = +([_container, _itemID] call AZ_ItemsContainer_fnc_getItemSlotRect);
private _takeData = [_container, _itemID, _count] call AZ_ItemsContainer_fnc_takeItem;
_takeData params ["_item", "_isDeleted", "_slotRect"];

if (_isDeleted) then
{
	// slot
	// !!! Using ctrlDelete in a UI eventhandler called by the to be deleted control will CRASH THE GAME! 
	// This also happens when a controls group is deleted that contains the "calling" control.
	//[AZ_GUI_fnc_ItemSlot_Delete, _this] call CBA_fnc_execNextFrame;
	[_display, _slotID] call AZ_GUI_fnc_ItemSlot_Delete;
}
else
{
	//_slotRect = nil;
	// update slot
	private _it = [_container, _itemID] call AZ_ItemsContainer_fnc_getItem; 
	[_display, _slotID, _it] call AZ_GUI_fnc_ItemSlot_Update;
};

// Update gear slot by
[_display, _containerIDC] call AZ_GearDialog_fnc_Gear_UpdateSlotByContainer;

_takeData
