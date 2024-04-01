// [_unit, GEAR_SLOT_ID] call AZ_Unit_fnc_setLoadoutGear

//#define TRACE_MODE
#include "..\macros.hpp"

params ["_unit", "_gearSlotID"];

private _filter = [];
switch (_gearSlotID) do 
{
	case GEAR_SLOT_ID_WEAPON_PRIMARY: {_filter pushBack LOADOUT_WEAPON_PRIMARY};
	case GEAR_SLOT_ID_WEAPON_SECONDARY: {_filter pushBack LOADOUT_WEAPON_SECONDARY};
	case GEAR_SLOT_ID_WEAPON_HANDGUN: {_filter pushBack LOADOUT_WEAPON_HANDGUN};
	case GEAR_SLOT_ID_UNIFORM: {_filter pushBack LOADOUT_UNIFORM};
	case GEAR_SLOT_ID_VEST: {_filter pushBack LOADOUT_VEST};
	case GEAR_SLOT_ID_BACKPACK: {_filter pushBack LOADOUT_BACKPACK};
	case GEAR_SLOT_ID_HEADGEAR: {_filter pushBack LOADOUT_HEADGEAR};
	case GEAR_SLOT_ID_GOGGLE: {_filter pushBack LOADOUT_GOGGLE};
	case GEAR_SLOT_ID_NVG: {_filter pushBack LOADOUT_ASSIGNED_ITEMS};
	default { ERROR_NO_IMPLEMENTATION; };
};
[_unit, _filter] call AZ_Unit_fnc_setLoadout;