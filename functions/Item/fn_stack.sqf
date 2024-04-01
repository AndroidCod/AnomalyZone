// AZ_Item_fnc_stack = 

params ["_itemA", "_itemB"];

if (not([_itemA, _itemB] call AZ_Item_fnc_isEquals)) exitWith {0};

private _configA = _itemA get "config";
private _stack = _configA get "stack";
if (_stack <= 1) exitWith {0};

private _amountA = _itemA get "amount";
if (_amountA == _stack) exitWith {0}; // A is full

private _amountB = _itemB get "amount";
if (_amountB == 0) exitWith {0}; // B is empty

private _d = (_stack - _amountA) min _amountB;
_amountA = _amountA + _d;
_amountB = _amountB - _d;

_itemA set ["amount", _amountA];
_itemB set ["amount", _amountB];

_d
