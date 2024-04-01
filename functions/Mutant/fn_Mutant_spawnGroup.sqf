// 

params ["_profile", "_size", "_center", ["_radius", 50]];

// profile format same as 'selectRandomWeighted' command argument - array in format [value1, weight1, value2, weight2, ...],
// ["BlindDog", 0.8, "Snork", 0.05]



// Make random group
private _mutList = [];
private _i = 0;
while {_i < _size} do
{
	private _type = (selectRandomWeighted _profile);
	_mutList pushBack _type;
	_i = _i + 1;
};
if (count _mutList <= 0) exitWith { ["[ERROR] az_fnc_Mutant_spawnGroup - Can`t create group %1", _profile] call BIS_fnc_error; };

// Spawn
private _grp = [];
{
	private _type = _x;
	private _armaType = (missionConfigFile >> "cfgMutants" >> _type >> "armaType") call BIS_fnc_getCfgData;
	
	private _unit = createAgent [_armaType, _center, [], _radius, "NONE"];
	_unit setVariable ["BIS_fnc_animalBehaviour_disable", true];
	_unit setVariable ["AZ_Type", _type];
	
	_unit enableSimulation false;
	_unit setDir random 360;
	_unit addRating -10000;
	_unit disableAI "AIMINGERROR";
	_unit disableAI "AUTOCOMBAT";
	_unit disableAI "AUTOTARGET";
	_unit disableAI "CHECKVISIBLE";
	_unit disableAI "COVER";
	_unit disableAI "FSM";
	_unit disableAI "LIGHTS";
	_unit disableAI "MINEDETECTION";
	_unit disableAI "NVG";
	_unit disableAI "RADIOPROTOCOL";
	_unit disableAI "SUPPRESSION";
	_unit disableAI "TARGET";
	//_unit disableAI "TEAMSWITCH";
	_unit disableAI "WEAPONAIM";
	
	 player sideChat format ["%1", side _unit];
	if (captiveNum _unit == 0) then { _unit setCaptive AZ_AI_CaptiveNumber; };
	
	_unit setBehaviour "CARELESS";
	_unit setUnitPosWeak "UP";
	_unit setVariable ["BIS_noCoreConversations", true, true];
	_unit disableConversation true;
	_unit setSpeaker "NoVoice";
	_unit allowSprint true;	
	// [_unit, 0] call BIS_fnc_holdActionRemove; // remove stupid action from init config
	_unit enableStamina false;
	_unit setName format ["%1 %2", ((configFile >> "cfgVehicles" >> _armaType >> "displayName") call BIS_fnc_getCfgData), _forEachIndex];
	
	_unit setVariable ["AZ_IsMutant", true, true];
	_unit setVariable ["AZ_IsCombat", false];
	
	_unit enableSimulation true;
	
	//u1 = _unit;
	
	_grp pushBack _unit;
	
} forEach _mutList;

// Run AI Behavior
{
	[_x, _grp, _center, _radius] spawn az_fnc_Mutant_runBehavior;
	
} forEach _grp;

_grp
