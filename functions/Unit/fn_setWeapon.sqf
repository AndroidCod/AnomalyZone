// [_unit, _gearSlotID] call AZ_Unit_fnc_setWeapon;

#define TRACE_MODE
#include "..\macros.hpp"

params ["_unit", "_gearSlotID", "_weapon"];

if (_gearSlotID != GEAR_SLOT_ID_WEAPON_PRIMARY and {_gearSlotID != GEAR_SLOT_ID_WEAPON_SECONDARY and {_gearSlotID != GEAR_SLOT_ID_WEAPON_HANDGUN}}) exitWith { ERROR("Invalid gear slot ID"); false };

//private _currentWeapon = _this call AZ_Unit_fnc_takeWeapon;

private _gear = _unit getVariable "AZ_Unit_Gear";
if (isNil "_gear") exitWith { ERROR("Unit not have variable: 'AZ_Unit_Gear'"); false};

_gear set [_gearSlotID, _weapon];
_weapon set ["slotRotation", 0];

//private _config = _weapon get "config";
// primary weapon in secondary slot no need sync
if ((_gearSlotID != GEAR_SLOT_ID_WEAPON_SECONDARY) or {(_weapon get "config" get "type") != ITEM_TYPE_WEAPON_PRIMARY}) then 
{
	[_unit, [_gearSlotID, GEAR_SLOT_ID_UNIFORM, GEAR_SLOT_ID_VEST, GEAR_SLOT_ID_BACKPACK]] call AZ_Unit_fnc_setLoadout;
};
//[_unit, [_gearSlotID, GEAR_SLOT_ID_UNIFORM, GEAR_SLOT_ID_VEST, GEAR_SLOT_ID_BACKPACK]] call AZ_Unit_fnc_setLoadout;

true
