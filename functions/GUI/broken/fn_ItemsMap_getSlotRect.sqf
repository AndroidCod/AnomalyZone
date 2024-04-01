// AZ_GUI_fnc_ItemsMap_getSlotRect  

//#define TRACE_MODE
#include "..\macros.hpp"

params ["_ItemsMap", "_itemID", "_item"];
/*
private _itemSlotList = _ItemsMap get "itemSlots";
private _rect = _itemSlotList get _itemID;
if (isNil '_rect') exitWith { ERROR("Slot rect exist"); };

_rect
*/

private _groupID = 0;
private _sortMode = _ItemsMap get "sortMode";
if (_sortMode == 1) then 
{
	_groupID = ((_item get "config") get "group");
};
private _group = [_ItemsMap, _groupID] call AZ_GUI_fnc_ItemsMap_getGroup;
if (isNil "_group") exitWith {};

private _groupRect = _group get "rect";	
private _slots = _group get "itemSlots";
private _slotRect = _slots get _itemID;
if (isNil "_slotRect") exitWith { ERROR("slotRect exist in ItemsMap"); nil};

[(RECT_X(_groupRect) + RECT_X(_slotRect)),
 (RECT_Y(_groupRect) + RECT_Y(_slotRect)),
  RECT_W(_slotRect),
  RECT_H(_slotRect) ]	
