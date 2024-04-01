//[_display, _containerIDC] call AZ_GearDialog_fnc_Container_update;

// #define TRACE_MODE
// #include "..\macros.hpp"

params ["_display", "_containerIDC"];

if (isNull _display) exitWith {};

// private _container = [_display, _containerIDC] call AZ_GearDialog_fnc_Container_getData;
private _container = _this call AZ_GearDialog_fnc_Container_getData;

if (isNil "_container") then 
{
	private _rect = [0, 0, 0, 0];
	private _ctrl = _display displayCtrl _containerIDC + 1;
	_ctrl ctrlSetPosition _rect;
	_ctrl ctrlCommit 0;
	
	_ctrl = _display displayCtrl _containerIDC + 2;
	_ctrl ctrlSetPosition _rect;
	_ctrl ctrlCommit 0;
	
	// clear controls group
	// [_display, _containerIDC] call AZ_GearDialog_fnc_clearControlsGroup;
	_this call AZ_GearDialog_fnc_clearControlsGroup;
}
else
{
	(_container get "rect") params ["_mapX", "_mapY", "_mapW", "_mapH"];
	(_display getVariable "GRID") params ["", "", "_GRID_W", "_GRID_H"];
	private _rect = [_mapX * _GRID_W, _mapY * _GRID_H, _mapW * _GRID_W, _mapH * _GRID_H];
	
	private _ctrl = _display displayCtrl _containerIDC + 1;
	_ctrl ctrlSetPosition _rect;
	_ctrl ctrlCommit 0;
	
	_ctrl = _display displayCtrl _containerIDC + 2;
	_ctrl ctrlSetPosition _rect;
	_ctrl ctrlCommit 0;
	
	// [_display, _containerIDC] call AZ_GearDialog_fnc_fillControlsGroup;
	_this call AZ_GearDialog_fnc_fillControlsGroup;
};