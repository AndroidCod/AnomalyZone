
// make controls
// AZ_GearDialog_fnc_fillControlsGroup = 

//#define TRACE_MODE
//#include "..\macros.hpp"

params ["_display", "_ctrlGroupIDC"];

//player sideChat format ["%1", _display];
if (isNull _display) exitWith {};

private _container = [_display, _ctrlGroupIDC] call AZ_GearDialog_fnc_Container_getData;
if (isNil "_container") exitWith {};

private _ctrlGroup = _display displayCtrl _ctrlGroupIDC;
// (_display get "GRID") params ["_GRID_X", "_GRID_Y", "_GRID_W", "_GRID_H"];
//(_display getVariable "GRID") params ["", "", "_GRID_W", "_GRID_H"];

private _slots = _container get "itemSlots";
{
	if (isNull _display) exitWith {};
	
	private _id = _x;
	private _slotRect = _y;
	//TRACE_1("%1", _slotRect);
	private _idc = _ctrlGroupIDC + _id;	
	private _item = [_container, _id] call AZ_ItemsContainer_fnc_getItem;
	[_display, _ctrlGroup, _idc, _item, _slotRect] call AZ_GearDialog_fnc_createItemSlot;
	
} forEach _slots;


