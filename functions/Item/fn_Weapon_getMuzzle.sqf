// [_weapon, _muzzleName] call AZ_Item_fnc_Weapon_getMuzzle

// #define TRACE_MODE
#include "..\macros.hpp"

params ["_weapon", "_muzzleName"];

//TRACE_1("getMuzzle: %1", _muzzleName);
private _muzzle = nil;
if (typeName _muzzleName == "SCALAR") exitWith 
{
	if (_muzzleName == 0) then
	{
		_muzzle = _weapon;
	};
	if (_muzzleName == 1) then
	{
		private _muzzles = (_weapon get "config" get "muzzles");
		if (count _muzzles > 1) then
		{
			_muzzleName = (_muzzles select 1);
			_muzzle = (_weapon get _muzzleName);
		};
	};
	_muzzle
};

if (typeName _muzzleName != "STRING") exitWith { ERROR("Invalid muzzle name type"); nil};
if (_muzzleName isEqualTo "") exitWith {ERROR("Invalid muzzle name"); nil};


if (_muzzleName isEqualTo "this" or {_muzzleName isEqualTo (_weapon get "config" get "armaClass") or {_muzzleName isEqualTo (_weapon get "config" get "configName")}}) then
{
	_muzzle = _weapon;
}
else
{
	private _weaponConfig = (_weapon get "config");
	if (_muzzleName in (_weaponConfig get "muzzles")) then 
	{
		_muzzle = (_weapon get _muzzleName);
	};
};

_muzzle