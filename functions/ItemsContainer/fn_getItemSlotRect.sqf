// private _slotRect = [_container, _itemID] call AZ_ItemsContainer_fnc_getItemSlotRect;

// #define TRACE_MODE
#include "..\macros.hpp"

params ["_container", "_itemID"];

private _slotRect = (_container get "itemSlots") get _itemID;
if (isNil "_slotRect") exitWith { ERROR("Item slot Exist"); nil };

_slotRect
