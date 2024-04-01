//az_fnc_AI_unitCanSpot = 
//{
	// params ["_unit"];
	//private _unit = _this;
	
	//if (alive _unit) exitWith {true};

az_fnc_AI_isNotCaptive = 
{
	private _cap = captiveNum _this;
	(_cap == AZ_AI_CaptiveNumber or _cap == 0)
};
	
// lifeState: "HEALTHY" "DEAD" "DEAD-RESPAWN" "DEAD-SWITCHING" "INCAPACITATED" "INJURED"
if (((lifeState _this) in ["HEALTHY", "INJURED"]) and (_this call az_fnc_AI_isNotCaptive)) exitWith {true};



false
//};

