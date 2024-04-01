// AZ_Item_fnc_Magazine_addAmmo 

#define TRACE_MODE
#include "..\macros.hpp"

params ["_mag", "_ammoItem"];

if (not([_mag, _ammoItem] call AZ_Item_fnc_Magazine_isCompatibleAmmo)) exitWith { false };

private _curAmmo = _mag get "ammo";
private _ammoType = (_ammoItem get "config" get "configName");
if (_curAmmo isNotEqualTo "" and { _curAmmo isNotEqualTo _ammoType }) exitWith { false };

TRACE_1("Magazine_addAmmo: %1", _ammoType);

private _magAmmoCount = _mag get "ammoCount";
private _magCap = _mag get "config" get "capacity";
private _d = _magCap - _magAmmoCount;
if (_d <= 0) exitWith { false };
private _amount = _ammoItem get "amount";
_d = _d min _amount;
if (_d <= 0) exitWith { false };
_magAmmoCount = (((_magAmmoCount + _d) min _magCap) max 0);

if ([_mag, _ammoType, _magAmmoCount] call AZ_Item_fnc_Magazine_setAmmo) exitWith
{
	_ammoItem set ["amount", ((_amount - _d) max 0)];
	true
};
false


/*
params ["_mag", "_ammoType", "_ammoCount"];

if (isNil "_mag") exitWith {false};
if (_ammoCount == 0) exitWith {false};
private _config = (_mag get "config");
if ((_config get "type") != ITEM_TYPE_MAGAZINE) exitWith {false};

// set Ammo type
private _currentAmmo = _mag get "ammo";
if (_mag call AZ_Item_fnc_Magazine_isEmpty) then
{
	if ([_mag, _ammoType] call AZ_Item_fnc_Magazine_isCompatibleAmmo) then
	{
		_currentAmmo = _ammoType;
		_mag set ["ammo", _currentAmmo];
		_mag set ["armaClass", (_config get _currentAmmo)];
	}
	else { ERROR("Incompatible ammo type"); };
};
if (_currentAmmo isEqualTo "") exitWith {false};

// set Ammo count
_ammoCount = CLAMP(((_mag get "ammoCount") + (round _ammoCount)), 0, (_config get "capacity")); 
_mag set ["ammoCount", _ammoCount];
if (_ammoCount == 0) then 
{
	_mag set ["ammo", ""];
};

true*/

