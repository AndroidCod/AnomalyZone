// true = [_magazine, _ammoItem] call AZ_Item_fnc_Magazine_isCompatibleAmmo

#include "..\macros.hpp"

params ["_magazine", "_ammo"];

private _magConfig = (_magazine get "config");
if (isNil '_magConfig' or { (_magConfig get "type") != ITEM_TYPE_MAGAZINE }) exitWith { ERROR("Invalid params data"); false};

private _ammoType = "";
if (typeName _ammo == "STRING") then
{
	_ammoType = _ammo;
}; 
if (typeName _ammo == "HASHMAP") then
{
	_ammoType = _ammo get "config" get "configName";
};
if (_ammoType isEqualTo "") exitWith {ERROR("Invalid params data"); false};

(_ammoType in (_magConfig get "ammoTypes"))