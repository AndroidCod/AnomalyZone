//az_fnc_AI_calcVision =

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
// params ["_unit"]; //, "_target"];
private _unit = _this;
private _fov = 1;
private _range = 1;

// Fog power
private _f = ((AGLToASL (position _unit))#2) call az_fnc_getFogPowerASL;
_f = (_f min 1) max 0;
//_spotDistance = _spotDistance min (20 + (1 - _fogPower)*AZ_AI_MaxSpotRange); // spot distance by fog
_range = _range + (-_f);

//
_f = (AZ_AI_OvercastFactor * Overcast);
_range = _range + _f;
_fov = _fov + _f;

//
_f = (AZ_AI_RainFactor * Rain);
_range = _range + _f;
_fov = _fov + _f;

//
if (vectorMagnitude(velocity _unit) > 0.01) then { _range = _range - AZ_AI_MoveFactor; };
//if (vectorMagnitude(velocity _target) > 0.01) then { _range = _range + AZ_AI_MoveFactor; };
/*switch (stance _target) do
{
	case "STAND":{ _range = _range + AZ_AI_StanceFactorSTAND; };
	case "CROUCH": { _range = _range + AZ_AI_StanceFactorCROUCH; };
	case "PRONE": { _range = _range + AZ_AI_StanceFactorPRONE; };
	//case "UNDEFINED": {}
	default {};
};
*/
//private _targetStealth = _target getVariable ["AZ_Stealth", 1];

// Day phase
_f = call az_fnc_getDayPhase;
//player commandChat _f;
switch (_f) do
{
	case ("DAY"):
	{
		if ((combatBehaviour _unit == "COMBAT") or (unitCombatMode _unit == "RED")) then { _range = _range + AZ_AI_CombatFactorDay;	};
		
		_range = _range + AZ_AI_FactorDay;
		_fov = _fov + AZ_AI_FOVFactorDay;
	};
	case ("NIGHT"):
	{	
		_range = _range + AZ_AI_FactorNight;
		_range = _range + (AZ_AI_MoonFactor*(moonPhase date)*moonIntensity);	
		if (currentVisionMode _unit != 0) then { _range = _range + AZ_AI_NightVisionModeFactor; };
		//if (_target isFlashlightOn (currentWeapon _target)) then { _range = _range + AZ_AI_FlashlightFactorNight; };
		if ((combatBehaviour _unit == "COMBAT") or (unitCombatMode _unit == "RED")) then { _range = _range + AZ_AI_CombatFactorNight;	};
		
		_fov = _fov + AZ_AI_FOVFactorNight;
	};
	case ("SUNRISE");
	case ("SUNSET"):
	{
		_range = _range + AZ_AI_FactorMid;
		if (currentVisionMode _unit != 0) then { _range = _range + AZ_AI_NightVisionModeFactor; };
		//if (_target isFlashlightOn (currentWeapon _target)) then { _range = _range + AZ_AI_FlashlightFactorMid; };
		if ((combatBehaviour _unit == "COMBAT") or (unitCombatMode _unit == "RED")) then { _range = _range + AZ_AI_CombatFactorMid;	};
		
		_fov = _fov + AZ_AI_FOVFactorMid;
	};
	default 
	{
		["[ERROR] invalid day phase"] call BIS_fnc_error;
	};
};

[_fov, _range]
	