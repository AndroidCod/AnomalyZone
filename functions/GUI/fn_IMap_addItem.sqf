// AZ_GUI_fnc_IMap_addItem = 

//#define TRACE_MODE
//#include "..\macros.hpp"

params ["_IMap", "_itemID", "_item"];

// check free space
(_item call AZ_Item_fnc_getSlotSize) params ["_slotSizeW", "_slotSizeH"];
private _freeSpace = ((_IMap get "space") select 0);
//_space params ["_free", "_total"];
if (_freeSpace < (_slotSizeW*_slotSizeH)) exitWith {};

//
private _mapRect = _IMap get "rect";
_mapRect params ["_mapX", "", "_mapW"];
private _stride = (_mapX + _mapW);

private _cellsList = _IMap get "cells";
private _slotRect = nil;
{
	if (_x == 0) then
	{
		//private _i = _forEachIndex;
		//private _ix = floor(_i % _mapW); 
		//private _iy = floor(_i / _mapW);
		private _pos = [floor(_forEachIndex % _stride), floor(_forEachIndex / _stride)];
		_slotRect = [_IMap, _itemID, _item, _pos] call AZ_GUI_fnc_IMap_addItemAtPos;
	};
	if (not isNil "_slotRect") exitWith {};
	
} forEach _cellsList;

_slotRect


//int x = i % w;
//int y = i / w;

