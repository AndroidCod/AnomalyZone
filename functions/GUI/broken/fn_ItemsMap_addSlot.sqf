// AZ_GUI_fnc_ItemsMap_addSlot

params ["_itemsMap", "_itemID", "_slotRect"];

private _itemsList = (_itemsMap get "container") get "itemsList";
if (count _itemsList == 0) exitWith {[]};
private _item = _itemsList get _itemID;
if (isNil "_item") exitWith {[]};

private _itemConfig = (_item get "config");
private _groupID = _itemConfig get "group";
private _sortFilter = _itemsMap get "sortFilter";
if (count _sortFilter > 0 and { not (_groupID in _sortFilter) }) exitWith { [] }; 

private _done = false;
private _pos = [];
private _groupList = _ItemsMap getOrDefaultCall ["groupsList", {createHashMap}, true];
if (_groupID in _groupList) then
{
	// try add to existing group
	private _group = _groupList get _groupID;
	private _freeSpaceList = _group get "freeList";
	private _posXY = [_freeSpaceList, _slotRect] call AZ_GUI_fnc_EmptySpace_alloc;
	if (count _posXY > 0) then
	{
		_slotRect set [0, (_posXY#0)];
		_slotRect set [1, (_posXY#1)];
		private _slots = _group get "itemSlots";
		_slots set [_itemID, _slotRect];
		private _groupRect = _group get "rect";
		_pos = [
			((_groupRect#0) + (_slotRect#0)),
			((_groupRect#1) + (_slotRect#1)),
			((_slotRect#2)),
			((_slotRect#3))
		];
		_done = true;
	};	
};

if (not _done) then
{
	if (0 in _groupList) then
	{
		// give 0 group and add to it
		private _group = _groupList get 0;
		private _groupRect = _group get "rect";
		private _freeSpaceList = _group get "freeList";
		private _posXY = [_freeSpaceList, _slotRect] call AZ_GUI_fnc_EmptySpace_alloc;
		if (count _posXY == 0) then
		{ 
			// resize free space and try againe	
			_freeSpaceList pushBack ([0, _freeSpaceAllocY, _mapW, _pageH]);
			_freeSpaceAllocY = _freeSpaceAllocY + _pageH;
			[_freeSpaceList, ((count _freeSpaceList) - 1), 2] call AZ_GUI_fnc_EmptySpace_defragmentation;
			
			_posXY = [_freeSpaceList, _slotPos] call AZ_GUI_fnc_EmptySpace_alloc;
		};
		if (count _posXY > 0) then
		{
			_slotRect set [0, (_posXY#0)];
			_slotRect set [1, (_posXY#1)];
			private _slots = _group get "itemSlots";
			_slots set [_itemID, _slotRect];
			
			_pos = [
				((_groupRect#0) + (_slotRect#0)),
				((_groupRect#1) + (_slotRect#1)),
				((_slotRect#2)),
				((_slotRect#3))
			];
			_done = true;
		};	
	}
	else
	{
		// create 0 group and add to it
	};
};

if (_done) exitWith {_pos};

[]





