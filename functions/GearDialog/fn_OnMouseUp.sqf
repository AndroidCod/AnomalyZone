//
disableSerialization;

params ["_display", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

private _eventDone = false;
if (_button == 0) then // mouse button left
{
	//private _display = ctrlParent _control;
	private _dragStatus = _display getVariable "AZ_drag_status";
	if (not isNil "_dragStatus") then
	{
		if (_dragStatus#0 == 1) exitWith
		{
			_dragStatus set [0, 0];
			_eventDone = true;
		};
		if (_dragStatus#0 == 2) then
		{
			_dragStatus set [0, 0];
			_eventDone = _dragStatus call AZ_GearDialog_fnc_OnDrop;		
		};
	};
};

_eventDone
