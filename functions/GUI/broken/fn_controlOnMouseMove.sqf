#include "..\macros.hpp"

disableSerialization;

params ["_control", "_xPos", "_yPos", "_mouseOver"];

private _display = ctrlParent _control;
// private _dragStatus = uiNameSpace getVariable ["AZ_drag_status", nil];
private _dragStatus = _display getVariable ["AZ_drag_status", nil];
if (isNil "_dragStatus") exitWith {false};

//player globalChat format ["[%1] onMouseMooving: %2 (%3)", diag_frameno, _control, _mouseOver ];
if (_dragStatus#0 == 1) exitWith
{
	//private _deltaX = abs(_xPos - _dragStatus#1);
	//private _deltaY = abs(_yPos - _dragStatus#2);
	if (((abs(_xPos - _dragStatus#1)) > 0.0025) or {(abs(_yPos - _dragStatus#2)) > 0.004}) then
	{
		private _handler = _display getVariable ["OnDrag", nil];
		if (not isNil "_handler") then 
		{
			if (_dragStatus call _handler) then 
			{
				ctrlPosition _control params ["_ctrlX", "_ctrlY"]; 
				_dragStatus set [0, 2];
				_dragStatus set [1, _xPos - _ctrlX];
				_dragStatus set [2, _yPos - _ctrlY];
				//uiNameSpace setVariable ["AZ_drag_status", _dragStatus];
				//player globalChat format ["start drag idc=%1", (ctrlIDC _control)];
			};
		};
	};
	true
};
if (_dragStatus#0 == 2) exitWith
{
	private _handler = _display getVariable ["OnDragMove", nil];
	if (not isNil "_handler") then 
	{
		_dragStatus call _handler;
	};
	
	false
	
	//_dragStatus params ["", "", "", "_slotID", "_display", "", "_cloneID"];
	
	//private _ctrl = _display displayCtrl (uiNameSpace getVariable "AZ_GearDialog_DragCtrlIDC"); // dysplay must have special control for DragOnDrop operation
	//_ctrl ctrlShow true;
	
	// private _ctrlSlot = _display displayCtrl _slotID;
	// ctrlPosition _ctrlSlot params ["", "", "_ctrlW", "_ctrlH"]; 
	// getMousePosition params ["_mousePosX", "_mousePosY"];
	////_ctrl ctrlSetPosition [_mousePosX - _dragStatus#1, _mousePosY - _dragStatus#2, _ctrlW, _ctrlH];
	// private _pos = [(_mousePosX - (_ctrlW * 0.5)), (_mousePosY - (_ctrlH * 0.5))];
	// [_display, _cloneID, _pos] call AZ_GUI_fnc_ItemSlot_SetPosition;
	
	//_ctrl ctrlSetPosition [(_mousePosX - (_ctrlW * 0.5)), (_mousePosY - (_ctrlH * 0.5)), _ctrlW, _ctrlH];	
	//_ctrl ctrlSetText (ctrlText (_display displayCtrl ((ctrlIDC _ctrlSlot) + 3)));	
	//_ctrl ctrlSetAngle [90, 0.5, 0.5, false]; // <-- это прекрасно!!!	
	//_ctrl ctrlCommit 0;	
};
//private _display = _dragStatus#4;
//player globalChat format ["move %1 [%2, %3] on:'%4'", (ctrlIDC _control), _xPos, _yPos, (_display ctrlAt [_xPos, _yPos]) ];


false
