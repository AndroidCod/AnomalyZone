// az_fnc_Mutant_runBehavior

params ["_unit", "_group", "_center", "_radius"];

if (not alive _unit) exitWith {}; 

//private _type = _unit getVariable ["AZ_Mutant_Type", ""];
//if (_type == "") exitWith {}; 
//private _type = _unit getVariable "AZ_Type";
//player sidechat format ["type: [%1]", _type];
private _config = missionConfigFile >> "cfgMutants" >> (_unit getVariable "AZ_Type");
//private _config = (missionConfigFile >> "cfgMutants" >> (typeOf _unit)) call az_fnc_loadConfigToHashMap;

private _actionsSafe = ((_config >> "actionsSafe") call BIS_fnc_getCfgData);
private _actionsCombat = ((_config >> "actionsCombat") call BIS_fnc_getCfgData);
private _actionsCombatNoTarget = ((_config >> "actionsCombatNoTarget") call BIS_fnc_getCfgData);

private _rangeToChangeTarget = ((_config >> "rangeToChangeTarget") call BIS_fnc_getCfgData);
private _targetForgetTimeout = ((_config >> "targetForgetTimeout") call BIS_fnc_getCfgData);
private _timeToSafe = ((_config >> "timeToSafe") call BIS_fnc_getCfgData);
private _escapeRange = ((_config >> "escapeRange") call BIS_fnc_getCfgData);
private _volumDistance = ((_config >> "volumDistance") call BIS_fnc_getCfgData);

private _haveAoEAttack = (isClass (_config >> "aoe_attack"));
private _AoEAttackData = nil;
private _AoEAttackTimeOut = 0;
if (_haveAoEAttack) then
{
	_AoEAttackData = (_config >> "aoe_attack") call az_fnc_loadConfigToHashMap;
	// precompile hit handler
	private _hit = _AoEAttackData getOrDefault ["hit", nil];
	if (not isNil "_hit") then
	{					
		_AoEAttackData set ["hit", compile _hit];
	};	 
};

private _isCombat = false;
private _target = objNull;
private _targetSpotTime = 0;
private _targetSpotFreezeTime = 0;
private _moveParams = [];

private _action = "";
private _actionData = nil;
private _actionParams = [false];
private _actionsList = createHashMap;
private _actionIsSound = false;
private _actionSoundTimeOut = 0; 
private _actionIsAnim = false;
private _actionAnimTimeOut = 0;

private _delay = 1;

// !!! good practical run animation in unscheduled environment 
private _fnc_playRandomMove =
{
	//_unit playMove _move;
	if (count _this > 0) then
	{	
		private _move = selectRandom _this;
		[{_unit switchMove _this; _unit playMoveNow _this;}, _move] call CBA_fnc_directCall;
		//player sidechat format ["anim change to:   [ %1 ]", _move];
	};
};

private _soundSource = objNull;
private _fnc_say3D =
{
	if (count _this > 0) then
	{	
		// from say3D [sound, maxDistance, pitch, isSpeech, offset]
		if (not isNull _soundSource) then { deleteVehicle _soundSource; };
		_soundSource = _unit say3D [(selectRandom _this), _volumDistance, 1, 1]; // volume * distance
	};
};

private _fnc_actionDone = 
{	 
	params ["_next"];
	_action = _next;
	_actionParams set [0, false]; // _started
	_actionIsSound = false;
	_actionIsAnim = false;

	_actionData = _action call _fnc_getActionData;

	_actionIsSound = (count(_actionData getOrDefault ["sounds", []]) > 0); //(_actionData get "isSound");
	if (_actionIsSound) then 
	{		
		_actionSoundTimeOut = time + (_actionData get "soundStartDelay");
	};
	
	_actionIsAnim = (count(_actionData getOrDefault ["animations", []]) > 0); //(_actionData get "isAnim");
	if (_actionIsAnim) then
	{
		_actionAnimTimeOut = time + (_actionData get "animStartDelay");
	};
		
	_delay = 0;
	
	player sidechat format ["'%1'", _action];
};

private _fnc_getActionData = 
{
	params ["_action"];
	
	private _a = _actionsList getOrDefault [_action, nil];
	if (isNil "_a") then
	{
		_a = (_config >> "Actions" >> _action) call az_fnc_loadConfigToHashMap;
		
		// precompile hit handler
		private _hit = _a getOrDefault ["hit", nil];
		if (not isNil "_hit") then
		{
			_a set ["hit", compile _hit];
		};
		
		_actionsList set [_action, _a];
	};
	
	_a
};

private _fnc_moveTo =
{
	//params ["_targetPosATL"];		
	
	_unit stop false;
	_unit moveTo (_moveParams#0);
	//_unit setDestination [(_moveParams#0), "LEADER PLANNED", true];
};

private _fnc_moveToCompleted = 
{
	// must be: _this == _moveParams
	_moveParams params ["_targetPosATL", "_lastPosition", "_lastPositionTime"];
	
	// if (_unit inArea [_position, AZ_Mutant_WayPointRange, AZ_Mutant_WayPointRange, 0, false]) then 
	//if ((_currentPos distance _position) < AZ_Mutant_WayPointRange) then
	private _currentPos = getPosATL _unit;
	if (moveToCompleted _unit) exitWith 
	{
		// update last position
		_moveParams set [1, _currentPos]; // _lastPosition	
		_moveParams set [2, time]; // _lastPositionTime	
		1
	}; // move completed

	//if (moveToFailed _unit) exitWith { 2 }; // move failed
	
	private _moveState = 0; // moving
	
	if ((_currentPos distance _lastPosition) < 0.15) then
	{
		if (time > (_lastPositionTime + (_delay * 3))) then
		{
			//player sidechat format ["Застрял! %1", name _unit]; 
			// update last position
			_moveParams set [1, _currentPos]; // _lastPosition	
			_moveParams set [2, time]; // _lastPositionTime	
			_moveState = 2; // move failed
		};
	}
	else
	{
		// update last position
		_moveParams set [1, _currentPos]; // _lastPosition	
		_moveParams set [2, time]; // _lastPositionTime	
	};
	
	// 0 - moving; 1 - completed; 2 - failed;
	_moveState	
};

private _fnc_getParamRand =
{
	//params ["_name"];	
	private _array = _actionData get _this;
	((_array#0) + (random (_array#1)))
};

private _fnc_findEmptyPos =
{
	private _pos = (_center getPos [random _radius, random 360]);
	/*private _c = 0;
	private _max_distance = 25;
	while {_c < 10 and count _pos < 1 } do
	{
		_pos = _center findEmptyPosition [1, _max_distance, typeOf _unit];
		_max_distance = ((_max_distance + 5) min _radius);
		_c = _c + 1;
	};*/
	private _posE = _pos findEmptyPosition [1, 15, typeOf _unit];
	if (count _posE > 1) then
	{
		_pos = _posE;
	};
	_pos set [2, 0];
	_pos
};

private _fnc_checkTarget =
{
	// Check target validate
	if (isNull _target) then
	{
		private _targetList = [_unit] call AZ_fnc_Mutant_spotEnemy;
		if (count _targetList > 0) then
		{
			_target = (_targetList#0);
			_targetSpotTime = time; 
		};
	}
	else
	{
		if (alive _target) then
		{
			private _targetList = [_unit] call AZ_fnc_Mutant_spotEnemy;
			if (_target in _targetList) then
			{
				private _newTarget = (_targetList#0);
				if (((_unit distance _target) - (_unit distance _newTarget)) > _rangeToChangeTarget) then
				{
					_target = _newTarget; // _target
				};
				_targetSpotTime = time; 
			}
			else
			{
				if (time > (_targetSpotTime + _targetForgetTimeout)) then
				{
					_target = objNull; 
					_targetSpotTime = time; 
				};
			};	
		}
		else
		{
			_target = objNull; // _target
			_targetSpotTime = time; 
		};			
	};
};

(selectRandomWeighted _actionsSafe) call _fnc_actionDone;

while {alive _unit} do
{
	// check target
	if (time >= _targetSpotFreezeTime) then 
	{
		_targetSpotFreezeTime = time + (_actionData get "spotDelay");
		call _fnc_checkTarget;
	};
	
	// check combat mode
	if (_isCombat) then
	{
		// Safe mode
		if ((isNull _target) and (time > (_targetSpotTime + _timeToSafe))) then
		{
			// goto Safe state
			_isCombat = false;
			_unit setCombatBehaviour "CARELESS";
			(selectRandomWeighted _actionsSafe) call _fnc_actionDone;
		};
	}
	else
	{
		if (not isNull _target) then
		{
			_isCombat = true;
			_unit setCombatBehaviour "COMBAT";
			(selectRandomWeighted _actionsCombat) call _fnc_actionDone;
		};
	};

	_unit forceWalk (_actionData get "walk" > 0);
	_delay = _actionData get "delay";
	_unit setAnimSpeedCoef (_actionData get "animSpeedCoef");

	// Sounds
	if (_actionIsSound) then
	{
		if (time >= _actionSoundTimeOut) then
		{
			_actionSoundTimeOut = (time + ("soundDelay" call _fnc_getParamRand));
			(_actionData get "sounds") call _fnc_say3D;
		};
	};
	
	// Animations
	if (_actionIsAnim) then
	{			
		if (time >= _actionAnimTimeOut) then 
		{
			_actionAnimTimeOut = (time + ("animDelay" call _fnc_getParamRand));
			(_actionData get "animations") call _fnc_playRandomMove;
		};
	};	
	
	// AoE attack
	if (_haveAoEAttack) then
	{
		private _combat = _AoEAttackData get "combat";
		if ((_combat == 0) or (_combat > 0 and _isCombat)) then
		{
			if (time >= _AoEAttackTimeOut) then
			{
				_AoEAttackTimeOut = time + (_AoEAttackData get "reload");
				private _hit = _AoEAttackData getOrDefault ["hit", nil];
				if (not isNil "_hit") then
				{					
					[_unit, _AoEAttackData] call _hit;
				};
			};
		};
	};
	
	// Simulation
	private _simulation = _actionData getOrDefault ["simulation", ""];
	switch (_simulation) do
	{
		case "inspect":
		{
			// lost target
			if (isNull _target) exitWith { (selectRandomWeighted (_actionData get "actionsNoTarget")) call _fnc_actionDone; };	
			
			// init
			if (not(_actionParams#0)) then
			{
				_actionParams set [0, true]; // _started
				_actionParams set [1, 0]; // _panicCheckTimeOut
				
				_moveParams set [0, getPosATL _target];
				_moveParams set [1, getPosATL _unit];
				_moveParams set [2, time];
				call _fnc_moveTo;
			};
			
			// Panic
			private _doPanic = false;
			private _actionsPanic = (_actionData getOrDefault ["actionsPanic", []]);
			if ((count _actionsPanic) > 0) then
			{
				private _panicCheckTimeOut = (_actionParams#1);
				if (time > _panicCheckTimeOut) then
				{
					// _panicCheckTimeOut = time + (_actionData get "panicCheckDelay");
					_actionParams set [1, (time + (_actionData get "panicCheckDelay"))]; // _panicCheckTimeOut
					_doPanic = ((random 1.0 <= (_actionData get "panicChance")) and ({alive _x} count _group < 2));
					/* if ((random 1.0 <= (_actionData get "panicChance")) and ({alive _x} count _group < 2)) then
					{						
						_doPanic = true;
					}; */
				};
			};		
			if (_doPanic) exitWith 
			{					
				(selectRandomWeighted _actionsPanic) call _fnc_actionDone;				
				private _duration = (time + ("duration" call _fnc_getParamRand));
				_targetSpotFreezeTime = _duration;
				_target = objNull;
				_targetSpotTime = _duration;
			};
			
			// Escape range
			if ((_unit distance _center) > (_radius max _escapeRange)) exitWith
			{
				_targetSpotFreezeTime = time + 10;
				_target = objNull;
				_targetSpotTime = time;
				(selectRandomWeighted (_actionData get "actionsNoTarget")) call _fnc_actionDone;
			};
			
			private _doMove = true;
			private _dist = _unit distance _target;
			private _attackList = _actionData get "attackList";
			{
				private _attack = _x;
				private _data = _attack call _fnc_getActionData;
				private _range = _data get "range";
				private _chance = _data get "chance";
				// if (_dist <= _range) exitWith { _doAttack = true;	};
				if ((_dist >= (_range#0)) and (_dist <= (_range#1)) and ((random 1.0) <= _chance)) exitWith 
				{
					_doMove = false;
					_attack call _fnc_actionDone;
					_targetSpotFreezeTime = time + ((_data get "duration")#0);
				};
				
			} forEach _attackList;
			
			if (_doMove) then
			{
				//player sidechat format ["moveState = %1", (_moveParams call _fnc_moveToCompleted)]; 
				if ((call _fnc_moveToCompleted) == 2) then // move failed
				{
					player sidechat format ["inspect failed"]; 
					_targetSpotFreezeTime = time + 7;
					_target = objNull;
					_targetSpotTime = time;						
					(selectRandomWeighted (_actionData get "actionsNoTarget")) call _fnc_actionDone;
				}
				else
				{						
					private _p = (getPosASL _target);
					_p = _p vectorAdd ((velocity _target) vectorMultiply 0.5); 
					_p = ASLToATL _p;
					//player sidechat format ["attack position: %1", vectorMagnitude velocity player]; 
					_moveParams set [0, _p];							
					call _fnc_moveTo;
					//_actionParams set [2, _moveParams];
				};						
			};
		};
		case "move":
		{
			if (not isNull _target) exitWith { (selectRandomWeighted _actionsCombat) call _fnc_actionDone; }; 
			
			if (not (_actionParams#0)) then
			{
				_actionParams set [0, true]; // _started	
				
				_moveParams set [0, call _fnc_findEmptyPos];
				_moveParams set [1, (getPosATL _unit)];
				_moveParams set [2, time];
				call _fnc_moveTo;
			};
			
			//_actionParams params["_started"];
			private _state = (call _fnc_moveToCompleted);
			if (_state == 2) then { player sidechat format ["move failed"];}; 
			if (_state > 0) then
			{		
				if (_actionData get "loop" > 0) then 
				{					
					_moveParams set [0, call _fnc_findEmptyPos];
					call _fnc_moveTo;
				}
				else
				{
					private _a = if (_isCombat) then {_actionsCombat} else {_actionsSafe};
					(selectRandomWeighted _a) call _fnc_actionDone;
				};
			};			
		};
		case "stop":
		{
			if (not(_actionParams#0)) then
			{
				_actionParams set [0, true]; // _started	
				_actionParams set [1, (time + ("duration" call _fnc_getParamRand))]; // _timeOut	
				
				if (_isCombat and (not isNull _target)) then
				{
					_unit setDir ((getDir _unit)  + (_unit getRelDir _target));
					private _hit = _actionData getOrDefault ["hit", nil];
					if (not isNil "_hit") then
					{
						[_unit, _target, _actionData] call _hit;
					};
				};
				//_unit stop true;
			};
			//_actionParams params[["_started", false], ["_timeOut", 0]];
			if (time >= (_actionParams#1)) then
			{
				private _a = if (_isCombat) then {_actionsCombat} else {_actionsSafe};
				(selectRandomWeighted _a) call _fnc_actionDone;
			};
		};
		default 
		{
			["[ERROR] Unsuported action simulation %1", _action] call BIS_fnc_error;
			(selectRandomWeighted _actionsSafe) call _fnc_actionDone;
		};
	};	
	
	sleep _delay;
};

player sidechat format ["Mutant die [%1] ", name _unit]; 


