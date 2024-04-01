// [_display, _item] call AZ_GearDialog_fnc_Container_addItemAtPos;
#define TRACE_MODE
#include "..\macros.hpp"

params ["_display", "_containerIDC", "_item", "_position"];

if (isNull _display) exitWith {};

private _data = [_display, _containerIDC] call AZ_GearDialog_fnc_Container_getData;
if (isNil "_data") exitWith {};
_data params ["_container", "_ItemsMap"];


// try add slot to map
private _tempID = -1;
private _slotRect = [_ItemsMap, _tempID, _item, _position] call AZ_GUI_fnc_ItemsMap_addItemAtPos;




















// add item to container
//private _container = _ItemsMap get "container";
private _addData = [_container, _item] call AZ_ItemsContainer_fnc_addItem;
if (isNil "_addData") exitWith 
{
	ERROR("Failed add item to container");
	// WARNING: Here we must drop item on ground or something
	nil
};
_addData params ["_itemID", "_stackList"];

// Update stack slots
if (count _stackList > 0) then
{	
	{
		private _id = _x;
		private _it = [_container, _id] call AZ_ItemsContainer_fnc_getItem; 		
		[_display, (_containerIDC + _id), _it] call AZ_GUI_fnc_ItemSlot_Update;
		
	} foreach _stackList;
};

// Create new slot
if (_itemID != 0) then 
{
	// add slot to map
	private _slotRect = [_ItemsMap, _itemID, _item] call AZ_GUI_fnc_ItemsMap_addItem;
	//TRACE_1("%1", _slotRect);
	if (not isNil "_slotRect") then 
	{
		// create slot
		private _ctrlGroup = _display displayCtrl _containerIDC;
		private _idc = (_containerIDC + _itemID);
		[_display, _idc, _item, _ctrlGroup] call AZ_GUI_fnc_ItemSlot_Create;

		_slotRect = [_ItemsMap, _itemID, _item] call AZ_GUI_fnc_ItemsMap_getSlotRect;
		(_display getVariable "GRID") params ["", "", "_GRID_W", "_GRID_H"];
		private _pos = [
			((_slotRect#0 + GEAR_SLOT_PAD) * _GRID_W),
			((_slotRect#1 + GEAR_SLOT_PAD) * _GRID_H),
			((_slotRect#2 - GEAR_SLOT_PAD) * _GRID_W),
			((_slotRect#3 - GEAR_SLOT_PAD) * _GRID_H)
		];
		[_display, _idc, _pos] call AZ_GUI_fnc_ItemSlot_SetPosition;
		
		// update all groups slot controls
		private _groupList = _ItemsMap get "groupsList";
		if (count _groupList > 0) then
		{
			(_ItemsMap get "rect") params ["", "_mapY"];
			private _offsetY = _mapY;			
			private _groupsID = keys _groupList;
			_groupsID sort false;
			private _changed = false;
			{ 
				if (isNull _display) exitWith {};
				private _group = _groupList get _x; 
				private _groupRect = _group get "rect";
				if (_changed or {_group get "sizeChanged"}) then 
				{
					_changed = true;
					_group set ["sizeChanged", false];
					_groupRect set [1, _offsetY];		
					private _slots = _group get "itemSlots";
					{
						private _ID = _x;
						private _slotRect = _y;						
						private _pos = [
							(RECT_X(_groupRect) + RECT_X(_slotRect) + GEAR_SLOT_PAD) * _GRID_W,
							(RECT_Y(_groupRect) + RECT_Y(_slotRect) + GEAR_SLOT_PAD) * _GRID_H,
							(RECT_W(_slotRect) - GEAR_SLOT_PAD) * _GRID_W,
							(RECT_H(_slotRect) - GEAR_SLOT_PAD) * _GRID_H
						];
						[_display, (_containerIDC + _ID), _pos] call AZ_GUI_fnc_ItemSlot_SetPosition;
						
					} forEach _slots;					
					
				};
				_offsetY = _offsetY + RECT_H(_groupRect);
				
			} forEach _groupsID;
		};
	};
}; 

_itemID


