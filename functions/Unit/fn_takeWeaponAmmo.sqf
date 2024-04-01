// [_unit, GEAR_SLOT_ID_WEAPON_PRIMARY] call AZ_Unit_fnc_takeWeaponAmmo

#define TRACE_MODE
#include "..\macros.hpp"

params ["_unit", "_gearSlotID", ["_muzzleName", 0]];

if (_gearSlotID != GEAR_SLOT_ID_WEAPON_PRIMARY and {_gearSlotID != GEAR_SLOT_ID_WEAPON_SECONDARY and {_gearSlotID != GEAR_SLOT_ID_WEAPON_HANDGUN}}) exitWith { ERROR("Invalid gear slot ID"); nil };

private _weapon = [_unit, _gearSlotID] call AZ_Unit_fnc_getGear;
if (isNil "_weapon") exitWith {};

private _ammo = [_weapon, _muzzleName] call AZ_Item_fnc_Weapon_takeAmmo;
if (isNil '_ammo') exitWith {};

if (not ((_gearSlotID == GEAR_SLOT_ID_WEAPON_SECONDARY) and {(_weapon get "config" get "type") == ITEM_TYPE_WEAPON_PRIMARY})) then
{
	[_unit, _gearSlotID] call AZ_Unit_fnc_setLoadout;
};

_ammo