// AZ_ItemsContainer_fnc_addItem 

// item must be:
//	ARRAY - [STRING, NUMBER] - [configName, amount]
//  HASHMAP - item instance

// #define TRACE_MODE
#include "..\macros.hpp"

params ["_container", "_item", ["_position", nil]];

if (_item isEqualTo "") exitWith { ERROR("Invalid item data"); nil};
if (typeName _item == "ARRAY") then 
{
	//_item params ["_configName", "_amount"];
	_item = _item call AZ_Item_fnc_create;
};
if (typeName _item != "HASHMAP") exitWith { ERROR("Invalid item data"); nil};

private _itemConfig = _item get "config";

if ((_container get "isPockets") and { (_itemConfig get "pocketSet") != 1 }) exitWith {};

private _itemWeight = _item get "weight";
// test
/*if ((_itemConfig get "type") == ITEM_TYPE_MAGAZINE) then
{
	[_item, "Ammo_65x39_caseless_tracer", random 60] call AZ_Item_fnc_Magazine_addAmmo;
};*/

// check empty space
private _slotRect = nil;
if (isNil "_position") then 
{
	_slotRect = [_container, _item] call AZ_GUI_fnc_IMap_findEmptyPos;
	// rotate and try again
	if (isNil "_slotRect") then
	{
		if (_item call AZ_Item_fnc_slotRotate) then
		{
			_slotRect = [_container, _item] call AZ_GUI_fnc_IMap_findEmptyPos;
			if (isNil "_slotRect") then { _item call AZ_Item_fnc_slotRotate; }; // back rotation
		};
	};
}
else
{
	private _size = _item call AZ_Item_fnc_getSlotSize;
	private _rect = [_position#0, _position#1, _size#0, _size#1];
	if ([_container, _rect] call AZ_GUI_fnc_IMap_isRectEmpty) then
	{
		_slotRect = _rect;		
	}
	else
	{
		// rotate and try again
		if (_item call AZ_Item_fnc_slotRotate) then
		{
			_size = _item call AZ_Item_fnc_getSlotSize;
			_rect = [_position#0, _position#1, _size#0, _size#1];
			if ([_container, _rect] call AZ_GUI_fnc_IMap_isRectEmpty) then
			{
				_slotRect = _rect;		
			}
			else
			{
				_item call AZ_Item_fnc_slotRotate; // back rotation
			};
		};
	};
	//TRACE_1("%1", _slotRect);
};
if (isNil "_slotRect") exitWith {};

// check cargo capacity (DISABLED)
/*
private _capacity = _container get "capacity";
private _cargoWeight = _container get "cargoWeight";
if (_capacity > 0 and {(_capacity - _cargoWeight) < _itemWeight}) exitWith {};
*/

/* Стак выполнить отдельной функцией типа - AZ_ItemsContainer_fnc_addItemToStack, которая добвляет в конкретный стак
// Auto Stack items
private _stackList = [];
if ((_container get "autoStack")) then
{
	private _stack = _itemConfig get "stack";
	if (_stack > 1) then 
	{		
		{
			private _id = _x;
			private _it = _y;
			private _d = [_it, _item] call AZ_Item_fnc_stack;			
			if (_d > 0) then 
			{
				_stackList pushBack _id;
				// calc weigth
				private _w = ((_it get "weight") * _d);
				_w = (_container get "cargoWeight") + _w;
				_container set ["cargoWeight", _w];
				
			};
			if ((_item get "amount") == 0) exitWith {};
			
		} forEach _itemsList;
	};
};
if ((_item get "amount") == 0) exitWith {[0, _stackList]};
*/

// get new ID
private _id = 0;
private _freeIDList = _container get "freeIDList";
if (count _freeIDList > 0) then 
{
	_id = _freeIDList deleteAt (count _freeIDList - 1);
	//_id = _freeIDList deleteAt [-1]; // delete last element
}
else
{
	private _IDCounter = _container get "IDCounter";
	_id = _IDCounter + 10;
	_container set ["IDCounter", _id];
};

_slotRect = [_container, _id, _item, _slotRect] call AZ_GUI_fnc_IMap_addItemAtPos;
if (isNil "_slotRect") exitWith 
{
	ERROR("Failed add item to container");
	_freeIDList pushBack _id;
	nil
};

// add
private _itemsList = _container get "itemsList";
_itemsList set [_id, _item];
private _w = (_container get "cargoWeight") + (_itemWeight * (_item get "amount"));
_container set ["cargoWeight", _w];
//_this call AZ_ItemsContainer_fnc_calcCargoWeight;

/*
// sync arma items like Unit, WeaponHolders ...
switch (_container get "type") do
{
	case CONT_TYPE_VIRTUAL: { 	};
	case CONT_TYPE_UNIFORM:	{ 	};
	case CONT_TYPE_VEST:	{ 	};
	case CONT_TYPE_BACPACK: { 	};
	case CONT_TYPE_CARGO:{ 	};
	default { ERROR_NO_IMPLEMENTATION; };
};
private _object = _container get "armaObject";
if (not isNull _object) then
{
	
};*/

_id
