// AZ_GUI_fnc_IMap_create

// #define TRACE_MODE
//#include "..\macros.hpp"

//params ["_mapX", "_mapY", "_mapW", "_mapH"]; 

private _mapRect = _this apply {floor _x}; 

private _IMap = createHashMap;
//_IMap set ["container", _container];
//_IMap set ["sortMode", _sortMode];
//_IMap set ["sortFilter", _sortFilter];
_IMap set ["itemSlots", createHashMap];
private _cellsList = [];
_mapRect params ["_mapX", "_mapY", "_mapW", "_mapH"];
private _size = floor((_mapX + _mapW) * (_mapY + _mapH));
assert(_size > 0);
_cellsList resize [_size, -1];
_IMap set ["cells", _cellsList];
_IMap set ["rect", _mapRect];
_IMap set ["space", [0, (_mapW*_mapH)]];// _space params ["_free", "_total"];

[_IMap, _mapRect, 0] call AZ_GUI_fnc_IMap_fillRect;

/*
private _itemsList = _container get "itemsList";
if (count _itemsList <= 0) exitWith { _IMap };
private _itemsIDList = keys _itemsList;
// sort items by max Group_Type_Height_Width
_itemsIDList = [_itemsIDList, [_itemsList], AZ_Item_fnc_hashSortBy, "DESCEND"] call BIS_fnc_sortBy;


{ 
	private _id = _x;
	private _item = [_container, _id] call AZ_ItemsContainer_fnc_getItem;
	private _r = [_IMap, _id, _item] call AZ_GUI_fnc_IMap_addItem;
	if (isNil "_r") then { ERROR("Cant add item to IMap"); };
	
} forEach _itemsIDList;
*/

_IMap

