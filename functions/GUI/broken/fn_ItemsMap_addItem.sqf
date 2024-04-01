// AZ_GUI_fnc_ItemsMap_addItem = 

#define TRACE_MODE
#include "..\macros.hpp"

//ERROR("Broken function");

params ["_ItemsMap", "_itemID", "_item"];

//
private _itemConfig = (_item get "config");
private _groupID = _itemConfig get "group";
private _sortFilter = _ItemsMap get "sortFilter";
if ((count _sortFilter != 0) and {not (_groupID in _sortFilter)}) exitWith {}; 

//
private _sortMode = _ItemsMap get "sortMode";
if (_sortMode == 0) then { _groupID = 0; };

private _mapRect = _ItemsMap get "rect";

// Get/create group
//private _group = [_ItemsMap, _groupID] call AZ_GUI_fnc_ItemsMap_getGroup;
private _groupList = _ItemsMap get "groupsList";
private _group = _groupList get _groupID;
if (isNil "_group") then
{
	// create group if exist
	_mapRect params ["_mapX", "_mapY", "_mapW", ""];
	_group = createHashMap;
	//_group set ["rect", [_mapX, _mapY, _mapW, 0]];
	_group set ["freeList", []];
	_group set ["itemSlots", createHashMap];
	_group set ["sizeChanged", true];
	_groupList set [_groupID, _group];
	
	// find offset Y for new group
	private _groupsID = keys _groupList;
	_groupsID sort false;	
	private _offsetY = _mapY;
	{
		private _gID = _x;
		if (_gID == _groupID) exitWith {};
		private _g = _groupList get _gID;
		(_g get "rect") params ["", "_grY", "", "_grH"];
		_offsetY = _offsetY + _grH;
		//_offsetY = _grY + _grH;
		
	} forEach _groupsID;
	//TRACE_1("%1", _offsetY);
	_group set ["rect", [_mapX, _offsetY, _mapW, 0]];
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
	_posXY = [0, _groupH];
	if (_slotW < _groupW) then
	{
		private _freeRect = [_slotW, _groupH, (_groupW - _slotW), (_slotH)];
		_freeSpaceList pushBack _freeRect;
	};
	_groupRect set [3, _groupH + _slotH];
	_group set ["sizeChanged", true];
	_mapRect set [3, (_mapRect#3) + _slotH];
};
_slotRect set [0, (_posXY#0)];
_slotRect set [1, (_posXY#1)];

private _slots = _group get "itemSlots";
_slots set [_itemID, _slotRect];

_slotRect


/*
params ["_ItemsMap", "_itemID", "_item"];

private _sortMode = _ItemsMap get "sortMode";
private _sortFilter = _ItemsMap get "sortFilter";

private _itemConfig = (_item get "config");
private _groupID = 0;
if (_sortMode == 1) then { _groupID = _itemConfig get "group"; };
if ((count _sortFilter != 0) and {not (_groupID in _sortFilter)}) exitWith {}; 

//private _autoResize = _ItemsMap get "autoResize";

// get/create group 	
private _groupList = _ItemsMap get "groupsList";
private _group = _groupList get _groupID;
//if (isNil "_group" and {not _autoResize})
if (isNil "_group") then
{
	_groupID = 0;
	_group = _groupList get _groupID;
	if (isNil "_group") then
	{
		private _mapRect = _ItemsMap get "rect";
		_mapRect params ["_mapX", "_mapY", "_mapW", "_mapH"];
		// create group
		_group = createHashMap;
		_group set ["rect", [_mapX, _mapY + _mapH, _mapW, 0]];
		_group set ["freeList", []];
		_groupList set [_groupID, _group];
	};
};

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
	private _mapRect = _ItemsMap get "rect";
	_mapRect set [3, (_mapRect#3) + _slotH];
};
_slotRect set [0, (_posXY#0)];
_slotRect set [1, (_posXY#1)];

private _itemSlotList = _ItemsMap get "itemSlots";
_itemSlotList set [_itemID, _slotRect];

_slotRect

*/