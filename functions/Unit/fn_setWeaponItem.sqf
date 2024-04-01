// true = [_unit, _gearSlotID, _item] call AZ_Unit_fnc_setWeaponItem;

#define TRACE_MODE
#include "..\macros.hpp"

params ["_unit", "_gearSlotID", "_item"];

if (_gearSlotID != GEAR_SLOT_ID_WEAPON_PRIMARY and {_gearSlotID != GEAR_SLOT_ID_WEAPON_SECONDARY and {_gearSlotID != GEAR_SLOT_ID_WEAPON_HANDGUN}}) exitWith { ERROR("Invalid gear slot ID"); false };

private _ret = false;
private _config = _item get "config";
switch (_config get "type") do 
{
	case ITEM_TYPE_MAGAZINE:
	{
		_ret = [_unit, _gearSlotID, _item] call AZ_Unit_fnc_setWeaponMagazine;
	};
	case ITEM_TYPE_WEAPON_MUZZLE;
	case ITEM_TYPE_WEAPON_POINTER;
	case ITEM_TYPE_WEAPON_OPTIC; 
	case ITEM_TYPE_WEAPON_BIPOD:
	{
		private _weapon = [_unit, _gearSlotID] call AZ_Unit_fnc_getGear;
		if (isNil "_weapon") exitWith { ERROR("Unit not have a weapon"); false };

		if (not( [_weapon, _item] call AZ_Item_fnc_Weapon_setItem)) exitWith {false};
		_item set ["slotRotation", 0];

		if ((_gearSlotID == GEAR_SLOT_ID_WEAPON_SECONDARY) and {(_config get "type") == ITEM_TYPE_WEAPON_PRIMARY}) exitWith { _ret = true; };
		[_unit, _gearSlotID] call AZ_Unit_fnc_setLoadout;
		_ret = true;
	};
	default {ERROR_NO_IMPLEMENTATION;};
};

_ret
