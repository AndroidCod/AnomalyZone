#define TRACE_MODE
#include "..\macros.hpp"

params ["_display", "_exitCode"];
//params [["_display", nil]];

[0] call AZ_GUI_fnc_toggleMenuBlur;

// back drag item
private _takedData = _display getVariable "AZ_DragTakedItemData";
if (not isNil '_takedData') then 
{
	// _takedData params ["_dragItem", "_dragSlotID", "_dragSlotParentIDC", "_dragItemSlotRect"];
	// if (isNil '_dragItem') exitWith {};
	// Back drag item
	private _dropDone = _takedData call AZ_GearDialog_fnc_dropAt;
	if (not _dropDone) then { ERROR("Cant back drag item"); };
};


uiNameSpace setVariable ["AZ_GearDialog", nil];
/*
private _cameraParams = uiNameSpace getVariable ["AZ_GearDialog_Camera", []];
// _cameraParams params ["_camera", "_button", "_lastMousePos"];
_cameraParams params ["_camera"];
// end camera part.
player cameraEffect ["terminate", "back"];
// destroy camera.
camDestroy _camera;
*/

