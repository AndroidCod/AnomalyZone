
// AZ_GUI_fnc_FillControlsGroup 
/*
params ["_display", "_ctrlGroupIDC", "_baseY", "_ctrlGroupW", "_itemsList", "_itemsListID"];

private _pageH = 30;
//private _itemsList = _container get "itemsList";
//_ctrlGroupSize params ["_ctrlGroupW", "_pageH"];
private _freeSpaceAllocY = _pageH;
private _freeSpaceList = [[0, 0, _ctrlGroupW, _pageH]];

private _ctrlGroup = _display displayCtrl _ctrlGroupIDC;
// fill controlsGroup by slots
{
	
	private _id = _x;
	private _item = (_itemsList get _id);
	private _itemSlotSize = _item get "slotSize";
	
	private _posXY = [_freeSpaceList, _itemSlotSize] call AZ_GUI_fnc_EmptySpace_alloc;
	if (count _posXY == 0) then
	{ 
		// resize free space and try againe	
		_freeSpaceList pushBack ([0, _freeSpaceAllocY, _ctrlGroupW, _pageH]);
		_freeSpaceAllocY = _freeSpaceAllocY + _pageH;
		[_freeSpaceList, ((count _freeSpaceList) - 1), 2] call AZ_GUI_fnc_EmptySpace_defragmentation;
		
		_posXY = [_freeSpaceList, _itemSlotSize] call AZ_GUI_fnc_EmptySpace_alloc;
	};
	if (count _posXY == 0) exitWith { ["[ERROR] GearDialog: Can`t found empty pos in the ItemsMap"] call BIS_fnc_error; };
	
	private _idc = _ctrlGroupIDC + _id;
	//player sideChat format["%1", _idc];
	[_display, _idc, _item, _ctrlGroup] call AZ_GUI_fnc_ItemSlot_Create;
	private _pos = [
		((_posXY#0) * _GRID_W),
		((_baseY + (_posXY#1)) * _GRID_H),
		((_itemSlotSize#0) * _GRID_W),
		((_itemSlotSize#1) * _GRID_H)
	];
	[_display, _idc, _pos] call AZ_GUI_fnc_ItemSlot_SetPosition;
		
} forEach _itemsListID;

if (count _freeSpaceList > 0) then
{
	private _last = (_freeSpaceList select -1);
	// _last params ["_rectX", "_rectY", "_rectW", "_rectH"];
	_last params ["", "", "_rectW", "_rectH"];
	if (_rectW == _ctrlGroupW) then
	{
		_freeSpaceList deleteAt (count _freeSpaceList - 1);;
		_freeSpaceAllocY = _freeSpaceAllocY - _rectH;
	};
}; 

(_baseY + _freeSpaceAllocY + 1)
*/
/* // DEBUG
if (count _freeSpaceList > 0) then
{
	{
		private _rect = _x;
		private _idc = 80000 + 10*_forEachIndex;
		//player sideChat format["%1", _idc];
		[_display, _idc, _ctrlGroup] call AZ_GUI_fnc_ItemSlot_Create;
		private _pos = [
			((_rect#0) * _GRID_W),
			((_rect#1) * _GRID_H),
			((_rect#2) * _GRID_W),
			((_rect#3) * _GRID_H)
		];
		[_display, _idc, _pos] call AZ_GUI_fnc_ItemSlot_SetPosition;
		private _ctrl = _display displayCtrl _idc + 0;
		_ctrl ctrlSetBackgroundColor [ random 1, random 1, random 1, 0.5];
		_ctrl ctrlCommit 0;
		
		_ctrl = _display displayCtrl _idc + 2;
		_ctrl ctrlSetStructuredText parseText "";
		_ctrl ctrlCommit 0;	
		
		_ctrl = _display displayCtrl _idc + 3;
		_ctrl ctrlSetText "";
		_ctrl ctrlCommit 0;
		
	} forEach _freeSpaceList;
};*/
