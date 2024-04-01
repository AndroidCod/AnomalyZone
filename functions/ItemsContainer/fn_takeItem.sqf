// AZ_ItemsContainer_fnc_takeItem 
#define TRACE_MODE
#include "..\macros.hpp"

params ["_container", "_id", ["_count", ITEM_STACK_MAX]];

if (_count <= 0) exitWith {ERROR("Invalid param '_count'"); nil};
//_count = round _count;

private _itemsList = _container get "itemsList";
private _item = _itemsList get _id;
if (isNil "_item") exitWith {ERROR("Item exist"); nil};

private _itemAmount = _item get "amount";
private _takeAmount = _itemAmount min _count;
if (_takeAmount <= 0) exitWith {ERROR("Have no take"); nil};
private _itemAmountNew = _itemAmount - _takeAmount;

if (_itemAmountNew == 0) exitWith
{
	private _slotRect = +([_container, _id] call AZ_ItemsContainer_fnc_getItemSlotRect);
	_item = _this call AZ_ItemsContainer_fnc_deleteItem;
	[_item, true, _slotRect]
};

private _clone = _item call AZ_Item_fnc_clone;
	
_item set ["amount", _itemAmountNew];
_clone set ["amount", _takeAmount];

// calc weight
private _takeWeight = (_item get "weight") * _takeAmount;
private _cargoWeight = _container get "cargoWeight";
_container set ["cargoWeight", (_cargoWeight - _takeWeight)];

/*
private _object = _container get "armaObject";
if (not isNull _object) then
{
	// sync arma items like weaponHolders ...

};
*/

[_clone, false]
