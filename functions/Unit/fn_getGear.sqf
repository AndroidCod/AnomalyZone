// get gear

// #define TRACE_MODE
#include "..\macros.hpp"

params ["_unit", "_gearSlotID"];

private _gear = _unit getVariable "AZ_Unit_Gear";
if (isNil "_gear") exitWith { ERROR("Unit not have variable: 'AZ_Unit_Gear'"); };

(switch (_gearSlotID) do
{
	case GEAR_SLOT_ID_HEADGEAR;		
	case GEAR_SLOT_ID_GOGGLE;
	case GEAR_SLOT_ID_NVG;
	case GEAR_SLOT_ID_BACKPACK;
	case GEAR_SLOT_ID_UNIFORM;
	case GEAR_SLOT_ID_VEST;
	case GEAR_SLOT_ID_WEAPON_PRIMARY;
	case GEAR_SLOT_ID_WEAPON_SECONDARY;
	case GEAR_SLOT_ID_WEAPON_HANDGUN: { (_gear get _gearSlotID)};	
	default { ERROR_NO_IMPLEMENTATION; nil };
})
