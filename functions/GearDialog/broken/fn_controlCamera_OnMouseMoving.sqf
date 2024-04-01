//
//player commandChat format ["%1", _this];

params ["_control", "_posX", "_posY", "_mouseOver"];

private _cameraParams = uiNameSpace getVariable ["AZ_GearDialog_Camera", []];
_cameraParams params ["_camera", "_button", "_lastMousePos", "_radius", "_dir", "_z"];

if (_mouseOver and {_button >= 0}) then
{
	private _d = if (_posX - _lastMousePos#0 > 0) then {5} else {-5};
	_dir = _dir + _d;
	_dir = _dir % 360;
	
	_d = if (_posY - _lastMousePos#1 > 0) then {0.075} else {-0.075};
	_z = (((_z + _d) max 0.5) min 2.2);
	
	private _newPos = player getRelPos [_radius, _dir];
	_newPos set [2, _z];	
	_camera camSetPos _newPos;
	_camera camCommit 0.0;

	_cameraParams set [2, [_posX, _posY]];
	_cameraParams set [4, _dir];
	_cameraParams set [5, _z];
	//uiNameSpace setVariable ["AZ_GearDialog_Camera", _cameraParams];
};