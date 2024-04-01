// AZ_GUI_fnc_ItemsMap_deleteItem 

//#define TRACE_MODE
#include "..\macros.hpp"

params ["_ItemsMap", "_itemID", "_item"];
/*
private _slots = _ItemsMap get "itemSlots";
private _slotRect = _slots get _itemID;
if (isNil '_slotRect') exitWith { ERROR("Slot rect exist"); };

private _groupID = 0;
private _sortMode = _ItemsMap get "sortMode";
if (_sortMode == 1) then 
{
	_groupID = ((_item get "config") get "group");
};
private _group = [_ItemsMap, _groupID] call AZ_GUI_fnc_ItemsMap_getGroup;

private _freeSpaceList = _group get "freeList";
[_freeSpaceList, _slotRect] call AZ_GUI_fnc_EmptySpace_addRect;

_slots deleteAt _itemID;

_slotRect
*/

private _groupID = 0;
private _sortMode = _ItemsMap get "sortMode";
if (_sortMode == 1) then 
{
	_groupID = ((_item get "config") get "group");
};
private _group = [_ItemsMap, _groupID] call AZ_GUI_fnc_ItemsMap_getGroup;
if (isNil "_group") exitWith {};

private _slots = _group get "itemSlots";
private _slotRect = _slots get _itemID;
if (isNil "_slotRect") exitWith { ERROR("Slot rect exist in ItemsMap"); nil};

private _freeSpaceList = _group get "freeList";
[_freeSpaceList, _slotRect] call AZ_GUI_fnc_EmptySpace_addRect;

_slots deleteAt _itemID;

_slotRect


