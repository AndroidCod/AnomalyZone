// true = [_weapon, _magazine, _muzzleName] call AZ_Item_fnc_Weapon_setMagazine

// #define TRACE_MODE
#include "..\macros.hpp"

params ["_weapon", "_magazine", ["_muzzleName", 0]];

if (_this call AZ_Item_fnc_Weapon_isCompatibleMagazine) exitWith 
{
	private _muzzle = [_weapon, _muzzleName] call AZ_Item_fnc_Weapon_getMuzzle;
	if (isNil '_muzzle') exitWith { ERROR("Invalid muzzle name"); false};
	
	_muzzle set ["magazine", _magazine];
	
	true
};

false
/*
// get muzzle
private _muzzle = nil;
if (not isNil '_muzzleName') then 
{
	if (_this call AZ_Item_fnc_Weapon_isCompatibleMagazine) then 
	{	
		_muzzle = [_weapon, _muzzleName] call AZ_Item_fnc_Weapon_getMuzzle;
		if (isNil '_muzzle') exitWith { ERROR("Invalid muzzle name"); false};
	};
}
else
{
	_muzzle = _this call AZ_Item_fnc_Weapon_getMuzzleByMagazine;
};
if (isNil '_muzzle') exitWith { ERROR("Muzzle not found"); false};

_muzzle set ["magazine", _magazine];

true
*/