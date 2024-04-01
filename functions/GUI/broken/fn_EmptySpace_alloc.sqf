// AZ_GUI_fnc_EmptySpace_alloc 

params ["_freeSpaceList", "_itemSlotSize"];

_itemSlotSize params ["", "", "_itemW", "_itemH"];

private _rectIndex = -1;
private _rect = [];
for [{_i=0}, {_i < count _freeSpaceList}, {_i=_i+1}] do
{
	private _r = _freeSpaceList#_i;
	// _r params ["_rectX", "_rectY", "_rectW", "_rectH"];
	_r params ["", "", "_rectW", "_rectH"];
	if (_itemW <= _rectW and {_itemH <= _rectH}) exitWith {_rect = _r; _rectIndex = _i;};
};

// if no have space
if (_rectIndex < 0) exitWith {};

_rect params ["_rectX", "_rectY", "_rectW", "_rectH"];
private _posXY = [_rectX, _rectY];

//private _splitX = _itemW < _itemH;
private _splitX = true;
// Split X (have two split method by X and by Y. We use by X) 

if (_itemW == _rectW) then
{
	_freeSpaceList deleteAt _rectIndex;
}
else
{
	_rect set [0, _rectX + _itemW];
	_rect set [1, _rectY];
	_rect set [2, _rectW - _itemW];
	if (_splitX) then 
	{
		_rect set [3, _itemH];
	} 
	else 
	{
		_rect set [3, _rectH];
	};
	[_freeSpaceList, _rectIndex] call AZ_GUI_fnc_EmptySpace_defragmentation;
};
	
if (_itemH < _rectH) then 
{
	if (_splitX) then 
	{
		_rect = [_rectX, _rectY + _itemH, _rectW, _rectH - _itemH];
	}
	else
	{
		_rect = [_rectX, _rectY + _itemH, _itemW, _rectH - _itemH];
	};
	
	[_freeSpaceList, _rect] call AZ_GUI_fnc_EmptySpace_addRect;
};

_posXY
