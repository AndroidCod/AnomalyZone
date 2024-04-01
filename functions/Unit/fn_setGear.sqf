// AZ_Unit_fnc_setGear

#define TRACE_MODE
#include "..\macros.hpp"

params ["_unit", "_gearSlotID", "_item"];

if ((_item get "amount") > 1) exitWith { ERROR("Try set Item with big amount"); false};

private _gear = _unit getVariable "AZ_Unit_Gear";
if (isNil "_gear") exitWith { ERROR("Unit not have variable: 'AZ_Unit_Gear'"); false};

private _ret = false;
switch (_gearSlotID) do 
{
	case GEAR_SLOT_ID_NVG;
	case GEAR_SLOT_ID_GOGGLE;
	case GEAR_SLOT_ID_UNIFORM;
	case GEAR_SLOT_ID_VEST;
	case GEAR_SLOT_ID_BACKPACK;
	case GEAR_SLOT_ID_HEADGEAR:
	{
		if (not([_gearSlotID, _item] call AZ_Unit_fnc_Gear_isCompatibleItem)) exitWith {ERROR("Try set incompatible item to Unit Gear");}; 
		
		_gear set [_gearSlotID, _item];
		_item set ["slotRotation", 0];
		[_unit, _gearSlotID] call AZ_Unit_fnc_setLoadout;
		_ret = true;
	};
	case GEAR_SLOT_ID_WEAPON_PRIMARY;
	case GEAR_SLOT_ID_WEAPON_SECONDARY;
	case GEAR_SLOT_ID_WEAPON_HANDGUN:
	{
		_ret = _this call AZ_Unit_fnc_setWeapon;
	};
	case GEAR_SLOT_ID_WEAPON_PRIMARY_MAG_0;
	case GEAR_SLOT_ID_WEAPON_PRIMARY_MAG_1:
	{
		ERROR("Invalid gear slot ID");
	};
	default {ERROR_NO_IMPLEMENTATION;};
};
_ret




