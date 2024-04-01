// AZ_GearDialog_fnc_Container_getData

#include "..\macros.hpp"

params ["_display", "_containerIDC"];

private _data = nil;

private _fnc_getGearContainer = 
{
	params ["_gearSlotID"];
	
	private _item = [_display, _gearSlotID] call AZ_GearDialog_fnc_Gear_getItem;
	if (not isNil "_item") then
	{
		_data = _item get "ItemsContainer";
	};
};

switch (_containerIDC) do 
{	
	case GEAR_DIALOG_UNIFORM_CONTAINER_IDC:
	{	
		GEAR_SLOT_ID_UNIFORM call _fnc_getGearContainer;
	};	
	case GEAR_DIALOG_VEST_CONTAINER_IDC:
	{	
		GEAR_SLOT_ID_VEST call _fnc_getGearContainer;
	};	
	case GEAR_DIALOG_BACKPACK_CONTAINER_IDC:
	{	
		GEAR_SLOT_ID_BACKPACK call _fnc_getGearContainer;
	};	
	case GEAR_DIALOG_LEFT_CONTAINER_IDC:
	{	
		_data = _display getVariable "AZ_LeftContainer_Data";
	};
	default { ERROR("Invalid variable data '_containerIDC'"); };
};

//if (isNil "_data") exitWith { ERROR("Invalid variable data '_containerIDC'");};

_data
