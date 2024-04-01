// _ammo = _mag call AZ_Item_fnc_Magazine_takeAmmo

#include "..\macros.hpp"

params ["_magazine", ["_count", 100000]];

#ifdef DEBUG_MODE
if (isNil "_magazine") exitWith {ERROR("Invalid params data"); nil};
private _config = (_magazine get "config");
if ((_config get "type") != ITEM_TYPE_MAGAZINE) exitWith { ERROR("Invalid params data"); nil};
#endif

if (_magazine call AZ_Item_fnc_Magazine_isEmpty) exitWith {};

private _magAmmo = _magazine get "ammo";
private _magAmmoCount = _magazine get "ammoCount";
private _d = _count min _magAmmoCount;
if (_d <= 0) exitWith {}; 
_magAmmoCount = (_magAmmoCount - _d) max 0;
_magazine set ["ammoCount", _magAmmoCount];
if (_magAmmoCount <= 0) then 
{
	_magazine set ["ammo", ""];
};

([_magAmmo, _d] call AZ_Item_fnc_create)