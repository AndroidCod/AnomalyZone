//
#define TRACE_MODE
#include "..\macros.hpp"

disableSerialization;

params ["_display", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

if (isNull _display) exitWith { false };

if (_button == 0) exitWith // MOUSE_LEFT_BUTTON
{
	// 
	([_display] call AZ_GearDialog_fnc_ctrlAtMouse) params ["_slotID", "_slotParentIDC"];
	
	if (_slotID != 0 and {_slotID != _slotParentIDC}) then
	{
		//private _display = ctrlParent _control;
		private _dragStatus = _display getVariable ["AZ_drag_status", nil];
		if (isNil "_dragStatus") then
		{
			_dragStatus = [0];
			_display setVariable ["AZ_drag_status", _dragStatus];
		};
		_dragStatus set [0, 1];
		_dragStatus set [1, _xPos];
		_dragStatus set [2, _yPos];		
		_dragStatus set [3, _slotID];// slotID
		_dragStatus set [4, _display];// display
		_dragStatus set [5, _slotParentIDC];
		//_dragStatus params ["_status", "_dx", "_dy", "_slotID", "_display", "_controlsGroup"];
	};
	
	true
};
if (_button == 1) exitWith // MOUSE_RIGHT_BUTTON
{
	private _dragStatus = _display getVariable ["AZ_drag_status", nil];
	if (not isNil "_dragStatus" and {(_dragStatus#0) == 2}) then
	{
		//TRACE("Rotate!");
		private _takedData = _display getVariable "AZ_DragTakedItemData";
		if (not isNil '_takedData') then 
		{
			_takedData params ["", "_dragItem"];
			if (isNil '_dragItem') exitWith {};			
			if (_dragItem call AZ_Item_fnc_slotRotate) then // quad not rotate
			{				
				// recreate temp slot for DragADrop
				[_display, GEAR_DIALOG_DRAG_SLOT_IDC] call AZ_GUI_fnc_ItemSlot_Delete;
				private _pos = [_display, _dragItem] call AZ_GearDialog_fnc_getSlotRectAtMousePos;
				[_display, nil, GEAR_DIALOG_DRAG_SLOT_IDC, _dragItem, _pos] call AZ_GearDialog_fnc_createItemSlot;
			};
		};
	};

	true
};
false