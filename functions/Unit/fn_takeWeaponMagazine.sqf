// [_unit, GEAR_SLOT_ID_WEAPON_PRIMARY] call AZ_Unit_fnc_takeWeaponMagazine

#define TRACE_MODE
#include "..\macros.hpp"

params ["_unit", "_gearSlotID", ["_muzzleName", 0]];

if (_gearSlotID != GEAR_SLOT_ID_WEAPON_PRIMARY and {_gearSlotID != GEAR_SLOT_ID_WEAPON_SECONDARY and {_gearSlotID != GEAR_SLOT_ID_WEAPON_HANDGUN}}) exitWith { ERROR("Invalid gear slot ID"); nil };

private _weapon = [_unit, _gearSlotID] call AZ_Unit_fnc_getGear;
if (isNil "_weapon") exitWith {};

private _magazine = [_weapon, _muzzleName] call AZ_Item_fnc_Weapon_takeMagazine;
if (isNil '_magazine') exitWith {};

if ((_gearSlotID == GEAR_SLOT_ID_WEAPON_SECONDARY) and {(_weapon get "config" get "type") == ITEM_TYPE_WEAPON_PRIMARY}) exitWith {_magazine};

[_unit, _gearSlotID] call AZ_Unit_fnc_setLoadout;


_magazine