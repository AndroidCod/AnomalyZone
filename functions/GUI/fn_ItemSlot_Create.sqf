// AZ_GUI_fnc_ItemSlot_Create 

#define TRACE_MODE
#include "..\macros.hpp"

params ["_display", "_slotID", "_item", ["_controlsGroup", controlNull]];

if (isNull _display) exitWith {};
/*
	slot layers:
		0 - azFrame
		1 - 
		2 - azStructuredText_Slot 
		3 - azStructuredText_Slot
		4 - azPicture/azPicture90
		5 - azPicture/azPicture90
		6 - azPicture/azPicture90
		7 - azPicture/azPicture90
		8 - azPicture/azPicture90
		9 - azStaticText

*/

private _fnc_createPicture = 
{
	params ["_id"];
	if (_item get "slotRotation" == 0) then 
	{
		_ctrl = _display ctrlCreate [missionConfigFile >> "azPicture", _slotID + _id, _controlsGroup];
	}
	else
	{
		_ctrl = _display ctrlCreate [missionConfigFile >> "azPicture90", _slotID + _id, _controlsGroup];
	};
};

private _itemConfig = _item get "config";
// private _ctrl = _display ctrlCreate [missionConfigFile >> "azPictureKeepAspectAllowPixelSplit", _slotID + 7, _controlsGroup];
private _ctrl = _display ctrlCreate [missionConfigFile >> "azStaticText", _slotID + 9, _controlsGroup];

//_ctrl = _display ctrlCreate [missionConfigFile >> "azPictureKeepAspect", _slotID + 7, _controlsGroup];
[8] call _fnc_createPicture;
//_ctrl ctrlCommit 0;

switch (_itemConfig get "type") do 
{
	case ITEM_TYPE_WEAPON_SECONDARY;
	case ITEM_TYPE_WEAPON_HANDGUN;
	case ITEM_TYPE_WEAPON_PRIMARY:
	{
		[7] call _fnc_createPicture;
		[6] call _fnc_createPicture;
		[5] call _fnc_createPicture;
		[4] call _fnc_createPicture;
	};
};


_ctrl = _display ctrlCreate [missionConfigFile >> "azStructuredText_Slot", _slotID + 3, _controlsGroup];
_ctrl = _display ctrlCreate [missionConfigFile >> "azStructuredText_Slot", _slotID + 2, _controlsGroup];
//_ctrl ctrlCommit 0;	

_ctrl = _display ctrlCreate [missionConfigFile >> "azFrame", _slotID + 0, _controlsGroup];
//_ctrl ctrlCommit 0;

//_ctrl = _display ctrlCreate [missionConfigFile >> "azDragAndDrop", _slotID + 0, _controlsGroup];
//_ctrl ctrlCommit 0;



//[_display] call AZ_GearDialog_fnc_checkSlotFocus;
