
// AZ_GUI_fnc_ItemsMap_create

params ["_container", "_sortMode", "_sortFilter", "_mapRect"]; // ["_fixedSize", false] ];

private _ItemsMap = createHashMap;
//_ItemsMap set ["container", _container];
_ItemsMap set ["sortMode", _sortMode];
_ItemsMap set ["sortFilter", _sortFilter];
_ItemsMap set ["rect", _mapRect];
//_ItemsMap set ["fixedSize", _fixedSize];
//private _itemSlotList = createHashMap;
//_ItemsMap set ["itemSlots", _itemSlotList];
private _groupList = createHashMap;
_ItemsMap set ["groupsList", _groupList];

private _itemsList = _container get "itemsList";
if (count _itemsList <= 0) exitWith { _ItemsMap };
private _itemsIDList = keys _itemsList;
// sort items by max Group_Type_Height_Width
_itemsIDList = [_itemsIDList, [_itemsList], AZ_Item_fnc_hashSortBy, "DESCEND"] call BIS_fnc_sortBy;

/*
private _fnc_addItemToGroup =
{
	params ["_itemID", "_item"];
	//
	private _itemConfig = (_item get "config");
	private _groupID = 0;
	if (_sortMode == 1) then { _groupID = _itemConfig get "group"; };
	if ((count _sortFilter != 0) and {not (_groupID in _sortFilter)}) exitWith {}; 
	
	// Get/create group
	private _group = _groupList get _groupID;
	if (isNil "_group") then
	{
		_mapRect params ["_mapX", "_mapY", "_mapW", ""];
		// create group
		_group = createHashMap;
		_group set ["rect", [_mapX, _mapY, _mapW, 0]];
		_group set ["freeList", []];
		_group set ["itemSlots", createHashMap];
		_groupList set [_groupID, _group];
	};

	//	
	private _freeSpaceList = _group get "freeList";
	private _slotSize = _itemConfig get "slotSize";
	private _slotRect = [0, 0, (_slotSize#0), (_slotSize#1)];
	private _posXY = [_freeSpaceList, _slotRect] call AZ_GUI_fnc_EmptySpace_alloc;
	if (isNil "_posXY") then
	{
		private _groupRect = _group get "rect";
		_groupRect params ["_groupX", "_groupY", "_groupW", "_groupH"];
		_slotRect params ["", "", "_slotW", "_slotH"];
		_posXY = [_groupX, _groupY + _groupH];
		if (_slotW < _groupW) then
		{
			private _freeRect = [
				(_groupX + _slotW),
				(_groupY + _groupH),
				(_groupW - _slotW),
				(_slotH)
			];
			_freeSpaceList pushBack _freeRect;
		};
		_groupRect set [3, _groupH + _slotH];
	};
	_slotRect set [0, (_posXY#0)];
	_slotRect set [1, (_posXY#1)];
	
	private _slots = _group get "itemSlots";
	_slots set [_itemID, _slotRect];
};
*/
{ 
	private _id = _x;
	private _item = [_container, _id] call AZ_ItemsContainer_fnc_getItem;
	[_ItemsMap, _id, _item] call AZ_GUI_fnc_ItemsMap_addItem; 
	//[_id, _item] call _fnc_addItemToGroup; 

} forEach _itemsIDList;

// recalc groups Y position
if (count _groupList > 0) then
{
	_mapRect params ["", "_mapY"];
	private _mapH = _mapY;
			
	private _groupsID = keys _groupList;
	_groupsID sort false;
	{ 
		private _group = _groupList get _x; 
		private _groupRect = _group get "rect";
		_groupRect set [1, _mapH];
		_mapH = _mapH + (_groupRect#3);
		
		/*
		// make rects
		private _slots = _group get "itemSlots";
		{
			private _id = _x;
			private _slotRect = _y;			
			private _r = [((_groupRect#0) + (_slotRect#0)), ((_groupRect#1) + (_slotRect#1)), (_slotRect#2), (_slotRect#3)];
			_itemSlotList set [_id, _r];
			
		} forEach _slots;
		_group deleteAt "itemSlots";*/
	
		
	} forEach _groupsID;
	_mapRect set [3, _mapH];
};

_ItemsMap

