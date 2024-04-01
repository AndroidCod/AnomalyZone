// AZ_GUI_fnc_IMap_getSlotAtPos

//#define TRACE_MODE
//#include "..\macros.hpp"

params ["_ItemsMap", "_pos"];

private _mapRect = _ItemsMap get "rect";
_mapRect params ["_mapX", "_mapY", "_mapW", "_mapH"];
private _stride = (_mapX + _mapW);

_pos params ["_posX", "_posY"];
_posX = floor _posX;
_posY = floor _posY;

if ((_posX < _mapX) or {_posX >= _stride}) exitWith {-1}; 
if ((_posY < _mapY) or {_posY >= (_mapY + _mapH)}) exitWith {-1}; 

//private _i = (_posY * _mapW) + _posX;
//TRACE_1("%1", _pos);

private _cellsList = _ItemsMap get "cells";
private _index = (_posY * _stride) + _posX;
assert (_index >= 0 and {_index < count _cellsList});
_cellsList select _index

