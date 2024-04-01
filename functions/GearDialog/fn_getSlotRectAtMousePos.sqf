// AZ_GearDialog_fnc_getSlotRectAtMousePos

//#define TRACE_MODE
//#include "..\macros.hpp"

params ["_display", "_item", ["_needRound", false], ["_controlGroupIDC", nil]];

(_display getVariable "GRID") params ["", "", "_GRID_W", "_GRID_H"];
private _mousePos = if (isNil '_controlGroupIDC' or {_controlGroupIDC == 0}) then 
{
	(getMousePosition)
}
else
{ 
	(ctrlMousePosition (_display displayCtrl _controlGroupIDC))
};
_mousePos params ["_posX", "_posY"];
(_item call AZ_Item_fnc_getSlotSize) params ["_slotW", "_slotH"];

_posX = ((_posX/_GRID_W) - _slotW * 0.5);
_posY = ((_posY/_GRID_H) - _slotH * 0.5);
if (_needRound) then 
{
	_posX = round _posX;
	_posY = round _posY;
};

[_posX,	_posY, _slotW, _slotH]