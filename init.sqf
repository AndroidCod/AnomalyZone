/*/if (isNil "AZ_ARCADEMODE_INITIALISED") then
{
	[] call compile preprocessfilelinenumbers "scripts\init.sqf";
	[] call compile preprocessfilelinenumbers "hud\init.sqf";
};
*/
AZ_PlayerPerceptionDistance = 250;
AZ_UnitAtCursor = objNull;
AZ_UnitAtCursorTimeOut = 0;
//Desired: 4 IRL Hours for Full In-Game Day
//setTimeMultiplier 120;
//timeMultiplier = 60
[] spawn {	

 	onEachFrame 
	{
		[] call az_fnc_HUD_playerStatusUpdate;
		call {
			private _object = CursorObject;
			//player groupChat format ["%1", getModelInfo _object, typeOf _object];//getModelInfo cursorObject, typeOf cursorObject
			if (((_object) isKindOf "CAManBase") and {(alive _object) and {(_object distance player <= AZ_PlayerPerceptionDistance)}}) then
			{
				AZ_UnitAtCursor = _object;
				AZ_UnitAtCursorTimeOut = time + 1.5;
			};
			if (not isNull AZ_UnitAtCursor) then  
			{
				if (time > AZ_UnitAtCursorTimeOut) then 
				{
					AZ_UnitAtCursor = objNull;
				};					
				AZ_UnitAtCursor call az_fnc_HUD_enemyStatusUpdate;
			};
		};
		
/* 		private _unit = player;
		_beg = ASLToAGL eyePos _unit;
		//_endE = _beg vectorAdd (eyeDirection _unit vectorMultiply 100);
		//drawLine3D [_beg, _endE, [0,1,0,1]];
		_endW = _beg vectorAdd (_unit weaponDirection currentWeapon _unit vectorMultiply 1000);
		drawLine3D [_beg, _endW, [1,0.5,0,1]]; */
	};
};

player setUnitRecoilCoefficient 0;

[player, "Player"] call AZ_Unit_fnc_init;
//["AZ_HUD_PLAYERSTATUS", "onEachFrame", az_fnc_HUD_PlayerStatusUpdate] call BIS_fnc_addStackedEventHandler;

[] spawn az_fnc_HUD_playerStatusUpdate;

/*********** AI ********************/
call compileScript["functions\AI\init.sqf"];

/*********** Mutants ********************/
call compileScript["functions\Mutant\init.sqf"];

//player sidechat format ["%1", player];
//systemChat str ['Init done', 0]; 
/*
ГРЕЙДЫ ОРУЖИЯ:
	- Изношенный -Серый- (заниженные хар-ки)
	- Обычный	-Белый-	(стандарт)
	- Качественный -Зеленый- (Улучшеные хар-ки и 0-1 яч. для осколков артефактов)
	- Модернизированный -Синий- (Улучшеные хар-ки и 1-2 яч. для осколков артефактов)
	- Аномальный -Фиолетовый-(Улучшеные хар-ки и Аномальные хар-ки и 2-3 яч. для осколков артефактов)
	- Легендарный -Золото-(Уникальные хар-ки и 3 яч. для осколков артефактов)

БРОНЯ:
	класс защиты (1, 2...) 
	защита(%) - насколько уменьшается урон
	покрытие(%): - по сути вероятность того что броня сработает для каждой части тела
		- голова 
		- тело
		- руки
		- ноги
	
	  К примеру шлем имеет покрытие только для головы равное 60% то защита сработает в 60% случаев попадания в голову.
	Пули бронебойные имеют свойство класс пробития. И если он выше или равен классу защиты брони то урон == уронПули.
	Если класс пробития пули меньше класса защиты брони то пуля наносит урон = (уронПули * защита) max (5-10% своего урона(заброневое воздействие)).

RADIATION:
	Еденицы радиации это урон в минуту
	Излучение делится на классы по 100ед.:
		- Альфа-частицы(0-100 ед./мин.),
		- Бетта-частицы(100-200 ед./мин.)
		- Гамма-излучение(200-300 ед./мин.)
		- Нейтронное-излучение(300 и более ед/мин) 
	К примеру излучение 165ед. это 100ед. альфа и 65ед. бетта
	
	Защита от радиации: 
		Три класса защиты: 
			- 0 - нет защиты
			- 100 - это 100% защита от Альфа-частицы.
			- 200 - это 100% защита от Бетта-частицы.
			- 300 - это 100% защита от Гамма-излучение.
		Защита должна быть меньше 400ед. т.е. 100% защиты от Нейтронного излучения нет!
		К примеру 165 ед. защиты эквивалентно - 1 классу защиты(т.е. 100% от Альфа излучения) и 65% от Бетта излучения
	
	Радиация накапливается и наносит урон здоровью равный накопленным ед./мин.
	К примеру накопленное излучение в 300 ед. если у вас здоровье 100ХП - убьет вас за 20 сек. 100ХП/(300ед/60сек) = 20 сек.
	В итоге расчет облучения имеет такой вид:
		
		private _fnc_calcRadiationHit =
		{	
			params ["_rad", "_protection"];
			//_rad - input radiation		
			//_protection - unit rad protection
			
			private _protFrac = _protection mod 100; 
			_rad = (0 max (_rad - _protection + _protFrac));
			if (_rad > 0) then
			{
				private _frac = (0 max (_rad - 100)); 
				_rad = ((100 - _protFrac)/100) * (_rad - _frac) + _frac;
			};
		
			_rad
		};
EFFECTS
	Баффы: Одинаковые эффекты не стакаются. 
		Дейстует эффект с самым большим показателем, а остальные висят в очереди но таймер у всех срабатывает.
		Если таймер истек то еффект заканчивается не зависимо от того действовал он или нет.
	Дебаффы: стакаются
*/

/*
[] spawn
{
	waitUntil { not isNull findDisplay 46 };
	hint "Mission Display is now available!";
	//private _display = (findDisplay 46);
	_moduleName_keyDownEHId = findDisplay 46 displayAddEventHandler ["KeyDown", "systemChat format['%1', _this]; systemChat format ['action reload: %1', inputAction 'reloadMagazine'];"];
	
};
player addaction ["<t size='1.2'>Reloding</t>", {
		
		private _unit = player;
		private _w = currentWeapon _unit;
		private _action = (configFile >> "CfgWeapons" >> _w >> "reloadAction") call BIS_fnc_getCfgData;
		
		// reloadMagazineSound[] = {"A3\Sounds_F_Enoch\Assets\Arsenal\Msbs65_01\Msbs65_01_Reload_01",1.77828,1,10};
		private _sound = (configFile >> "CfgWeapons" >> _w >> "reloadMagazineSound") call BIS_fnc_getCfgData;
		
		systemChat format ["%1", _action];
		// _unit setAnimSpeedCoef 2; // has no effect :(
		_unit playAction _action;
		// _soundSource = _unit say3D _sound; // volume * distance
		//playSound3D [filename, soundSource, isInside, soundPosition, volume, soundPitch, distance, offset, local]
		playSound3D [(_sound#0)+".wss", _unit]; // volume * distance
		
		//sleep 3;
		//_unit setAnimSpeedCoef 1.0;
	},
[],10];
*/

// TESTS
player addaction ["<t size='1.5'>GearDialog</t>",{createdialog "azGearDialog";},[],10];
player addaction ["<t size='1.5'>MyDrink</t>",{createdialog "MyDrink";},[],10];
player addaction ["<t size='1.5'>Calibrovka</t>",{createdialog "WeaponUICalibrationDialog";},[],10];

player addaction ["<t size='1.5'>Camera</t>",	{
		[] spawn {
		//params ["_timer", "_dead", "_unit", "_orgV"];
		private _timer = 10;
		private _dead = player;
		private _unit = u1;
		
		// internal cam movement function.
		private _camMove = 
		{
			params ["_cam", "_target", "_RelPos", "_FOV", "_commit"];
			//_cam = _this select 0;
			_cam camSetTarget (_target);
			_cam camSetRelPos (_RelPos);
			_cam camSetFOV (_FOV);
			_cam camCommit (_commit);
			waituntil {(camCommitted _cam)};
		};
		
		private _camTime = _timer/2;
		//private _time = CBA_MissionTime;
		
		// camera initialisation
		private _camera = "camera" camCreate position _dead;
		_camera cameraEffect ["internal", "BACK"];

		// camera look at player
		private _cam = [_camera, _dead, [0.2, 0.4, 2], 0.143, 0] call _camMove;

		// camera zooms out over 5 seconds
		_cam = [_camera, _dead, [0, 8, 3.5], 0.7, _camTime] call _camMove;

		// quick fade-in on internal point of view of the next unit
		_camera camSetTarget _unit;

		// set camera above new unit.
		_cam = [_camera, _unit, [0,8,3.5], 0.7, 0] call _camMove;

		// camera zooms in over 5 seconds
		_cam = [_camera, _unit, [0.2,0.4,2], 0.7, _camTime] call _camMove;

		// end camera part.
		_unit cameraEffect ["terminate", "back"];

		// destroy camera.
		camDestroy _camera;
	};		
	
},[],10];

player addAction ["Radiation", {

	
	
	[] spawn {

		private _fnc_calcRadiationHit =
		{	
			params ["_rad", "_protection"];
			//_rad - input radiation		
			//_protection - unit rad protection
			
			private _protFrac = _protection mod 100; 
			_rad = (0 max (_rad - _protection + _protFrac));
			if (_rad > 0) then
			{
				private _frac = (0 max (_rad - 100)); 
				_rad = ((100 - _protFrac)/100) * (_rad - _frac) + _frac;
			};
		
			_rad
		};

		private _center = player getPos [16, getDir player];
		//private _center = position player ;
		private _radius = 15;
		
		private _unitHP = 100;
		private _unitRad = 300;
		private _unitRadProtect = 0;
		
		private _lastTime = CBA_missionTime;
		while {_unitHP > 0} do
		{
			private _dist = player distance _center;
			private _delay = (CBA_missionTime - _lastTime)/(60.0); //every 1 minutes
			if (_dist <= _radius) then
			{
				private _rad = 120 * (1 - (_dist/_radius));
				_rad = [_rad, _unitRadProtect] call _fnc_calcRadiationHit;
				player sidechat format ["hit = %1", _rad];
				_unitRad = _unitRad + _rad * _delay;				
			};
			if (_unitRad > 0) then
			{
				_unitHP = 0 max (_unitHP - (_unitRad * _delay));
			};
			
			player sidechat format ["hp[%1] rad[%2] distance=%3", _unitHP, _unitRad, _dist]; 	
			
			_lastTime = CBA_missionTime;
			sleep 0.5;
		};
		
		player sidechat format ["Game over"]; 
	};

}];

player addAction ["CAPTIVE", {player setCaptive 1}];
player addAction ["NO CAPTIVE", {player setCaptive 0}];

player addAction ["SOBAKA", { [["BlindDog_1", 1, "BlindDog_2", 1, "BlindDog_3", 1, "BlindDog_4", 1], 2, position player, 20] call az_fnc_Mutant_spawnGroup; }];
player addAction ["SNORK", { [["Snork", 1], 1, position player, 30] call az_fnc_Mutant_spawnGroup; }];

