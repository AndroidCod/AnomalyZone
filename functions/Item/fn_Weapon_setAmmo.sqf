// true = [_weapon, _ammoItem, _muzzleName] call AZ_Item_fnc_Weapon_setAmmo;

#define TRACE_MODE
#include "..\macros.hpp"

params ["_weapon", "_ammoItem", ["_muzzleName", 0]];

private _magazine = [_weapon, _muzzleName] call AZ_Item_fnc_Weapon_getMagazine;
if (isNil '_magazine') exitWith { ERROR("Weapon have not a magazine"); false};

([_magazine, _ammoItem] call AZ_Item_fnc_Magazine_setAmmo) 

