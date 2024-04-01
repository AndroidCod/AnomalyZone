/**********************************************************************************
	Class Player
/**********************************************************************************/

// добавляем опыт за убийство и все такое
params ["_unit"];

player globalChat format ["[%1] %2 - %3|%4", diag_frameNo, "fnc_Player_killUnit", _unit, "Function have not realisation!"];

/*
	private _expUP = (_unit getVariable["AZ_STAT_LEVEL", nil]) - (player getVariable["AZ_STAT_LEVEL", nil]);
	_expUP =  AZ_EXP_UNIT_KILL * (AZ_HP_UP ^ _expUP);
	_expUP = (_expUP min 93.0) max 0.0;
	[_expUP] call az_fnc_playerAddExp;
	//[0, _expUp] spawn az_fnc_updateHUD_PlayerStatus;
*/





