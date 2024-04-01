//az_fnc_getDayPhase

//player groupChat format ["%1", _cash];

//            NIGHT              SUNRISE             DAY                   SUNSET           NIGHT
// ------------- 00.00 ---- riseStart --- riseEnd ---------------- setStart ---- setEnd ---- 00.00 

//date params ["_year", "_month", "_day", "_hours", "_minutes"];
private _date = date;

private _sun = missionNamespace getVariable ["AZ_DayPhase", []];
private _lastDate = missionNamespace getVariable ["AZ_DayPhaseTimeOut", [0, 0, 0]];
//_DayPhaseTimeOut params ["_year", "_month", "_day"];
if (((_lastDate#0) != (_date#0)) or {((_lastDate#1) != (_date#1)) or {((_lastDate#2) != (_date#2))}}) then
{
	// Return Value: Array of Number - [sunriseTime, sunsetTime]. 
	// Returns special values when the world position is behind the polar cicle: 
	//		[0,-1] - polar summer (i.e., no sunset),
	//		[-1,0] - polar winter (i.e., no sunrise).
	private _time = _date call BIS_fnc_sunriseSunsetTime;
	if (((_time#0) + (_time#1)) == -1) then 
	{
		_sun = _time;
	}
	else
	{
		_time params ["_riseTime", "_setTime"];
		_sun = [
			(_riseTime + (-25/60)), // rise Start
			(_setTime + (-10/60)), // set Start
			(_riseTime + (+10/60)), // rise End
			(_setTime + (+30/60))  // set End
		];
	};
	// missionNamespace setVariable ["AZ_DayPhaseTimeOut", time + 86400]; // 24h*60m*60s = 86400sec
	missionNamespace setVariable ["AZ_DayPhaseTimeOut", _date];
	missionNamespace setVariable ["AZ_DayPhase", _sun];
	// AZ_AI_SunriseStart = (_SunriseSunsetTime#0) + (-25/60); // min 
	// AZ_AI_SunriseEnd = (_SunriseSunsetTime#0) + (+10/60); // min
	// AZ_AI_SunsetStart = (_SunriseSunsetTime#1) + (-10/60); // min 
	// AZ_AI_SunsetEnd = (_SunriseSunsetTime#1) + (+30/60); // min
};

//if (count _sun == 0) exitWith {"ERROR"};
_sun params ["_riseStart", "_setStart", ["_riseEnd", 0], ["_setEnd", 0]];
if ((_riseStart == 0) and {_setStart == -1}) exitWith { "DAY" };
if ((_riseStart == -1) and {_setStart == 0}) exitWith { "NIGHT" };

// private _now = _hours + _minutes/60.0;
private _now = (_date#3) + ((_date#4)/60.0);

if (_now > _setEnd or {_now < _riseStart}) exitWith { "NIGHT" };
if (_now > _riseStart and {_now < _riseEnd}) exitWith { "SUNRISE" };
if (_now > _riseEnd and {_now < _setStart}) exitWith { "DAY" };				
if (_now > _setStart and {_now < _setEnd}) exitWith { "SUNSET" };
	
//player groupChat format ["sunrise[%1:%2]    %6[%3:%4]   sunMoon:%5", _h, _m, _hours, _minutes, _transitionState, _phase];


"ERROR"
