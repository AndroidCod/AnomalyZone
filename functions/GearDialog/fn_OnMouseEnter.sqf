// AZ_GearDialog_fnc_OnMouseEnter = 

#define TRACE_MODE
#include "..\macros.hpp"

params ["_display", "_ctrlIDC", "_parentIDC"];

if (isNull _display) exitWith { false };

private _ctrl = _display displayCtrl _ctrlIDC + 0;
_ctrl ctrlSetTextColor [1, 1, 1, 1];
_ctrl ctrlCommit 0;

true
