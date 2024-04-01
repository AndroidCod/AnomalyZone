// AZ_GearDialog_fnc_ctrlAtMouse

#define TRACE_MODE
#include "..\macros.hpp"

params ["_display"];

private _ctrl = (_display ctrlAt getMousePosition);
private _ctrlIDC = 0;
private _parentIDC = 0;

private _fnc_checkControlsGroup = 
{
	//params ["_display", "_ctrl"];
	
	private _atSlotID = 0;
	
	private _container = [_display, _ctrlIDC] call AZ_GearDialog_fnc_Container_getData;
	if (isNil "_container") exitWith {0};
	
	(_display getVariable "GRID") params ["", "", "_GRID_W", "_GRID_H"];
	//private _mapRect = _container get "rect";
	//_mapRect params ["_mapX", "_mapY", "_mapW", "_mapH"];
	private _mousePos = ctrlMousePosition _ctrl;	
	_mousePos set [0, ((POS_X(_mousePos) / _GRID_W))];
	_mousePos set [1, ((POS_Y(_mousePos) / _GRID_H))];
	
	_atSlotID = [_container, _mousePos] call AZ_GUI_fnc_IMap_getSlotAtPos;
	if (_atSlotID <= 0) exitWith {0};
	_atSlotID = _ctrlIDC + _atSlotID;
	
	_atSlotID	
};
	
if (not isNull _ctrl) then
{		
	_ctrlIDC = ctrlIDC _ctrl;
	_ctrlIDC = FLOOR_10(_ctrlIDC);
	switch (_ctrlIDC) do 
	{
		case GEAR_DIALOG_LEFT_CONTAINER_IDC;
		case GEAR_DIALOG_UNIFORM_CONTAINER_IDC;
		case GEAR_DIALOG_VEST_CONTAINER_IDC;
		case GEAR_DIALOG_BACKPACK_CONTAINER_IDC:
		{
			_parentIDC = _ctrlIDC;
		};
		//default { ERROR_NO_IMPLEMENTATION; };
	};
	
	if (_parentIDC != 0) then
	{
		private _atSlotID = (0 call _fnc_checkControlsGroup);
		if (_atSlotID != 0) then 
		{
			_ctrlIDC = _atSlotID;
			//player globalChat format ["drop on slot=%1 group=%2", _atSlotID, ctrlIDC _ctrl];
		};
	};		
};

[_ctrlIDC, _parentIDC]
