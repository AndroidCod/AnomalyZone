// AZ_Item_fnc_Weapon_takeMagazine

//#define TRACE_MODE
#include "..\macros.hpp"

params ["_weapon", ["_muzzleName", 0]];

if (isNil "_weapon") exitWith { ERROR("Invalid param"); nil };
private _weaponConfig = (_weapon get "config");
private _type = _weaponConfig get "type";
if (_type != ITEM_TYPE_WEAPON_HANDGUN and {_type != ITEM_TYPE_WEAPON_PRIMARY and {_type != ITEM_TYPE_WEAPON_SECONDARY}}) exitWith { ERROR("Item is not weapon"); nil };

private _muzzle = [_weapon, _muzzleName] call AZ_Item_fnc_Weapon_getMuzzle;
if (isNil '_muzzle') exitWith { ERROR("Invalid muzzle name"); nil };

private _mag = _muzzle get "magazine";
if (_mag call AZ_Item_fnc_Magazine_isIntegral) exitWith { nil }; // do not take integral magazines

_muzzle set ["magazine", nil];
_mag
