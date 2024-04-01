/**********************************************************************************
	Class Unit
/**********************************************************************************/

#include "..\..\macros.hpp"


params ["_unit", "_source", "_damage"];

if (_damage == 0.0) exitWith { };

// apply damage...
private _unitStat = [_unit] call az_fnc_Unit_getStat;
private _hp = __AZ_UNIT_getHP(_unitStat) - _damage;
_hp = CLAMP(_hp, 0.0, __AZ_UNIT_getMaxHP(_unitStat));
__AZ_UNIT_setHP(_unitStat, _hp);

// check for die...
if (_hp <= 0.0 and alive _unit) then
{
	_unit removeEventHandler ["handleDamage", _unit getVariable "AZ_HANDLEDAMAGE_ID"];
	
	if (not isNil "_source" && isPlayer _source && _source != _unit) then 
	{
		[_unit] call az_fnc_Player_killUnit;
	};
	
	_unit setDamage 1;// Kill unit
};	






