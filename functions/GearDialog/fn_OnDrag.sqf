#include "..\macros.hpp"

//player globalChat format ["OnDrag %1", _this];

params ["_status", "_dx", "_dy", "_slotID", "_display", "_controlsGroupIDC"];

if (isNull _display) exitWith {false};
if (ctrlIDD _display != GEAR_DIALOG_IDD) exitWith {false}; // drag canceled

private _item = [_display, _slotID] call AZ_GearDialog_fnc_getItemBySlotID;
if (isNil "_item") exitWith { false }; 

// Take item
private _takedData = [_display, _slotID, _controlsGroupIDC] call AZ_GearDialog_fnc_takeItem;
if (isNil '_takedData') exitWith {false};
_takedData params ["_dragItem", "_dragItemIsDeleted", "_dragItemSlotRect"];
//assert (_dragItem isEqualTo _item);
_display setVariable ["AZ_DragTakedItemData", [_display, _dragItem, _slotID, _controlsGroupIDC, _dragItemSlotRect]];

// create temp slot for DragADrop
private _pos = [_display, _dragItem] call AZ_GearDialog_fnc_getSlotRectAtMousePos;
[_display, nil, GEAR_DIALOG_DRAG_SLOT_IDC, _dragItem, _pos] call AZ_GearDialog_fnc_createItemSlot;

true


