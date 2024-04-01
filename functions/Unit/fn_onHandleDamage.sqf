/*
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

// _selection = getText (configFile >> "CfgVehicles" >> (typeOf _unit) >> "HitPoints" >> _hp >> "name");

#define TRACE_MODE
#include "..\macros.hpp"

params ["_unit", "_selection", "_passedDamage", "_source", "_projectile", "_hitPointIndex", "_instigator", "_hitPoint", "_directHit", "_context"];
//params ["_unit", "_selection", "_passedDamage", "_source", "_projectile", "_hitPointIndex", "_instigator", "_hitPoint"];
//private	_unit = 		_this # 0; // (unit): Object the event handler is assigned to
//private	_selection = 	_this # 1;  // (hitSelection): Name of the selection where the unit was damaged. "" for over-all structural damage, "?" for unknown selections.
//private	_passedDamage = _this # 2; // (damage): Damage to the above selection
//private _source = 		_this # 3;  // (source): The source unit that caused the damage
//private _projectile = 	_this # 4; // Class name of the projectile that inflicted the damage ("" for unknown, such as falling damage)
//private _hitPointIndex = _this # 5; //(hitPartIndex): Hit part index of the hit point, -1 otherwise
//private _instigator = 	_this # 6; //(instigator): Person who pulled the trigger
//private _hitPoint = 	_this # 7; //(hitPoint): Hit point Cfg name
// directHit: Boolean - true for direct projectile damage, false for explosion splash damage and all other kinds of damage like fall damage, fire damage, collision damage, etc.
// context: Number - some additional context for the event:



//diag_log format ["[%1] %2", diag_frameno, _this];
//diag_log format ["[%1] getDammage= %2", diag_frameno, (getDammage _unit)];

// bug, apparently can fire for remote units in special cases
if !(local _unit) exitWith { 0.0 };
// bug, assumed fixed, @todo excessive testing, if nothing happens remove
if (_projectile isEqualType objNull) then 
{
    _projectile = typeOf _projectile;
    _this set [4, _projectile];
};

// Get missing meta info
private _oldDamage = 0;
if (_hitPoint isEqualTo "") then 
{
    //_hitPoint = "#structural";
    _oldDamage = damage _unit;
}
else
{
    _oldDamage = _unit getHitIndex _hitPointIndex;
};

private _newDamage = _passedDamage - _oldDamage;

// Get armor value of hitpoint and calculate damage before armor
//private _armor = [_unit, _hitpoint] call az_fnc_getItemArmor;
//private _realDamage = _newDamage * _armor;
//player globalChat format ["[%1] %2: %3", diag_frameno, _hitPoint, _armor];
//diag_log format ["[%1] %2: %3|%4", diag_frameno, _hitPoint, _newDamage, _realDamage];
//diag_log format ["[%1] %2 = %3 | %4 | %5", diag_frameno, _selection, _passedDamage, _oldDamage, _newDamage];

if (_newDamage <= 0) exitWith { _passedDamage };

//_newDamage = _passedDamage;

private _damType = [_projectile] call az_fnc_getTypeOfDamage;
switch (_damType) do
{
	case (__AZ_DAMAGE_TYPE_NONE):
	{
		//player globalChat format ["[%1] Handle damage: DAMAGE_TYPE_NONE", diag_frameno];
	};
	case (__AZ_DAMAGE_TYPE_BULLET):
	{
		if (not isNil "_source") then
		{
			if (isNull (objectParent _source)) then  
			{
				if ( [currentWeapon _source, _projectile] call az_fnc_isAmmoWeapon) then
				{
					//player globalChat format ["[%1] Handle damage: DAMAGE_TYPE_BULLET", diag_frameno];
					private _unitStat = _unit getVariable ["AZ_UnitStat", nil];
					private _hp = (_unitStat get "hp");
					private _ammoHit = getNumber (configfile >> "CfgAmmo" >> _projectile >> "hit");
					//player globalChat format ["[%1] (%2) >> hit: %3", diag_frameno, _projectile, _ammoHit];					
					_ammoHit =  _ammoHit * (1.0 + ((random 30)- 15)/100.0);//*(_newDamage min 1.0)
					
					//player globalChat format ["[%1] %2 = %3", diag_frameno, _selection, round _ammoHit];
					
					_passedDamage = _oldDamage + (_ammoHit / (_hp#1));
				};
			}
			else
			{
				//hint "Unit is in a vehicle"; do nothing
			};
		};
		
	};
	case (__AZ_DAMAGE_TYPE_GRENADE):
	{
		//player globalChat format ["[%1] Handle damage: DAMAGE_TYPE_GRENADE", diag_frameno];
	};		
	case (__AZ_DAMAGE_TYPE_EXPLOSIVE):
	{
		//player globalChat format ["[%1] Handle damage: DAMAGE_TYPE_EXPLOSIVE", diag_frameno];
	};		
	case (__AZ_DAMAGE_TYPE_SHELL):
	{
		//player globalChat format ["[%1] Handle damage: DAMAGE_TYPE_SHELL", diag_frameno];
	};		
	default	{player globalChat format ["[%1] Handle damage: SWITCH OPRATOR ERROR", diag_frameno];}; 
};


_passedDamage



