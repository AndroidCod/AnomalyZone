// AZ_Unit_fnc_Gear_isCompatibleItem

#define TRACE_MODE
#include "..\macros.hpp"

params ["_gearSlotID", "_item"];

(_gearSlotID in ((_item get "config") get "gearSlot")) 
