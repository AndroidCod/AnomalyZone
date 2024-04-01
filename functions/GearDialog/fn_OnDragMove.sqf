#include "..\macros.hpp"

params ["_status", "_dx", "_dy", "_slotID", "_display", "_controlsGroupIDC"];

if (isNull _display) exitWith {false};
if (ctrlIDD _display != GEAR_DIALOG_IDD) exitWith {false}; // drag canceled

// (_display get "GRID") params ["_GRID_X", "_GRID_Y", "_GRID_W", "_GRID_H"];

private _takedData = _display getVariable "AZ_DragTakedItemData";
if (not isNil '_takedData') then 
{
	_takedData params ["", "_dragItem"];
	if (isNil '_dragItem') exitWith {};

	// private _ctrlSlot = _display displayCtrl GEAR_DIALOG_DRAG_SLOT_IDC;
	// (ctrlPosition _ctrlSlot) params ["", "", "_slotW", "_slotH"]; 
	// getMousePosition params ["_mousePosX", "_mousePosY"];
	(_display getVariable "GRID") params ["", "", "_GRID_W", "_GRID_H"];
	private _pos = [_display, _dragItem] call AZ_GearDialog_fnc_getSlotRectAtMousePos;
	_pos = [
		(_pos#0)*_GRID_W,
		(_pos#1)*_GRID_H
	];
	[_display, GEAR_DIALOG_DRAG_SLOT_IDC, _pos, _dragItem] call AZ_GUI_fnc_ItemSlot_SetPosition;
};

true
