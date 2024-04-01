// true = [_unit, _weaponSlotID, _ammoItem, _muzzleName] call AZ_Unit_fnc_setWeaponAmmo

#define TRACE_MODE
#include "..\macros.hpp"

params ["_unit", "_weaponSlotID", "_ammoItem", "_muzzleName"];

if (_weaponSlotID != GEAR_SLOT_ID_WEAPON_PRIMARY and {_weaponSlotID != GEAR_SLOT_ID_WEAPON_SECONDARY and {_weaponSlotID != GEAR_SLOT_ID_WEAPON_HANDGUN}}) exitWith { ERROR("Invalid gear slot ID"); false };

//TRACE_1("%1", _muzzleName);
private _weapon = [_unit, _weaponSlotID] call AZ_Unit_fnc_getGear;
if (isNil "_weapon") exitWith { ERROR("Unit not have a weapon"); false };

if (not( [_weapon, _ammoItem, _muzzleName] call AZ_Item_fnc_Weapon_setAmmo)) exitWith {false};
_ammoItem set ["slotRotation", 0];

if ((_weaponSlotID == GEAR_SLOT_ID_WEAPON_SECONDARY) and {(_config get "type") == ITEM_TYPE_WEAPON_PRIMARY}) exitWith { true };

[_unit, _weaponSlotID] call AZ_Unit_fnc_setLoadout;

true