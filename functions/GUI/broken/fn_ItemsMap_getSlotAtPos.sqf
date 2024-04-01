// AZ_GUI_fnc_ItemsMap_getSlotAtPos

//#define TRACE_MODE
//#include "..\macros.hpp"

params ["_ItemsMap", "_pos"];
/*
private _atSlotID = 0;
private _itemSlotList = _ItemsMap get "itemSlots";
{
	private _id = _x;
	private _slotRect = _y;
	if ([_pos, _slotRect] call AZ_fnc_posInRect) exitWith
	{
		_atSlotID = _id;
	};

} forEach _itemSlotList;

_atSlotID
*/

private _atSlotID = 0;
private _groupsList = (_ItemsMap get "groupsList");
{
	//private _gID = _x;
	private _group = _y;
	private _groupRect = _group get "rect";	
	if ([_pos, _groupRect] call AZ_fnc_posInRect) exitWith
	{
		private _slots = _group get "itemSlots";
		if (count _slots > 0) then
		{
			private _p = [((_pos#0) - (_groupRect#0)), ((_pos#1) - (_groupRect#1))];
			{
				private _itemID = _x;
				private _itemRect = _y;
				if ([_p, _itemRect] call AZ_fnc_posInRect) exitWith
				{
					_atSlotID = _itemID;
				};
				
			} forEach _slots;
		};
	};

} forEach _groupsList;

_atSlotID
