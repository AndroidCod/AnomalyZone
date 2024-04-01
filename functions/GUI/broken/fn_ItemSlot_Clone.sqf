// AZ_GUI_fnc_ItemSlot_Clone 

params ["_display", "_slotID", "_cloneID", ["_controlsGroup", controlNull]];

if (isNull _display) exitWith {};

// _ctrl = _display ctrlCreate [missionConfigFile >> "azPictureKeepAspect", _slotID + 1, _controlsGroup];
private _ctrl = _display ctrlCreate [missionConfigFile >> "azPictureKeepAspectAllowPixelSplit", _slotID + 3, _controlsGroup];
_ctrl ctrlSetText (_item get "picture"); //((configfile >> "CfgWeapons" >> "rhs_6b5_rifleman_vsr" >> "picture") call BIS_fnc_getCfgData);
_ctrl ctrlCommit 0;

_ctrl = _display ctrlCreate [missionConfigFile >> "azStructuredText_Slot", _slotID + 2, _controlsGroup];
_ctrl ctrlSetStructuredText parseText  (_item call AZ_Item_fnc_toText); //
_ctrl ctrlCommit 0;	

_ctrl = _display ctrlCreate [missionConfigFile >> "azFrame", _slotID + 1, _controlsGroup];
_ctrl ctrlCommit 0;

_ctrl = _display ctrlCreate [missionConfigFile >> "azDragAndDrop", _slotID + 0, _controlsGroup];
_ctrl ctrlCommit 0;
