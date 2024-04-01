
// AZ_GUI_fnc_ItemsMap_fillGroup = 
params ["_ItemsMap", "_groupID"];

private _container = _ItemsMap get "container";
private _itemsList = _container get "itemsList";

private _groupList = _ItemsMap get "groupsList";
private _group = _groupList get _groupID;
private _slots = _group get "itemSlots";
private _itemsListID = keys _slots;

// sort items by max Group_Type_Height_Width
_itemsListID = [_itemsListID, [_itemsList], AZ_Item_fnc_hashSortBy, "DESCEND"] call BIS_fnc_sortBy;
//player sideChat format["%1", _itemsListID];
private _mapRect = _ItemsMap get "rect"; // [0, 0, 19, 0];
_mapRect params ["_mapX", "_mapY", "_mapW", "_mapH"];
private _pageH = 30;
private _freeSpaceAllocY = _pageH;
private _freeSpaceList = [[0, 0, _mapW, _pageH]];	
{
	private _id = _x;
	private _item = (_itemsList get _id);
	private _slotSize = (_item get "config") get "slotSize";
	
	private _posXY = [_freeSpaceList, _slotSize] call AZ_GUI_fnc_EmptySpace_alloc;
	if (count _posXY == 0) then
	{ 
		// resize free space and try againe	
		_freeSpaceList pushBack ([0, _freeSpaceAllocY, _mapW, _pageH]);
		_freeSpaceAllocY = _freeSpaceAllocY + _pageH;
		[_freeSpaceList, ((count _freeSpaceList) - 1), 2] call AZ_GUI_fnc_EmptySpace_defragmentation;
		
		_posXY = [_freeSpaceList, _slotSize] call AZ_GUI_fnc_EmptySpace_alloc;
	};
	if (count _posXY == 0) exitWith { ["[ERROR] GearDialog: Can`t found empty pos in the ItemsMap"] call BIS_fnc_error; };
	
	private _slotPos = (_slots get _id);
	_slotPos set [0, (_posXY#0)];
	_slotPos set [1, (_posXY#1)];
	_slotPos set [2, (_slotSize#0)];
	_slotPos set [3, (_slotSize#1)];
		
} forEach _itemsListID;

if (count _freeSpaceList > 0) then
{
	private _last = (_freeSpaceList select -1);
	// _last params ["_rectX", "_rectY", "_rectW", "_rectH"];
	_last params ["", "", "_rectW", "_rectH"];
	if (_rectW == _mapW) then
	{
		_freeSpaceList deleteAt (count _freeSpaceList - 1);
		_freeSpaceAllocY = _freeSpaceAllocY - _rectH;
	};
}; 

_group set ["rect", [_mapX, _mapY + _mapH, _mapW, _freeSpaceAllocY]];
_mapRect set [3, (_mapH + _freeSpaceAllocY + 1)];

_group set ["freeList", _freeSpaceList];

