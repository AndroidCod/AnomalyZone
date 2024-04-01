
// #define TRACE_MODE
//#include "..\macros.hpp"

params ["_item"];

private _size = _item call AZ_Item_fnc_getSlotSize;
if (_size#0 != _size#1) exitWith // quad not rotate
{
	private _a = (_item get "slotRotation");
	_a = if (_a == 0) then { 90 } else { 0 };
	(_item set ["slotRotation", _a]);
	true
};

false
