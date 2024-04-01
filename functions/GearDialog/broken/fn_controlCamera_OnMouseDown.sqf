//
player commandChat format ["%1", _this];

params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

private _cameraParams = uiNameSpace getVariable ["AZ_GearDialog_Camera", []];

_cameraParams params  ["_camera"];

_cameraParams set [1, _button];
_cameraParams set [2, [_xPos, _yPos]];

uiNameSpace setVariable ["AZ_GearDialog_Camera", _cameraParams];
