#define TRACE_MODE
#include "..\macros.hpp"

// params ["_status", "_dx", "_dy", "_dragSlotID", "_display", "_dragSlotParentIDC"];
params ["", "", "", "", "_display", ""];

if (isNull _display) exitWith {false};
if (ctrlIDD _display != GEAR_DIALOG_IDD) exitWith {false}; // drag canceled

[_display, GEAR_DIALOG_DRAG_SLOT_IDC] call AZ_GUI_fnc_ItemSlot_Delete;

private _takedData = _display getVariable "AZ_DragTakedItemData";
if (isNil '_takedData') exitWith {false};
_takedData params ["", "_dragItem", "_dragSlotID", "_dragSlotParentIDC", "_dragItemSlotRect"];
if (isNil '_dragItem') exitWith {false};

// Find on drop control or [0, 0]
([_display] call AZ_GearDialog_fnc_ctrlAtMouse) params ["_dropSlotID", "_dropSlotParentIDC"];
//TRACE_4("%1:%2 drop at %3:%4", _dragSlotID, _dragSlotParentIDC, _dropSlotID, _dropSlotParentIDC);

// Detect swap primary weapons
if ((_dropSlotID == GEAR_SLOT_ID_WEAPON_PRIMARY and {_dragSlotID == GEAR_SLOT_ID_WEAPON_SECONDARY}) or 
	{ _dropSlotID == GEAR_SLOT_ID_WEAPON_SECONDARY and {_dragSlotID == GEAR_SLOT_ID_WEAPON_PRIMARY} }) then 
{
	private _dropItem = [_display, _dropSlotID] call AZ_GearDialog_fnc_Gear_getItem;
	if (isNil '_dropItem') exitWith {}; // no need swap
	if (_dragItem get "config" get "type" == ITEM_TYPE_WEAPON_PRIMARY and { _dropItem get "config" get "type" == ITEM_TYPE_WEAPON_PRIMARY }) then
	{
		// swap primary weapons
		// - take dropAt slot
		private _takedData = [_display, _dropSlotID, 0] call AZ_GearDialog_fnc_takeItem;
		if (isNil '_takedData') exitWith { ERROR("taked data must be"); };
		_takedData params ["_takedItem"];
		assert (_takedItem isEqualTo _dropItem);
		
		// - drop At drag slot  
		private _dropDone = [_display, _takedItem, _dragSlotID, 0, nil] call AZ_GearDialog_fnc_dropAt;
		assert (_dropDone);
	};	
};

// Drop at
// calc drop position
private _dropRect = nil;
if (_dropSlotParentIDC != 0) then 
{ 
	_dropRect = [_display, _dragItem, true, _dropSlotParentIDC] call AZ_GearDialog_fnc_getSlotRectAtMousePos;
};
private _dropDone = [_display, _dragItem, _dropSlotID, _dropSlotParentIDC, _dropRect] call AZ_GearDialog_fnc_dropAt;
if (not _dropDone) then
{
	// Back drag item
	// _dropDone = [_dragItem, _dragSlotID, _dragSlotParentIDC, _dragItemSlotRect] call AZ_GearDialog_fnc_dropAt;
	_dropDone = _takedData call AZ_GearDialog_fnc_dropAt;
	if (not _dropDone) then { ERROR("Cant back drag item"); };
};
_display setVariable ["AZ_DragTakedItemData", nil];

true
 
