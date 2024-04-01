// _curAmmo = [_weapon, _muzzleName] call AZ_Item_fnc_Weapon_takeAmmo;

#define TRACE_MODE
#include "..\macros.hpp"

params ["_weapon", ["_muzzleName", 0]];

#ifdef DEBUG_MODE
if (isNil "_weapon") exitWith { ERROR("Invalid param"); nil };
private _weaponConfig = (_weapon get "config");
private _type = _weaponConfig get "type";
if (_type != ITEM_TYPE_WEAPON_HANDGUN and {_type != ITEM_TYPE_WEAPON_PRIMARY and {_type != ITEM_TYPE_WEAPON_SECONDARY}}) exitWith { ERROR("Item is not weapon"); nil };
#endif

private _mag = [_weapon, _muzzleName] call AZ_Item_fnc_Weapon_getMagazine;
if (isNil '_mag') exitWith { ERROR("weapon have no magazine"); nil };

if (not (_mag call AZ_Item_fnc_Magazine_isIntegral)) exitWith {};

private _ammo = _mag call AZ_Item_fnc_Magazine_takeAmmo;

_ammo