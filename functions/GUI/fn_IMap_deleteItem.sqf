// AZ_GUI_fnc_IMap_deleteItem 

//#define TRACE_MODE
#include "..\macros.hpp"

params ["_IMap", "_itemID"];

private _slots = _IMap get "itemSlots";
private _slotRect = _slots get _itemID;
if (isNil "_slotRect") exitWith { ERROR("Slot rect exist in ItemsMap"); nil};

[_IMap, _slotRect, 0] call AZ_GUI_fnc_IMap_fillRect;

_slots deleteAt _itemID;

_slotRect


