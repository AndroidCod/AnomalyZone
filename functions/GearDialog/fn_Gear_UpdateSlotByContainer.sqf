// [_display, _containerIDC] call AZ_GearDialog_fnc_Gear_UpdateSlotByContainer;

#include "..\macros.hpp"

params ["_display", "_containerIDC"];

if (isNull _display) exitWith {};

private _gearSlotID = switch (_containerIDC) do 
{
	case GEAR_DIALOG_UNIFORM_CONTAINER_IDC:{GEAR_SLOT_ID_UNIFORM};	
	case GEAR_DIALOG_VEST_CONTAINER_IDC:{ GEAR_SLOT_ID_VEST};	
	case GEAR_DIALOG_BACKPACK_CONTAINER_IDC:{GEAR_SLOT_ID_BACKPACK};		
	default { 0 };
};	
if (_gearSlotID != 0) then
{
	[_display, _gearSlotID] call AZ_GearDialog_fnc_Gear_UpdateSlot;
};