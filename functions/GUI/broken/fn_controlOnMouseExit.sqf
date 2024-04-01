params ["_control"];

private _slotID = ctrlIDC _control;
private _display = ctrlParent _control; // display
if (isNull _display) exitWith { false };

private _ctrl = _display displayCtrl _slotID + 1;
_ctrl ctrlSetTextColor [0.5,0.5,0.5,1];
//_ctrl ctrlSetBackgroundColor [1, 1, 1,0];
_ctrl ctrlSetForegroundColor [1, 1, 1,0];
_ctrl ctrlCommit 0;