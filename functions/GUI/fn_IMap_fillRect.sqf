// AZ_GUI_fnc_IMap_fillRect =

//#define TRACE_MODE
#include "..\macros.hpp"

params ["_IMap", "_rect", "_id"];

//TRACE_1("fill: %1", _rect);

private _mapRect = _IMap get "rect";
_mapRect params ["_mapX", "_mapY", "_mapW", "_mapH"];
private _stride = (_mapX + _mapW);

_rect params ["_rectX", "_rectY", "_rectW", "_rectH"];

private _rigth = (_rectX + _rectW);
private _bottom = (_rectY + _rectH);

//assert (_rectX >= _mapX and {_rigth <= (_mapX + _mapW)});
//assert (_rectY >= _mapY and {_bottom <= (_mapY + _mapH)});

if (_rectX < _mapX or {_rigth > _stride}) exitWith {ERROR("slot rect out of range map rect");};
if (_rectY < _mapY or {_bottom > (_mapY + _mapH)}) exitWith {ERROR("slot rect out of range map rect");};

private _cellsList = _IMap get "cells";
for [{_iy=_rectY}, {_iy < _bottom}, {_iy=_iy+1}] do
{
	private _sY = _iy * _stride;
	for [{_ix=_rectX}, {_ix < _rigth}, {_ix=_ix+1}] do
	{
		private _index = _sY + _ix;
		assert (_index >= 0 and {_index < count _cellsList});
		_cellsList set [_index, _id];
	};
};

// calc free space data
private _sign = if (_id == 0) then {1} else {-1};
private _space = _IMap get "space";
_space params ["_free", "_total"];
_free = _free + (_rectW * _rectH * _sign);
//assert (_free >= 0 and {_free <= _total});
if ((_free < 0) or {_free > _total}) exitWith { ERROR("'IMap' have invalid free space data"); };
_space set [0, _free];
