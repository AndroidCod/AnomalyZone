// AZ_GUI_fnc_ItemSlot_Update 

#define TRACE_MODE
#include "..\macros.hpp"

params ["_display", "_slotID", ["_item", nil]];

if (isNull _display) exitWith {};
/*
	slot layers:
		0 - SlotID, all iteraction(DragAndDrop, Click, ...) 
		1 - Frame
		2 - StructuredText 
		3 - 
		4 - 
		5 - 
		6 - 
		7 - item picture
		8 - 
		9 - 

*/

private _picture = "";
private _text = ["", ""];
private _backColor = [1,1,1,0];
//private _angle = 0;
if (not isNil "_item") then 
{
	private _itemConfig = _item get "config";
	
	_picture = (_itemConfig get "picture");
	_text = _item call AZ_Item_fnc_toText;
	_backColor = [3/255, 173/255, 252/255, 0.05];
	
	switch (_itemConfig get "type") do
	{
		case ITEM_TYPE_MAGAZINE: 
		{
			_picture = _item call AZ_Item_fnc_Magazine_getPicture;
		};
		case ITEM_TYPE_WEAPON_SECONDARY;
		case ITEM_TYPE_WEAPON_HANDGUN;
		case ITEM_TYPE_WEAPON_PRIMARY:
		{
			private _fnc_weaponItemUpdate = 
			{
				params ["_id", "_type"];
				
				private _ctrl = _display displayCtrl (_slotID + _id);
				private _optic = _item get _type;
				if (isNil '_optic') exitWith 
				{
					_ctrl ctrlSetText "";
					_ctrl ctrlCommit 0;
				};			
				_ctrl ctrlSetText (_optic get "config" get "picture");
				_ctrl ctrlCommit 0;
			};
			[4, ITEM_TYPE_WEAPON_MUZZLE] call _fnc_weaponItemUpdate;
			[5, ITEM_TYPE_WEAPON_OPTIC] call _fnc_weaponItemUpdate;
			[6, ITEM_TYPE_WEAPON_POINTER] call _fnc_weaponItemUpdate;
			[7, ITEM_TYPE_WEAPON_BIPOD] call _fnc_weaponItemUpdate;

		};
	};	
}
else
{
	private _ctrl = _display displayCtrl (_slotID + 4);
	_ctrl ctrlSetText "";
	_ctrl ctrlCommit 0;	
	_ctrl = _display displayCtrl (_slotID + 5);
	_ctrl ctrlSetText "";
	_ctrl ctrlCommit 0;
	_ctrl = _display displayCtrl (_slotID + 6);
	_ctrl ctrlSetText "";
	_ctrl ctrlCommit 0;
	_ctrl = _display displayCtrl (_slotID + 7);
	_ctrl ctrlSetText "";
	_ctrl ctrlCommit 0;
};


private _ctrl = _display displayCtrl _slotID + 9;
_ctrl ctrlSetBackgroundColor _backColor;
_ctrl ctrlCommit 0;

_ctrl = _display displayCtrl _slotID + 8;
_ctrl ctrlSetText _picture;
_ctrl ctrlCommit 0;

_ctrl = _display displayCtrl _slotID + 3;
_ctrl ctrlSetStructuredText parseText (_text#1);
_ctrl ctrlCommit 0;

_ctrl = _display displayCtrl _slotID + 2;
_ctrl ctrlSetStructuredText parseText (_text#0);
_ctrl ctrlCommit 0;

ctrlSetFocus (_display displayCtrl _slotID + 2);