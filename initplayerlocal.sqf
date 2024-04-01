
//if (!hasInterface) exitWith {};

// Восприятие...
/*
AZ_PLAYER_PERCEPTION_DIST = 250.0;

["AZ_PLAYER_PERCEPTION", "onEachFrame", 
	{
		//private _unit = cursorTarget;
		private _unit = CursorObject;
		//hint str [getModelInfo cursorObject, typeOf cursorObject];
		if (((_unit) isKindOf "CAManBase") 
				&&	(alive (_unit)) 
				//&& (side _unit == east)
				&& (_unit distance player <= AZ_PLAYER_PERCEPTION_DIST) 
			) then
		{
			[_unit] spawn az_fnc_HUD_enemyStatusUpdate;
		};
		
	}
] call BIS_fnc_addStackedEventHandler;
*/
//systemChat str ['InitPlayerLocal',_this]; 
