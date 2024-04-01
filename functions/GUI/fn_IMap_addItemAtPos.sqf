// AZ_GUI_fnc_IMap_addItemAtPos = 

// #define TRACE_MODE
// #include "..\macros.hpp"

params ["_IMap", "_itemID", "_item", "_pos"];

// check free space
//private _itemConfig = (_item get "config");
(_item call AZ_Item_fnc_getSlotSize) params ["_slotSizeW", "_slotSizeH"];
private _freeSpace = ((_IMap get "space") select 0);
//_space params ["_free", "_total"];
if (_freeSpace < (_slotSizeW*_slotSizeH)) exitWith {};

_pos params ["_posX", "_posY"];	
private _slotRect = [_posX, _posY, _slotSizeW, _slotSizeH];

if ([_IMap, _slotRect] call AZ_GUI_fnc_IMap_isRectEmpty) exitWith
{
	private _slots = _IMap get "itemSlots";
	_slots set [_itemID, _slotRect];
	[_IMap, _slotRect, _itemID] call AZ_GUI_fnc_IMap_fillRect;
	
	_slotRect
};

