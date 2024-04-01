// [_weapon, _magazine] call AZ_Item_fnc_Weapon_getMuzzleByMagazine  

// #define TRACE_MODE
#include "..\macros.hpp"

params ["_weapon", "_magazine"];

if (isNil "_weapon") exitWith { ERROR("Invalid param"); nil };
private _weaponConfig = (_weapon get "config");
private _type = _weaponConfig get "type";
if (_type != ITEM_TYPE_WEAPON_HANDGUN and {_type != ITEM_TYPE_WEAPON_PRIMARY and {_type != ITEM_TYPE_WEAPON_SECONDARY}}) exitWith { ERROR("Item is not weapon"); nil };

if (isNil "_magazine") exitWith { ERROR("Invalid param"); nil };
private _magazineConfig = (_magazine get "config");
if ((_magazineConfig get "type") != ITEM_TYPE_MAGAZINE) exitWith { ERROR("Item is not magazine"); nil };

private _magType = (_magazineConfig get "configName");
private _muzzle = nil;
private _muzzleList = _weaponConfig get "muzzles";
{
	//private _muzzleName = _x;		
	private _m = [_weapon, _x] call AZ_Item_fnc_Weapon_getMuzzle;
	private _types = (_m get "config" get "magazineTypes");
	if (_magType in _types) exitWith { _muzzle = _m; };	
	
} forEach _muzzleList;

_muzzle
