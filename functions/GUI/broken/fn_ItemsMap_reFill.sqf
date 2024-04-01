// AZ_GUI_fnc_ItemsMap_reFill = 

params ["_ItemsMap", "_newRect"];

_ItemsMap set ["rect", _newRect];

private _container = _ItemsMap get "container";
private _itemsList = _container get "itemsList";

if (count _itemsList <= 0) exitWith 
{
	// clear all
}; 
private _sortMode = _ItemsMap get "sortMode";
private _filter = _ItemsMap get "sortFilter";

private _groupList = createHashMap;
private _itemsListID = keys _itemsList;
if (_sortMode == 0) then
{
	if (count _filter > 0) then 
	{
		_itemsListID = _itemsListID select { (((_itemsList get _x) get "config") get "group") in _filter };  
	};
	_itemsListID = _itemsListID apply { [_x, [0,0,0,0]] };
	private _slots = createHashMapFromArray _itemsListID;
	private _group = createHashMap;
	_group set ["itemSlots", _slots]; 
	_groupList set [0, _group];
};
if (_sortMode == 1) then
{		
	{
		private _id = _x;
		private _item = (_itemsList get _id);
		private _g = (_item get "config") get "group";
		if ((count _filter == 0) or {_g in _filter}) then 
		{
			private _group = _groupList getOrDefaultCall [_g, {createHashMap}, true];
			private _slots = _group getOrDefaultCall ["itemSlots", {createHashMap}, true];
			_slots set [_id, [0,0,0,0]];
		};
		
	} forEach _itemsListID;
};

_ItemsMap set ["groupsList", _groupList];
if (count _groupList > 0) then
{
	private _groupsID = keys _groupList;
	_groupsID sort false;
	{		
		[_ItemsMap, _x] call AZ_GUI_fnc_ItemsMap_fillGroup;
		
	} forEach _groupsID;
};