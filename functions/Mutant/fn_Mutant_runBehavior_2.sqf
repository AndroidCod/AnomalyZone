// az_fnc_Mutant_runBehavior

params ["_unit", "_group", "_center", "_radius"];

if (not alive _unit) exitWith {}; 

//private _type = _unit getVariable ["AZ_Mutant_Type", ""];
//if (_type == "") exitWith {}; 

private _config = missionConfigFile >> "cfgMutants" >> (typeOf _unit);

private _actionsList = createHashMap;
private _actionType = "";
private _action = nil;
private _actionIsSound = false;
private _actionSoundTimeOut = 0;
private _actionIsAnim = false;
private _actionAnimTimeOut = 0;
private _delay = 1;
private _spotTimeOut = 0;
private _target = objNull;
private _targetSpotTime = 0;


private _fnc_getAction = 
{
	params ["_type"];
	
	private _a = _actionsList getOrDefault [_type, nil];
	if (isNil "_a") then
	{
		//_a = _this call _fnc_loadAction;
		_a = (_config >> "Actions" >> _type) call az_fnc_loadConfigToHashMap;
		_actionsList set [_type, _a];
	};
	_a
};

private _fnc_getTimeOut
{
	params ["_timerName", ["_isStart", false]];
	
	if (_isStart) exitWith { time + ((_action get _timerName)#0) };
	
	private _timer = (_action get _timerName);
	time + _timer#0 + random _timer#1
};

private _fnc_actionDone = 
{	 
	params ["_next"];
	_actionType = _next;
	//_actionParams set [0, false]; // _started
	//_actionIsSound = false;
	//_actionIsAnim = false;

	_action = _actionType call _fnc_getAction;
	
	// init new action
	_actionIsSound = (count(_action getOrDefault ["sounds", []]) > 0);
	if (_actionIsSound) then 
	{		
		_actionSoundTimeOut = ["soundTimer", true] call _fnc_getTimeOut;
	};
	
	_actionIsAnim = (count(_actionData getOrDefault ["animations", []]) > 0); //(_actionData get "isAnim");
	if (_actionIsAnim) then
	{
		_actionAnimTimeOut = ["animTimer", true] call _fnc_getTimeOut;
	};
	
	_actionDelay = 0;
	
	player sidechat format ["'%1'", _action];
};

private _fnc_checkTargetSafe = 
{	
	if (time >= _spotTimeOut) then 
	{
		_spotTimeOut = time + (_action get "spotDelay");
		private _targetList = [_unit] call AZ_fnc_Mutant_spotEnemy;
		if (count _targetList > 0) then
		{
			_target = (_targetList#0);
			_targetSpotTime = time;
		};
	};
};

private _fnc_simulationStop =
{
	_delay = _action get "delay";
	
	if (_action get "isCombat" > 0) then
	{
		call _fnc_checkTargetCombat;
	}
	else
	{
		call _fnc_checkTargetSafe;
	};
	
	if (isNull _target) then
	{
		
		
		sleep _delay;
	}
	else
	{
		_unit setCombatBehaviour "COMBAT";
		(selectRandomWeighted (_action get "nextCombat")) call _fnc_actionDone;
	};

};

while {alive _unit} do
{	
	// do current action
	_unit forceWalk (_action get "walk" > 0);
	_unit setAnimSpeedCoef (_action get "animSpeedCoef");
	
	
	// simulation
	private _simulation = _actionData getOrDefault ["simulation", ""];
	switch (_simulation) do
	{
		case "inspect": {};
		case "move": {};
		case "stop": _fnc_simulationStop;
		case "melee": {};
		case "range": {};
		default {};
	};
};