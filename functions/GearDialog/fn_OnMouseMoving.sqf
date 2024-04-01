
disableSerialization;

params ["_display", "_deltaX", "_deltaY"];

if (isNull _display) exitWith { false };
//systemChat format ['focused [%1]', focusedCtrl _display]; 
//[_display] call AZ_GearDialog_fnc_checkSlotFocus;

private _eventDone = false;
private _dragStatus = _display getVariable "AZ_drag_status";
if (not isNil "_dragStatus") then
{
	if (_dragStatus#0 == 1) exitWith
	{
		//private _deltaX = abs(_xPos - _dragStatus#1);
		//private _deltaY = abs(_yPos - _dragStatus#2);
		if (((abs(_deltaX)) > 0.0025) or {(abs(_deltaY)) > 0.004}) then
		{
			//systemChat format ['onDrag']; 
			if (_dragStatus call AZ_GearDialog_fnc_OnDrag) then 
			{
				_dragStatus set [0, 2];
			};
		};
		_eventDone = true;
	};

	if (_dragStatus#0 == 2) exitWith
	{
		_eventDone = _dragStatus call AZ_GearDialog_fnc_OnDragMove;
	};

};

if (not _eventDone) then
{
	// Mouse Enter/Exit
	(_display getVariable ["AZ_GearDialog_MouseEnterControlID", [0, 0]]) params ["_ctrlEnterID", "_ctrlEnterParentID"];
	([_display] call AZ_GearDialog_fnc_ctrlAtMouse) params ["_slotID", "_slotParentIDC"];
	
	if (_ctrlEnterID != 0 and {_slotID != _ctrlEnterID}) then
	{
		_display setVariable ["AZ_GearDialog_MouseEnterControlID", [0, 0]];
		_eventDone = [_display, _ctrlEnterID, _ctrlEnterParentID] call AZ_GearDialog_fnc_OnMouseExit;
	};
	if (_slotID != 0 and {_slotID != _ctrlEnterID}) then
	{
		_display setVariable ["AZ_GearDialog_MouseEnterControlID", [_slotID, _slotParentIDC]];
		_eventDone = [_display, _slotID, _slotParentIDC] call AZ_GearDialog_fnc_OnMouseEnter;
	};

	// 0 = 0
	// 1 = 0 exit 
	// 1 = 1 
	// 1 != 1 exit and enter
	// 0 = 1 enter
};

/*
if (not _eventDone) then
{
	
};
*/
_eventDone
