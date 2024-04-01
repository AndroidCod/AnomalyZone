// true = [_weapon, _ammoItem, _muzzleName] call AZ_Item_fnc_Weapon_addAmmo

//#define TRACE_MODE
//#include "..\macros.hpp"

params ["_weapon", "_ammoItem", "_muzzleName"];

private _mag = [_weapon, _muzzleName] call AZ_Item_fnc_Weapon_getMagazine;
if (isNil '_mag') exitWith { false };

if (not (_mag call AZ_Item_fnc_Magazine_isIntegral)) exitWith { false };

([_mag, _ammoItem] call AZ_Item_fnc_Magazine_addAmmo)
