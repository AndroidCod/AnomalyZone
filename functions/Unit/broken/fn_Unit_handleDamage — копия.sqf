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
//private	_passedDamage = _this # 2; // (damage): Damage to the above selection (sum of dealt and prior damage)
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

if (_hitPoint isEqualTo "") then {
    _hitPoint = "#structural";
};

if (true) exitWith
{
	//systemChat "exiting the main scope = leaving the whole script";
	_damage = if (_selection isEqualTo "") then {(getDammage _unit) *0.1} else {(_unit getHit _hitSelection) *0.1};
	_damage
};

systemChat "exiting the main scope = leaving the whole script";


private _hp = _unit getVariable ["AZ_HITPOINT", []];
if (_hitPoint == "incapacitated") then
{
	//private _test = [_projectile] call az_fnc_getTypeOfDamage;
	//player globalChat format ["[%1] Handle damage: %2|%3", diag_frameno, _test, _projectile];
	//diag_log format ["[%1] %2", diag_frameno, _hp];

	
	private _dmax = 0;
	private _h = [];
	private _total = 0.0;
	{
		//_x params ["", "", "_passedDamage", "", "_projectile", "", "", "_hitPoint"];
		//if (_x#7 != "#structural")then 
		if (_x#7 != "")then 
		{
			if (_x#2 >= _dmax) then
			{
				_h = _x;
				_dmax = _x#2;
			};
			_total = _total + _passedDamage;
		};
	}
	foreach _hp;
	
	private _hname = _h#7;
	// rename hitPoint
	_hname = switch (_hname) do
		{
			case "hitface";
			case "hitneck";
			case "hithead": { "hithead" };
			case "hitpelvis";
			case "hitabdomen";
			case "hitdiaphragm";
			case "hitchest";
			case "hitbody": { "hitbody" };
			case "hitarms";
			case "hithands": { "hithands" };
			//case "hitlegs": { "hitlegs" };
			default { _hname };
		};
	
	_unit setVariable ["AZ_HITPOINT", []];
	//player globalChat format ["[%1] %2", diag_frameno, _this];
	//diag_log format ["[%1] %2", diag_frameno, _h];
	
	private _damType = [_projectile] call az_fnc_getTypeOfDamage;
	switch (_damType) do
	{
		case (__AZ_DAMAGE_TYPE_GRENADE);	
		case (__AZ_DAMAGE_TYPE_EXPLOSIVE);		
		case (__AZ_DAMAGE_TYPE_SHELL);
		case (__AZ_DAMAGE_TYPE_NONE):
		{
			player globalChat format ["[%1] Handle damage: DAMAGE_TYPE_NONE", diag_frameno];
			[_unit, _source, _dmax] call az_fnc_Unit_setDamagePersent;
		};	
		case (__AZ_DAMAGE_TYPE_BULLET):
		{
			player globalChat format ["[%1] Handle damage: DAMAGE_TYPE_BULLET", diag_frameno];
			//урон = максимум(округление(базовый_урон * (1 + случайное_число(-15, 16) * 0.01)) - округление(защита * 0.5), 1)
			private _d = (round(25*(1.0+(-15 + random 30)*0.01)));
			[_unit, _source, _d] call az_fnc_Unit_setDamage;// <--- for test only
			player globalChat format ["[%1] Damage: %2", diag_frameno, _d];
		};	
		default	{player globalChat format ["[%1] Handle damage: SWITCH OPRATOR ERROR", diag_frameno];}; 
	};


	player globalChat format ["[%1] %2 - %3|%4", diag_frameNo,  _hname, _dmax, _total];
}
else
{	

	_hp pushback _this;
	//player globalChat format ["[%1] %2", diag_frameno, _hp];
	_unit setVariable ["AZ_HITPOINT", _hp];

};
/// Damages are stored for "ace_hdbracket" event triggered last


//if (_hitPoint in ["hithead", "hitbody", "hithands", "hitlegs"]) then

//if (_passedDamage > 0.05) then

/******************************************************************************
	// ПОД ВОДОЙ
	// Drowning doesn't fire the EH for each hitpoint so the "ace_hdbracket" code never runs
	// Damage occurs in consistent increments
	if (
		_hitPoint isEqualTo "#structural" &&
		{getOxygenRemaining _unit <= 0.5} &&
		{_damage isEqualTo (_oldDamage + 0.005)}
	) exitWith {
		TRACE_5("Drowning",_unit,_shooter,_instigator,_damage,_newDamage);
		[QEGVAR(medical,woundReceived), [_unit, [[_newDamage, "Body", _newDamage]], _unit, "drowning"]] call CBA_fnc_localEvent;

		0
	};
******************************************************************************/

_passedDamage * 0.1
// very important return zero...
//0

