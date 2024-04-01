// AZ_GUI_fnc_IMap_findEmptyPos 

//#define TRACE_MODE
#include "..\macros.hpp"

params ["_IMap", "_item"];

// check free space
(_item call AZ_Item_fnc_getSlotSize) params ["_slotSizeW", "_slotSizeH"];
private _freeSpace = ((_IMap get "space") select 0);
//_space params ["_free", "_total"];
if (_freeSpace < (_slotSizeW*_slotSizeH)) exitWith {};

//
//private _mapRect = _IMap get "rect";
(_IMap get "rect") params ["_mapX", "", "_mapW"];
private _stride = (_mapX + _mapW);
private _cellsList = _IMap get "cells";
private _slotRect = [0, 0, _slotSizeW, _slotSizeH];
private _ret = false;
{
	if (_x == 0) then
	{		
		_slotRect set [0, (floor(_forEachIndex % _stride))];
		_slotRect set [1, (floor(_forEachIndex / _stride))];
		_ret = ([_IMap, _slotRect] call AZ_GUI_fnc_IMap_isRectEmpty);
	};
	if (_ret) exitWith {};
	
} forEach _cellsList;

if (not _ret) exitWith {};

_slotRect
