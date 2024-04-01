//AZ_ItemsContainer_fnc_getItem


//#define TRACE_MODE
#include "..\macros.hpp"

params ["_container", "_itemID"];

private _itemsList = _container get "itemsList";
private _item = _itemsList get _itemID;
if (isNil "_item") exitWith { ERROR("Item exist"); };

_item
