// az_fnc_AI_calcVisionTarget =

/* 
Влияет на distance и FOV:
  -Weather
	- DayLight
		- sunOrMoon [0..1] день 1, луна 0, промежуточные значения - сумерки
		- moonIntensity [0..1] 
	- Overcast [0...1] Облачность
	- Rain [0..1] дождь
	- Fog [0..1] 
  
  -Unit
	- Combat Mode
	- Moving (В движении тяжелее заметить цель)
	
  -Target
	- Stance
	- Moving (Цель более заметна если движется)
	- Lights on (Фонарик включен)
	- Stealth points
*/
//params ["_target"];
private _target = _this;

private _fov = 0;
private _range = 0;

//
if (vectorMagnitude(velocity _target) > 0.01) then { _range = _range + AZ_AI_MoveFactor; };
switch (stance _target) do
{
	case "STAND":{ _range = _range + AZ_AI_StanceFactorSTAND; };
	case "CROUCH": { _range = _range + AZ_AI_StanceFactorCROUCH; };
	case "PRONE": { _range = _range + AZ_AI_StanceFactorPRONE; };
	//case "UNDEFINED": {}
	default {};
};
//private _targetStealth = _target getVariable ["AZ_Stealth", 1];

// Day phase
private _f = call az_fnc_getDayPhase;
switch (_f) do
{
	case ("DAY"):
	{
		if (_target isFlashlightOn (currentWeapon _target)) then { _range = _range + AZ_AI_FlashlightFactorDay; };
	};
	case ("NIGHT"):
	{	
		if (_target isFlashlightOn (currentWeapon _target)) then { _range = _range + AZ_AI_FlashlightFactorNight; };
	};
	case ("SUNRISE");
	case ("SUNSET"):
	{
		if (_target isFlashlightOn (currentWeapon _target)) then { _range = _range + AZ_AI_FlashlightFactorMid; };
	};
	default 
	{
		["[ERROR] invalid day phase"] call BIS_fnc_error;
	};
};

[_fov, _range]
	