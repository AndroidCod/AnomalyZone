// AZ_GearDialog_fnc_createItemSlot

#define TRACE_MODE
#include "..\macros.hpp"

params ["_display", "_ctrlGroup", "_idc", "_item", "_slotRect"];

[_display, _idc, _item, _ctrlGroup] call AZ_GUI_fnc_ItemSlot_Create;

(_display getVariable "GRID") params ["", "", "_GRID_W", "_GRID_H"];
/*private _pos = [
	((RECT_X(_slotRect) + GEAR_SLOT_PAD) * _GRID_W),
	((RECT_Y(_slotRect) + GEAR_SLOT_PAD) * _GRID_H),
	((RECT_W(_slotRect) - GEAR_SLOT_PAD) * _GRID_W),
	((RECT_H(_slotRect) - GEAR_SLOT_PAD) * _GRID_H)
];*/
private _pos = [
	((RECT_X(_slotRect)) * _GRID_W),
	((RECT_Y(_slotRect)) * _GRID_H),
	((RECT_W(_slotRect)) * _GRID_W),
	((RECT_H(_slotRect)) * _GRID_H)
];
[_display, _idc, _pos, _item] call AZ_GUI_fnc_ItemSlot_SetPosition;
[_display, _idc, _item] call AZ_GUI_fnc_ItemSlot_Update;