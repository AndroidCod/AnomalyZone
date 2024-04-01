
class BlindDog_1 : Mutant
{
	armaType = "armst_blinddog";
	rangeToChangeTarget = 10; // если дистанция между текущей целью и новой целью больше данной то цель сменится на новую 
	targetForgetTimeout = 5; //
	timeToSafe = 30;
	enemyTypes[] = {};
	actionsSafe[] = {"Walk", 1, "Stop", 1, "Sleep", 0.2, "Eat", 0.3, "Howl", 0.1};
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
				"BlindDog_Idle_0",
				"BlindDog_Idle_1",
				"BlindDog_Idle_2",
				"BlindDog_Idle_3",
				"BlindDog_Idle_4"				
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
				"blinddog_StopV2",
				"blinddog_StopV3",
				"blinddog_StopV4"
			};
			animStartDelay = 0;
			animDelay[] = {10, 10}; // how offen anim changed (sec). if value bigger duration - anim not changed
		};
		class Eat : Safe
		{
			simulation = "stop";
			duration[] = {10, 10}; // (durationMin + random duration)
			animations[] = { "blinddog_StopV6" };
			animStartDelay = 0;
			animDelay[] = {30, 30}; // how offen anim changed (sec). if value bigger duration - anim not changed
			sounds[] = {};
		};
		class Sleep : Safe
		{
			simulation = "stop";
			duration[] = {5, 30}; // (durationMin + random duration)
			animations[] = { "blinddog_Sleep" };
			animStartDelay = 0;
			animDelay[] = {60, 0}; // how offen anim changed (sec). if value bigger duration - anim not changed
			sounds[] = {};
		};			
		class Howl : Safe
		{
			simulation = "stop";
			duration[] = {5, 0};
			animations[] = { "blinddog_StopV1" };
			animStartDelay = 0;
			animDelay[] = {30, 0}; // how offen anim changed (sec). if value bigger duration - anim not changed
			sounds[] = 
			{
				"BlindDog_Howl_0",
				"BlindDog_Howl_1",
				"BlindDog_Howl_2"
			};
			soundStartDelay = 0;
			soundDelay[] = {30, 0}; // sec  timeout = time + soundDurationMin + random soundDelay;
		};
		class Attack : Combat
		{
			animSpeedCoef = 1.1;				
			sounds[] = 
			{
				"BlindDog_Attack_0",
				"BlindDog_Attack_1",
				"BlindDog_Attack_2",
				"BlindDog_Attack_3",
				"BlindDog_Attack_4",
				"BlindDog_Attack_5",
				"BlindDog_Attack_6",
				"BlindDog_Attack_7"
			};
			soundStartDelay = 0;
			soundDelay[] = {5, 5}; // sec  timeout = time + soundDelay.0 + random soundDelay.1;
			animations[] = {};
		};
		class Inspect : Attack
		{
			simulation = "inspect";
			attackList[] = {"Melee"};
			actionsNoTarget[] = {"Patrol", 1};
			actionsPanic[] = {"Panic", 1}; // [Optional]. do panic if alive units in group <= 1 
			panicChance = 0.5;
			panicCheckDelay = 5;
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
				"blinddog_attack1",
				"blinddog_attack2",
				"blinddog_attack3",
				"blinddog_attack4"
			};
			animStartDelay = 0;
			animDelay[] = {30, 0};
			hit = "_this call az_fnc_Mutant_BlindDog_MeleeHit;"; // call compiles String expression into Code.
		};			
		class Patrol : Attack
		{
			simulation = "move";
			loop = 1;
			animations[] = {};
			soundStartDelay = 0;
			soundDelay[] = {5, 5}; // sec  timeout = time + soundDurationMin + random soundDelay;
		};			
		class Panic : Patrol
		{
			delay = 2;
			spotDelay = 30; // how offen unit spot target
			duration[] = {30, 20};// after it if no target go to safe
			sounds[] = 			
			{
				"BlindDog_Panic_0",
				"BlindDog_Panic_1",
				"BlindDog_Panic_2",
				"BlindDog_Panic_3",
				"BlindDog_Panic_4"
			};
			soundStartDelay = 2;
			soundDelay[] = {5, 5}; // sec  timeout = time + soundDurationMin + random soundDelay;
		};
	};
	

};
class BlindDog_2 : BlindDog_1
{
	armaType = "armst_blinddog2";
};
class BlindDog_3 : BlindDog_1
{
	armaType = "armst_blinddog3";
};
class BlindDog_4 : BlindDog_1
{
	armaType = "armst_blinddog4";
};