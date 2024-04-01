// AZ_Item_fnc_getSlotSize 

// #define TRACE_MODE
// #include "..\macros.hpp"

params ["_item"];

((_item get "config") get "slotSize") params ["_slotW", "_slotH"];
private _a = (_item get "slotRotation");
//TRACE_1("%1", _a);
assert (_a == 0 or {_a == 90});

if (_a != 0) exitWith { [_slotH, _slotW] };
[_slotW, _slotH]


