// az_fnc_AI_getFogPowerASL = 

// params ["Z"]
fogParams params ["_fogPower","_fogDecay","_fogHeight"] ;
private _height = _this - _fogHeight;
(_fogPower*(1/2)^(_height*_fogDecay/2.45) max 0)

