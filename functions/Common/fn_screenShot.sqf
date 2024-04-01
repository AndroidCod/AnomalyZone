disableSerialization;

//params ["_display", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];
//params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

params ["_mode", "_param"];

if (_mode == "apply") exitWith 
{
	_param params ["_control"];
	
	private _parent = (ctrlParent _control);
	private _item =  ctrlText (_parent displayCtrl 80);
	private _model = nil;
	private _list = ["cfgVehicles", "cfgWeapons", "cfgMagazines", "cfgAmmo"];
	{
		systemChat format ["%1", _item];
		if (isClass (configFile >> _x >> _item)) then 
		{
			_model = (configFile >> _x >> _item >> "model") call BIS_fnc_getCfgData;
			if (not isNil "_model") exitWith { (_parent displayCtrl 50) ctrlSetModel _model; };		
		};
		
	} forEach _list;
	
	true
};

if (_mode == "slider") exitWith
{
	_param params ["_control", "_newValue"];
	
	private _display = ctrlParent _control;
	if (isNull _display) exitWith { false };
	/*
	if (ctrlIDC _control in [99]) exitWith
	{
		//[_display displayCtrl 100, _newValue] call AZ_fnc_screenShot;
	}; 
	*/
	private _dir = [0, 0, 0];
	private _up = [0, 0, 0];

	if (ctrlIDC _control >= 100) then
	{
		_control ctrlSetText "0";
		_control ctrlCommit 0;
	};
	/*private _t = ctrlText _control;
	if (_t isEqualTo "0") then
	{
		_t = "1";	
	}
	else
	{
		_t = "0";
	}; 
	_control ctrlSetText _t;
	_control ctrlCommit 0;
	*/	
	private _ctrl = _display displayCtrl 100;
	_dir set [0, parseNumber ctrlText _ctrl];

	_ctrl = _display displayCtrl 101;
	_dir set [1, parseNumber ctrlText _ctrl];

	_ctrl = _display displayCtrl 102;
	_dir set [2, parseNumber ctrlText _ctrl];

	_ctrl = _display displayCtrl 200;
	_up set [0, parseNumber ctrlText _ctrl];

	_ctrl = _display displayCtrl 201;
	_up set [1, parseNumber ctrlText _ctrl];

	_ctrl = _display displayCtrl 202;
	_up set [2, parseNumber ctrlText _ctrl];

	_ctrl = (_display displayCtrl 50);
	_ctrl ctrlSetModelDirAndUp [_dir, _up];
	_ctrl ctrlCommit 0;

	//systemChat str ['onMouseButtonDown', _this]

	true
};
