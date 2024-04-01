// AZ_Item_fnc_Magazine_create

#include "..\macros.hpp"

params ["_configName", "_ammo", ["_ammoCount", 10000]];

private _mag = [_configName, 1] call AZ_Item_fnc_create;
private _config = _mag get "config";
if ((_config get "type") != ITEM_TYPE_MAGAZINE) exitWith { ERROR("Item type is not 'Magazine'");  nil};

[_mag, _ammo, _ammoCount] call AZ_Item_fnc_Magazine_setAmmo;

_mag
