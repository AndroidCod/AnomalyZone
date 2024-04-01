

// AZ_GUI_fnc_EmptySpace_defragmentation

params ["_freeSpaceList", "_index", ["_mergeMode", 0]];
// _mergeMode:
// 		0 - ALL
//		1 - DOWN
//		2 - UP

private _rect = (_freeSpaceList#_index);
_rect params ["_rectX", "_rectY", "_rectW", "_rectH"];
private _rectRight = _rectX + _rectW;
private _rectBottom = _rectY + _rectH;

private _isDone = false;
// DOWN
if (_mergeMode == 0 or {_mergeMode == 1}) then 
{
	private _i = 0;
	private _count = count _freeSpaceList;
	for [{_i=(_index + 1)}, {_i < _count}, {_i=_i+1}] do
	{
		private _r = _freeSpaceList#_i;
		_r params ["_iX", "_iY", "_iW", "_iH"];
		
		if (_iY > _rectBottom) exitWith {_isDone = false;};
		
		// RIGHT
		if (_iH == _rectH and { _iY == _rectY and { _iX == _rectRight } }) exitWith
		{
			// merge with Up rect
			_rect set [2, _iW + _rectW];
			_freeSpaceList deleteAt _i;
			
			[_freeSpaceList, _index] call AZ_GUI_fnc_EmptySpace_defragmentation;
			_isDone = true;
		};
		// DOWN
		if (_iX == _rectX and { _iW == _rectW  and {_iY == _rectBottom} }) exitWith
		{
			// merge with Up rect
			_rect  set [3, _iH + _rectH];
			_freeSpaceList deleteAt _i;
			
			[_freeSpaceList, _index] call AZ_GUI_fnc_EmptySpace_defragmentation;
			_isDone = true;
		};
	};
};
if (_isDone) exitWith {};

// UP
if (_mergeMode == 0 or {_mergeMode == 2}) then 
{		
	private _i = 0;
	for [{_i=0}, {_i < _index}, {_i=_i+1}] do
	{
		private _r = _freeSpaceList#_i;
		_r params ["_iX", "_iY", "_iW", "_iH"];
		// UP
		if (_iX == _rectX and { _iW == _rectW  and {_rectY == (_iY + _iH)} }) exitWith
		{
			// merge with Up rect
			_r  set [3, _iH + _rectH];
			_freeSpaceList deleteAt _index;
			
			[_freeSpaceList, _i] call AZ_GUI_fnc_EmptySpace_defragmentation;
			_isDone = true;
		};
		// LEFT
		if (_iH == _rectH and { _iY == _rectY and { _rectX == (_iX + _iW) } }) exitWith
		{
			// merge with Up rect
			_r set [2, _iW + _rectW];
			_freeSpaceList deleteAt _index;
			
			[_freeSpaceList, _i] call AZ_GUI_fnc_EmptySpace_defragmentation;
			_isDone = true;
		};
	};
};
	
