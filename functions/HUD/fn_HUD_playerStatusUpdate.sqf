/*
	Author: 4erep

	Description:
		Update player status display control.

	Parameter(s):
		0 (Optional):
			STRING - end name (default: "end1")
			ARRAY in format [endName,ID], will be composed to "endName_ID" string
		1 (Optional): BOOL - true to end mission, false to fail mission (default: true)
		2 (Optional):
			BOOL - true for signature closing shot (default: true)
			NUMBER - duration of a simple fade out to black

	Returns:
		nothing
*/
#include "..\macros.hpp"
//player globalChat "HUD player status update";

disableSerialization;

private _HUD_ID = ("AZ_HUD_PlayerStatus_Layer" call BIS_fnc_rscLayer);
_HUD_ID cutRsc ["AZ_HUD_PlayerStatus", "PLAIN", -1, false];
	
private _display = uiNameSpace getVariable "AZ_HUD_PlayerStatus";
private _unit = player;
private _ctrl = nil;
private _unitStat = _unit getVariable ["AZ_UnitStat", nil];
if (isNil "_unitStat") exitWith{};


// ------------- Update HP... 
private _hp = _unitStat get "hp";

//player globalChat format ["_hp=%1 | _hpT=%2", _hp, _hpT];
_ctrl = _display displayCtrl 1003;
_ctrl progressSetPosition (1 - (getDammage _unit));
_ctrl ctrlCommit 0;

_ctrl = _display displayCtrl 1004;
_ctrl ctrlSetText format ["%1/%2", round ((1 - (getDammage _unit)) * (_hp#1)), round (_hp#1)];
_ctrl ctrlCommit 0;

/*	
if ((_lastStat#2 != _hp) or (_hp_max != _lastStat#3)) then
{
	_lastStat set [2, _hp];
	_lastStat set [3, _hp_max];

	_ctrl = _display displayCtrl 1003;
	_ctrl progressSetPosition (_hp /_hp_max);
					
	_ctrl = _display displayCtrl 1004;
	_ctrl ctrlSetText format ["%1/%2", round _hp, round _hp_max];
};
*/


/*
// ------------- Update Stamina... 
private _stamina = _unit getVariable ["AZ_UNIT_STAMINA", nil];
private _sprintCurrent = _stamina # 0;
private _sprintLimit = _stamina # 1;
if (_sprintCurrent != _lastStat#4 || _sprintLimit != _lastStat#5) then
{
	_lastStat set [4, _sprintCurrent];
	_lastStat set [5, _sprintLimit];
	
	_ctrl = _display displayCtrl 1006;
	_ctrl progressSetPosition ( ((_sprintCurrent/_sprintLimit) min 1) max 0 );
}; 
private _staminaCurrent = _stamina # 2;
private _staminaLimit = _stamina # 3;
if (_staminaCurrent != _lastStat#6 || _staminaLimit != _lastStat#7) then
{
	_lastStat set [6, _staminaCurrent];
	_lastStat set [7, _staminaLimit];
	
	_ctrl = _display displayCtrl 1005;
	_ctrl progressSetPosition ( ((_staminaCurrent/_staminaLimit) min 1) max 0 );
}; 


*/


