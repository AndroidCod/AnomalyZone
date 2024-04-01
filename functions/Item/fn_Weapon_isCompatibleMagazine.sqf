// AZ_Item_fnc_Weapon_isCompatibleMagazine  

// #define TRACE_MODE
#include "..\macros.hpp"

params ["_weapon", "_magazine", ["_muzzleName", 0, ["", 0]]];

#ifdef DEBUG_MODE
if (isNil "_weapon") exitWith { ERROR("Invalid param"); false };
private _type = (_weapon get "config") get "type";
if (_type != ITEM_TYPE_WEAPON_HANDGUN and {_type != ITEM_TYPE_WEAPON_PRIMARY and {_type != ITEM_TYPE_WEAPON_SECONDARY}}) exitWith { ERROR("Item is not weapon"); false };
#endif

private _magazineConfig = (_magazine get "config");
if ((_magazineConfig get "type") != ITEM_TYPE_MAGAZINE) exitWith { ERROR("Item is not magazine"); false };

private _muzzle = [_weapon, _muzzleName] call AZ_Item_fnc_Weapon_getMuzzle;
if (isNil '_muzzle') exitWith {false};

((_magazineConfig get "configName") in (_muzzle get "config" get "magazineTypes"))
