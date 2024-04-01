// 

params ["_group"];

// stop loop for dead group
//if ({alive _x} count units _group < 1) exitWith {};

private _size = 0;
// Init units
{
	if (alive _x) then 
	{
		_size = _size + 1;
		if (captiveNum _x == 0) then { _x setCaptive AZ_AI_CaptiveNumber; };
		// _x addEventHandler ["Fired", az_fnc_AI_onFired]; 
	};
	
} forEach units _group;

if (_size < 1) exitWith {};

// Schedule the loop to be executed again N sec later
//[az_fnc_AI_groupBehaviorLoop, _this, AZ_AI_SpotDelaySafe] call CBA_fnc_waitAndExecute;

private _delay = 1;
while {_delay > 0} do 
{	
	sleep _delay;
	_delay = _this call az_fnc_AI_groupBehaviorLoop;
};


//player groupChat format ["Loop exit: %1 ", groupID _group];
