// AZ_ItemsContainer_fnc_deleteItem 
//#define TRACE_MODE
#include "..\macros.hpp"

params ["_container", "_id"];

// delete slot rect
private _rect = [_container, _id] call AZ_GUI_fnc_IMap_deleteItem;
if (isNil "_rect") exitWith {};

private _itemsList = _container get "itemsList";
private _item = _itemsList get _id;
if (isNil "_item") exitWith { ERROR("Item exist"); nil};

_itemsList deleteAt _id;

private _freeIDList = _container get "freeIDList";
_freeIDList pushBack _id;

private _itemWeight = (_item get "weight") * (_item get "amount");
private _cargoWeight = _container get "cargoWeight";
_container set ["cargoWeight", (_cargoWeight - _itemWeight)];

private _object = _container get "armaObject";
if (not isNull _object) then
{
	// sync arma items like weaponHolders ...

};

_item
