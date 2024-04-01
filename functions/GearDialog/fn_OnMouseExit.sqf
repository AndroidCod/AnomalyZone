// AZ_GearDialog_fnc_OnMouseExit = 

params ["_display", "_ctrlIDC", "_parentIDC"];
//systemChat format ['<<<--- [%1:%2]', _ctrlIDC, _parentIDC]; 

if (isNull _display) exitWith { false };

private _ctrl = _display displayCtrl _ctrlIDC + 0;
_ctrl ctrlSetTextColor [0.5, 0.5, 0.5, 1];
_ctrl ctrlCommit 0;

true
