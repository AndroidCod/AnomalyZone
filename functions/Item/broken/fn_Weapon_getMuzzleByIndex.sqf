
// [_weapon, _muzzleIndex] call AZ_Item_fnc_Weapon_getMuzzleByIndex

// #define TRACE_MODE
#include "..\macros.hpp"

params ["_weapon", "_muzzleIndex"];

private _muzzleName = "";
if (_muzzleIndex == 0) then
{
	_muzzleName = "this";
};
if (_muzzleIndex == 1) then
{
	private _muzzles = (_weapon get "config" get "muzzles");
	if (count _muzzles > 1) then
	{
		_muzzleName = (_muzzles select 1);
	};
};
if (_muzzle isEqualTo "") exitWith {ERROR("Invalid muzzle index"); nil};

private _muzzle = [_weapon, _muzzleName] call AZ_Item_fnc_Weapon_getMuzzle;
_muzzle
