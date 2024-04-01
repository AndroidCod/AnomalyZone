
params ["_control", "_scroll"];

player commandChat format ["%1", _this];


private _cameraParams = uiNameSpace getVariable ["AZ_GearDialog_Camera", []];
_cameraParams params ["_camera", "_button", "_lastMousePos", "_radius", "_dir", "_z"];

private _r = if (_scroll > 0) then {-0.1} else {0.1};
_radius = _radius + _r;
_radius = ((_radius max 1.5) min 3);

private _newPos = player getRelPos [_radius, _dir];
_newPos set [2, _z];	
_camera camSetPos _newPos;
_camera camCommit 0.0;

_cameraParams set [3, _radius];
//uiNameSpace setVariable ["AZ_GearDialog_Camera", _cameraParams];
 
