

class cfgMutants
{
	class Mutant
	{
		armaType = "";
		escapeRange = 150;
		enemyTypes[] = {};
		//spotRange = 100;		
		smellSpotRange = 25; // расстояние на котором мутант унюхает цель
		audibleSpotRangeFactor = 3; // х3 - Во сколько раз мутант слышит лучше человека
		volumDistance = 700;
		class Actions
		{
			class Base
			{
				isCombat = 0;
				spotDelay = 1; // how offen unit spot target
				walk = 1;
				simulation = "";
				duration[] = {0, 0}; // {a, r} - (a + random r)
				delay = 2;
				animations[] = {};
				animSpeedCoef = 1;				
				animStartDelay = 0; // start offset anim (sec). if value bigger duration - anim not changed
				animDelay[] = {0, 0}; // how offen anim changed (sec). if value bigger duration - anim not changed
				sounds[] = {};
				soundStartDelay = 0;
				soundDelay[] = {30, 30}; // sec
				loop = 0;
			};
			class Safe : Base
			{
				isCombat = 0;
				walk = 1;
				delay = 2;
				spotDelay = 4; // how offen unit spot target
			};
			class Combat : Base
			{
				isCombat = 1;
				walk = 0;
				delay = 0.5;
				spotDelay = 0.5; // how offen unit spot target
			};
		};
	};

	#include "mutants\BlindDog.hpp"
	
	#include "mutants\Snork.hpp"
	

};