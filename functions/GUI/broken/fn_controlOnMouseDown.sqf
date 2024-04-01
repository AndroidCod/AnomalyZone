
disableSerialization;

params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

if (_button == 0) exitWith
{
	private _display = ctrlParent _control;
	private _dragStatus = _display getVariable ["AZ_drag_status", nil];
	if (isNil "_dragStatus") then
	{
		_dragStatus = [0];
		_display setVariable ["AZ_drag_status", _dragStatus];
	};
	_dragStatus set [0, 1];
	_dragStatus set [1, _xPos];
	_dragStatus set [2, _yPos];
	_dragStatus set [3, ctrlIDC _control];// slotID
	_dragStatus set [4, ctrlParent _control];// display
	_dragStatus set [5, ctrlParentControlsGroup _control];
	
	//_dragStatus params ["_status", "_dx", "_dy", "_slotID", "_display", "_controlsGroup"];
	
	//player globalChat format ["display[%1]  onDrag:%2", _display, _handler];
	true
};

false
