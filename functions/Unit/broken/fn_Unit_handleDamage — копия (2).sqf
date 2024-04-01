/*
The passed array

_this # 0 (unit): Object the event handler is assigned to
_this # 1 (hitSelection): Name of the selection where the unit was damaged. "" for over-all structural damage, "?" for unknown selections.
_this # 2 (damage): Damage to the above selection (sum of dealt and prior damage)
_this # 3 (source): The source unit that caused the damage
_this # 4 (projectile): Class name of the projectile that inflicted the damage ("" for unknown, such as falling damage)
_this # 5 (hitPartIndex): Hit part index of the hit point, -1 otherwise
_this # 6 (instigator): Person who pulled the trigger
_this # 7 (hitPoint): Hit point Cfg name

Infantry selections

"": The overall damage that determines the damage value of the unit. Unit dies at damage equal to or above 1
"face_hub": Unit dies at damage equal to or above 1
"neck": Unit dies at damage equal to or above 1
"head": Unit dies at damage equal to or above 1
"pelvis": Unit dies at damage equal to or above 1
"spine1": Unit dies at damage equal to or above 1
"spine2": Unit dies at damage equal to or above 1
"spine3": Unit dies at damage equal to or above 1
"body": Unit dies at damage equal to or above 1
"arms": Unit doesn't die with damage to this part
"hands": Unit doesn't die with damage to this part
"legs": Unit doesn't die with damage to this part
*/
/*
_unit = _this # 0;
_hp = _this # 1;

_selection = getText (configFile >> "CfgVehicles" >> (typeOf _unit) >> "HitPoints" >> _hp >> "name");

The passed array
	_this # 0: Unit the EH is assigned to
	_this # 1: Selection (=body part) that was hit
	_this # 2: Damage to the above selection (sum of dealt and prior damage)
	_this # 3: Source of damage (returns the unit if no source)
	_this # 4: Ammo classname of the projectile that dealt the damage (returns "" if no projectile)
Infantry selections
	"": The overall damage that determines the damage value of the unit. Unit dies at damage over 0.9.
	"head_hit": Unit dies at damage over 0.9.
	"body": Unit dies at damage over 0.9.
	"hands": Unit doesn't die with damage to this part.
	"legs": Unit doesn't die with damage to this part.


*/
#include "..\..\macros.hpp"

params ["_unit", "_selection", "_passedDamage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
//private	_unit = 		_this # 0; // (unit): Object the event handler is assigned to
//private	_selection = 	_this # 1;  // (hitSelection): Name of the selection where the unit was damaged. "" for over-all structural damage, "?" for unknown selections.
//private	_passedDamage = _this # 2; // (damage): Damage to the above selection
//private _source = 		_this # 3;  // (source): The source unit that caused the damage
//private _projectile = 	_this # 4; // Class name of the projectile that inflicted the damage ("" for unknown, such as falling damage)
//private _hitIndex = _this # 5; //(hitPartIndex): Hit part index of the hit point, -1 otherwise
//private _instigator = 	_this # 6; //(instigator): Person who pulled the trigger
//private _hitPoint = 	_this # 7; //(hitPoint): Hit point Cfg name

//diag_log format ["[%1] %2", diag_frameno, _this];
//diag_log format ["[%1] %2", diag_frameno, (getDammage _unit)];

// bug, apparently can fire for remote units in special cases
if !(local _unit) exitWith { 0.0 };
// bug, assumed fixed, @todo excessive testing, if nothing happens remove
if (_projectile isEqualType objNull) then 
{
    _projectile = typeOf _projectile;
    _this set [4, _projectile];
};

private _unitStat = [_unit] call az_fnc_Unit_getStat;
private _hpFactor = 100.0/__AZ_UNIT_getMaxHP(_unitStat);
//player globalChat format ["[%1] Unit_getDamage: %2", diag_frameno, _hpFactor];
private _damage = if (_selection isEqualTo "") then {(getDammage _unit)} else {(_unit getHit _selection)};
_damage = _damage + ((_passedDamage min 1.0) * _hpFactor);//(if (isPlayer _unit) then {0.01} else {1})
//player globalChat format ["[%1] Unit_getDamage: %2 | %3", diag_frameno, _damage, _damage];
_damage


