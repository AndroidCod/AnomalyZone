// private _takeData = [_unit, _gearSlotID, _itemID, ITEM_STACK_MAX] call AZ_Unit_fnc_takeItem;
// _takeData params ["_item", "_isDeleted", "_rect"];

#define TRACE_MODE
#include "..\macros.hpp"

params ["_unit", "_gearSlotID", "_itemID", ["_count", ITEM_STACK_MAX]];

if (_gearSlotID != GEAR_SLOT_ID_UNIFORM and {_gearSlotID != GEAR_SLOT_ID_VEST and {_gearSlotID != GEAR_SLOT_ID_BACKPACK}}) exitWith { ERROR("Invalid gear slot ID"); nil};

private _gearItem = [_unit, _gearSlotID] call AZ_Unit_fnc_getGear;
if (isNil '_gearItem') exitWith { ERROR("Item exist in gear slot"); nil};

private _container = _gearItem get "ItemsContainer";
private _takeData = [_container, _itemID, _count] call AZ_ItemsContainer_fnc_takeItem;
//_takeData params ["_item", "_isDeleted", "_rect"];
if (not isnil '_takeData') then
{
	[_unit, _gearSlotID] call AZ_Unit_fnc_setLoadout;
};

_takeData
