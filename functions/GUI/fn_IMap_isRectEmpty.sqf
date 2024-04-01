// AZ_GUI_fnc_IMap_isRectEmpty =

// #define TRACE_MODE
#include "..\macros.hpp"

params ["_IMap", "_rect"];

_rect params ["_rectX", "_rectY", "_rectW", "_rectH"];

// check free space
private _freeSpace = ((_IMap get "space") select 0);
//_space params ["_free", "_total"];
if (_freeSpace < (_rectW*_rectH)) exitWith { false };

private _rigth = (_rectX + _rectW);
private _bottom = (_rectY + _rectH);

// private _mapRect = _IMap get "rect";
(_IMap get "rect") params ["_mapX", "_mapY", "_mapW", "_mapH"];
private _stride = (_mapX + _mapW);

if (_rectX < _mapX or {_rigth > _stride}) exitWith { false };
if (_rectY < _mapY or {_bottom > (_mapY + _mapH)}) exitWith { false };

private _cellsList = _IMap get "cells";
private _ret = true;
for [{_iy=_rectY}, {_iy < _bottom}, {_iy=_iy+1}] do
{
	private _sY = _iy * _stride;
	for [{_ix=_rectX}, {_ix < _rigth}, {_ix=_ix+1}] do
	{
		private _i = _sY + _ix;
		if ((_i >= count _cellsList) or {(_cellsList select _i) != 0}) exitWith {_ret = false;};
	}; 
	if (not _ret) exitWith {};
};
_ret
