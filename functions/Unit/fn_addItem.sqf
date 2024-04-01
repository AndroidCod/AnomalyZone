// private _itemID = [_unit, _gearSlotID, _item, ["_position", nil]] call AZ_Unit_fnc_addItem;


#define TRACE_MODE
#include "..\macros.hpp"

params ["_unit", "_gearSlotID", "_item", ["_position", nil]];

if (_gearSlotID != GEAR_SLOT_ID_UNIFORM and {_gearSlotID != GEAR_SLOT_ID_VEST and {_gearSlotID != GEAR_SLOT_ID_BACKPACK}}) exitWith { ERROR("Invalid gear slot ID"); nil};

private _gearItem = [_unit, _gearSlotID] call AZ_Unit_fnc_getGear;
if (isNil '_gearItem') exitWith {}; // ERROR("Item exist in gear slot");

private _container = _gearItem get "ItemsContainer";
private _itemID = [_container, _item, _position] call AZ_ItemsContainer_fnc_addItem;
if (not isnil '_itemID') then
{
	[_unit, _gearSlotID] call AZ_Unit_fnc_setLoadout;
};

_itemID

