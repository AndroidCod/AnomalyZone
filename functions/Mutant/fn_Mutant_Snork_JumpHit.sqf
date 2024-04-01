//

params ["_unit", "_target", "_attackData"];

// _attackData - HashMap, preloaded config

_unit allowDammage false;
//_unit enableSimulation false;

private _vel = velocity _unit;
private _dir = direction _unit;
private _speed = (_attackData get "jumpSpeed"); 
_unit setVelocity [
	(_vel select 0) + (sin _dir * _speed), 
	(_vel select 1) + (cos _dir * _speed), 
	(_vel select 2) + 3
];

private _d = _attackData get "duration";
sleep (_d#0);

//_unit enableSimulation true;
_unit allowDammage true;