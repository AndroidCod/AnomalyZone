// [_magazine] call AZ_Item_fnc_Magazine_getArmaClass;

// #define TRACE_MODE
#include "..\macros.hpp"

params ["_magazine"];

private _magazineConfig = _magazine get "config";
if ((_magazineConfig get "type") != ITEM_TYPE_MAGAZINE) exitWith { ERROR("Item is not magazine"); nil };

private _ammo = _magazine get "ammo";
if (_ammo isEqualTo "") exitWith { ERROR("magazine ammo invalid data"); nil };

private _magArmaClass = _magazineConfig get _ammo;
if (isNil "_magArmaClass") exitWith { ERROR("magazine invalid data"); nil };

_magArmaClass
