/*
RANKS
	novice - начинающий
	trainee - новичек
	experienced - опытный
	professional - профессионал
	veteran - ветеран
	expert - эксперт
	master - мастер
	legend - легенда
	
FACTION
	SIDE WEST
		- NATO
		- Mercs
		- Monolit
	SIDE EAST
		- ArmyRF
		- Bandits
	SIDE RESISTANCE
		- Stalkers 
		- Dolg
		- Freedom
		- ClearSky
		- Hunters
	SIDE CIV
		- Scientists(ученые)
*/


class cfgUnits
{
	class Player // only init data
	{
		hp[] = {100, 1000};
		faction = "Stalkers";
		level = 1;
		rank = 0;
		invCapacity = 25000;
	};	
	
	class Stalker // only init data
	{
		hp[] = {100, 100};
		faction = "Stalkers";
		level = 1;
		rank = 0;
		invCapacity = 25000;
	};
};