// delete gear
#include "..\macros.hpp"

params ["_unit", "_slotID"];

private _gear = _unit getVariable "AZ_Unit_Gear";
if (isNil "_gear") exitWith { ERROR("Unit not have variable: 'AZ_Unit_Gear'"); };

private _item = nil;
switch (_slotID) do
{
	case GEAR_SLOT_ID_VEST;
	case GEAR_SLOT_ID_UNIFORM;
	case GEAR_SLOT_ID_BACKPACK;
	case GEAR_SLOT_ID_NVG;
	case GEAR_SLOT_ID_GOGGLE;
	case GEAR_SLOT_ID_HEADGEAR: 
	{
		_item = _gear get _slotID;
		if (not isNil "_item") then
		{
			_gear set [_slotID, nil];
			[_unit, _slotID] call AZ_Unit_fnc_setLoadout;
		};
	};
	case GEAR_SLOT_ID_WEAPON_PRIMARY;
	case GEAR_SLOT_ID_WEAPON_SECONDARY; 
	case GEAR_SLOT_ID_WEAPON_HANDGUN:
	{
		_item = _this call AZ_Unit_fnc_takeWeapon; 		
	};
	case GEAR_SLOT_ID_WEAPON_PRIMARY_MAG_0;
	case GEAR_SLOT_ID_WEAPON_PRIMARY_MAG_1: { ERROR("Invalid gear slot ID"); };		
	default { ERROR_NO_IMPLEMENTATION; };
};

_item
