// AZ_GUI_fnc_EmptySpace_findInsertIndex 

params ["_freeSpaceList", "_rect"];

//private _insertIndex = [_freeSpaceList, _rect] call AZ_GUI_fnc_EmptySpace_findInsertIndex;

// find Insert Index
_rect params ["_rectX", "_rectY"];
private _i = 0;
private _count = count _freeSpaceList;
for [{_i=0}, {_i < _count}, {_i=_i+1}] do
{
	// _r params ["_rectX", "_rectY", "_rectW", "_rectH"];
	private _r = _freeSpaceList select _i;
	_r params ["_iX", "_iY"];
	if ((_iY > _rectY) or { (_iY == _rectY) and {_iX > _rectX} }) exitWith {};
};

_freeSpaceList insert [_i, [_rect], false];

[_freeSpaceList, _i] call AZ_GUI_fnc_EmptySpace_defragmentation;
