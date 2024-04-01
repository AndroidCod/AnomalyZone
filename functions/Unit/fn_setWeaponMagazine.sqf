// [_unit, GEAR_SLOT_ID_WEAPON_PRIMARY, _wpnItem] call AZ_Unit_fnc_setWeaponMagazine;

//#define TRACE_MODE
#include "..\macros.hpp"

params ["_unit", "_gearSlotID", "_magazine", ["_muzzleName", "this"]];

if (_gearSlotID != GEAR_SLOT_ID_WEAPON_PRIMARY and {_gearSlotID != GEAR_SLOT_ID_WEAPON_SECONDARY and {_gearSlotID != GEAR_SLOT_ID_WEAPON_HANDGUN}}) exitWith { ERROR("Invalid gear slot ID"); false };

//TRACE_1("%1", _muzzleName);
private _weapon = [_unit, _gearSlotID] call AZ_Unit_fnc_getGear;
if (isNil "_weapon") exitWith { ERROR("Unit not have a weapon"); false };

if (not( [_weapon, _magazine, _muzzleName] call AZ_Item_fnc_Weapon_setMagazine)) exitWith {false};
_magazine set ["slotRotation", 0];

if ((_gearSlotID == GEAR_SLOT_ID_WEAPON_SECONDARY) and {(_config get "type") == ITEM_TYPE_WEAPON_PRIMARY}) exitWith { true };

[_unit, _gearSlotID] call AZ_Unit_fnc_setLoadout;

true