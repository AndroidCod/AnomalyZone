#define CT_CONTROLS_GROUP   15

disableSerialization;

params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

if (_button == 0) then // mouse button left
{
	private _display = ctrlParent _control;
	private _dragStatus = _display getVariable ["AZ_drag_status", nil];
	if (not isNil "_dragStatus") then
	{
		if (_dragStatus#0 == 1) then
		{
			_dragStatus set [0, 0];
		};
		if (_dragStatus#0 == 2) then
		{
			_dragStatus set [0, 0];
			
			private _handler = _display getVariable ["OnDrop", nil];
			if (not isNil "_handler") then 
			{
				_dragStatus call _handler;
			};			
		};
	};
};

false
