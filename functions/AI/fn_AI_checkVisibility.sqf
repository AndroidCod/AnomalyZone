
params ["_unit", "_target", ["_visibilityThreshold", 0.5]];



//private _hitPoints = []; //(selectionNames _unit) select { (_unit selectionPosition [_x, "HitPoints"] isNotEqualTo [0,0,0]) };
private _Visibility = false;
private _unitEye = eyePos _unit;
private _targetEye = eyePos _target;

private _canSee = [_unit, "VIEW", _target] checkVisibility [_unitEye, _targetEye];

/*if (_target getVariable ["AZ_IsMutant", false]) then
{
	//if (not _Visibility) then {  }
	player sideChat format ["[%1]", _canSee];
};*/
/* 
private _c = [0, 1, 0, 1];
if (_canSee == 0) then 
{
	_c = [1, 0, 0, 1]
};
if (_canSee > 0 && _canSee <= _visibilityThreshold) then 
{
	_c = [1, 1, 0, 1]
};
drawLine3D [ASLToAGL _unitEye, ASLToAGL _targetEye, _c];
 */	
if (_canSee > _visibilityThreshold) then
{
	_Visibility = true;
};
if (_Visibility) exitWith{true};

/*
[
	"spine1","spine2","spine3","head","leftarm","leftarmroll","leftforearm","rightarm","rightarmroll","rightforearm",
	"pelvis","leftupleg","leftuplegroll","leftlegroll","leftfoot","rightupleg","rightuplegroll","rightleg","rightlegroll","rightfoot"
]
*/
// ["HitLeftArm", "HitRightArm", "HitLeftLeg", "HitRightLeg", "HitBody"];
private _allSelections = ["head", "leftarm", "rightarm", "pelvis", "leftlegroll", "rightlegroll"];
//private _allSelections = (selectionNames _target);
{
	private _pos = _target selectionPosition [_x, "HitPoints"];
	if (_pos isNotEqualTo [0,0,0]) then
	{
		private _posASL = _target modelToWorldWorld  _pos;
		private _canSee = [_unit, "VIEW", _target] checkVisibility [_unitEye, _posASL];
				
/* 		
	 	private _c = [0, 1, 0, 1];
		if (_canSee == 0) then 
		{
			_c = [1, 0, 0, 1]
		};
		if (_canSee > 0 && _canSee < _visibilityThreshold) then 
		{
			_c = [1, 1, 0, 1]
		};
		drawLine3D [ASLToAGL _unitEye, ASLToAGL _posASL, _c];
		 */	 
		
		if (_canSee > _visibilityThreshold) then
		{
			_Visibility = true;
		};
		//_hitPoints pushBack (_target modelToWorldWorld _pos); //([_x, _pos]);
	};
	
	if (_Visibility) exitWith{};
	
} forEach _allSelections;



_Visibility



