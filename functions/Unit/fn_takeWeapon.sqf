// [_unit, _gearSlotID] call AZ_Unit_fnc_takeWeapon

#define TRACE_MODE
#include "..\macros.hpp"

params ["_unit", "_gearSlotID"];

#ifdef DEBUG_MODE
if (_gearSlotID != GEAR_SLOT_ID_WEAPON_PRIMARY and {_gearSlotID != GEAR_SLOT_ID_WEAPON_SECONDARY and {_gearSlotID != GEAR_SLOT_ID_WEAPON_HANDGUN}}) exitWith { ERROR("Invalid gear slot ID"); nil };
#endif

private _gear = _unit getVariable "AZ_Unit_Gear";
if (isNil "_gear") exitWith { ERROR("Unit not have variable: 'AZ_Unit_Gear'"); nil};

private _item = _gear get _gearSlotID;
if (not isNil '_item') then 
{
	_gear set [_gearSlotID, nil];
	if ((_gearSlotID != GEAR_SLOT_ID_WEAPON_SECONDARY) or {(_item get "config" get "type") != ITEM_TYPE_WEAPON_PRIMARY}) then 
	{
		[_unit, [_gearSlotID, GEAR_SLOT_ID_UNIFORM, GEAR_SLOT_ID_VEST, GEAR_SLOT_ID_BACKPACK]] call AZ_Unit_fnc_setLoadout;
	};
};

_item

