// true = [_magazine, _ammoItem] call AZ_Item_fnc_Magazine_setAmmo

#include "..\macros.hpp"

params ["_magazine", "_ammo", ["_ammoCount", nil]];

private _magConfig = (_magazine get "config");
if (isNil '_magConfig' or { (_magConfig get "type") != ITEM_TYPE_MAGAZINE }) exitWith { ERROR("Invalid params data"); false};

private _ammoType = "";
if (typeName _ammo == "STRING") then
{
	_ammoType = _ammo;
	assert (typeName _ammoCount == "SCALAR");
}; 
private _isItem = typeName _ammo == "HASHMAP";
if (_isItem) then
{
	_ammoType = _ammo get "config" get "configName";
	_ammoCount = _ammo get "amount";
};

// clear magazine
if (_ammoType isEqualTo "" or {_ammoCount <= 0}) exitWith 
{
	_magazine set ["ammo", _ammoType];
	_magazine set ["ammoCount", 0];
	true
};

// check compability
if (not ([_magazine, _ammoType] call AZ_Item_fnc_Magazine_isCompatibleAmmo)) exitWith { ERROR("Try set incompatible Ammo to Magazine"); false };

// set Magazine item
private _d = (_ammoCount min (_magConfig get "capacity")) max 0; 
_magazine set ["ammoCount", _d];
_magazine set ["armaClass", (_magConfig get _ammoType)];
if (_d <= 0) then { _ammoType = ""; }; 
_magazine set ["ammo", _ammoType];

// set Ammo item
if (_isItem) then 
{
	_ammoItem set ["amount", ((_ammoCount - _d) max 0)];
};

true


