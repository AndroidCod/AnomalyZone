
// [_weapon, 0] call AZ_Item_fnc_Weapon_getMagazine

#define TRACE_MODE
#include "..\macros.hpp"

params ["_weapon", ["_muzzleIndex", 0, ["", 0]]];

private _muzzle = [_weapon, _muzzleIndex] call AZ_Item_fnc_Weapon_getMuzzle;
// if (isNil '_muzzle') exitWith { ERROR("Muzzle not found"); nil };
if (isNil '_muzzle') exitWith {};
	
(_muzzle get "magazine")