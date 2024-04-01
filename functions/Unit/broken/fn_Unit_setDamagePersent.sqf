/**********************************************************************************
	Class Unit
/**********************************************************************************/
#include "..\..\macros.hpp"

params ["_unit", "_source", "_damagePersent"];	

//player globalChat format ["[%1] %2 - %3|%4", diag_frameNo,  _unit, _source, _damagePersent];

private _unitStat = [_unit] call az_fnc_Unit_getStat;
[_unit, _source, _damagePersent * __AZ_UNIT_getMaxHP(_unitStat)] call az_fnc_Unit_setDamage;






