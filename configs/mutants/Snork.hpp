
class Snork : Mutant
{
	armaType = "armst_snork";
	rangeToChangeTarget = 10; // если дистанция между текущей целью и новой целью больше данной то цель сменится на новую 
	targetForgetTimeout = 5; //
	timeToSafe = 30;
	enemyTypes[] = { };
	actionsSafe[] = {"Walk", 1, "Stop", 1, "Eat", 0.3};
	actionsCombat[] = {"Inspect", 1};
	/* class aoe_attack // [Optional] урон по обасти постоянно пока юнит жив
	{
		combat = 1; // only combat mode
		range = 10; // attack action range 
		reload = 1; // timeout to next attack
		hit = "_this call az_fnc_Mutant_BlindDog_AoEHit;"; // call compiles String expression into Code.
	}; */
	class Actions : Actions 
	{
		/* 
			Suported simulation types: 
				- inspect 
				- move (move to random position around unit center)
				- stop 
		*/
		class Idle : Safe 
		{
			sounds[] = 
			{
				"snork_idle_0",
				"snork_idle_1",
				"snork_idle_2"
			};
			soundStartDelay = 1;
			soundDelay[] = {15, 30}; // sec
		};
		class Walk : Idle
		{
			walk = 1;				
			loop = 0;
			simulation = "move";
		};			
		class Stop : Idle
		{
			simulation = "stop";
			duration[] = {20, 60}; // (durationMin + random duration)
			animations[] = 
			{
				"snork_Stop",
				"snork_StopV1",
				"snork_StopV2"
			};
			animStartDelay = 0;
			animDelay[] = {10, 10}; // how offen anim changed (sec). if value bigger duration - anim not changed
		};
		class Eat : Safe
		{
			simulation = "stop";
			duration[] = {10, 10}; // (durationMin + random duration)
			animations[] = { "snork_angry" };
			animStartDelay = 0;
			animDelay[] = {30, 30}; // how offen anim changed (sec). if value bigger duration - anim not changed
			sounds[] = {};
		};
		class Attack : Combat
		{
			animSpeedCoef = 1.0;				
			sounds[] = 
			{
				"snork_attack_0",
				"snork_attack_1",
				"snork_attack_hit_0",
				"snork_attack_hit_1"
			};
			soundStartDelay = 0;
			soundDelay[] = {5, 5}; // sec  timeout = time + soundDelay.0 + random soundDelay.1;
			animations[] = {};
		};
		class Inspect : Attack
		{
			simulation = "inspect";
			attackList[] = {"Melee", "Jump"}; 
			actionsNoTarget[] = {"Patrol", 1};
			//actionsPanic[] = {}; // [Optional]. do panic if alive units in group <= 1 
			//panicChance = 0.5;
			//panicCheckDelay = 5;
		};
		class Melee : Attack
		{
			range[] = {0, 2}; // attack action range 
			chance = 1;
			delay = 1;
			spotDelay = 1.2; // how offen unit spot target
			duration[] = {1, 0};
			simulation = "stop";
			animations[] = 
			{
				"snork_attack1",
				"snork_attack2"
			};
			animStartDelay = 0;
			animDelay[] = {30, 0};
			hit = "_this call az_fnc_Mutant_BlindDog_MeleeHit;"; // call compiles String expression into Code.
		};	
		class Jump : Melee
		{
			jumpSpeed = 15;
			animSpeedCoef = 0.6;
			range[] = {5, 9}; // attack action range 
			chance = 0.5;
			delay = 1.2;
			spotDelay = 1.5; // how offen unit spot target
			duration[] = {1.2, 0};
			simulation = "stop";
			animations[] = 
			{
				"snork_attack3"
			};
			animStartDelay = 0;
			animDelay[] = {30, 0};
			hit = "_this spawn az_fnc_Mutant_Snork_JumpHit;"; // call compiles String expression into Code.
		};
		class Patrol : Attack
		{
			simulation = "move";
			loop = 1;
			animations[] = {};
			soundStartDelay = 0;
			soundDelay[] = {5, 5}; // sec  timeout = time + soundDurationMin + random soundDelay;
		};			

	};
	

};