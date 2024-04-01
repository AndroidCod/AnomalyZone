/*
	unit: Object - object the event handler is assigned to
	weapon: String - fired weapon
	muzzle: String - muzzle that was used
	mode: String - current mode of the fired weapon
	ammo: String - ammo used
	magazine: String - magazine name which was used
	projectile: Object - object of the projectile that was shot out
	gunner: Object - gunner whose weapons are firing.
*/


params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

//player sideChat format ["Fired: %1 : %2", _unit, _this];
private _cap = captiveNum _unit;
if (_cap == AZ_AI_CaptiveNumber) then
{
	// !!! для определения глушителя нужно реализовать инвентарь и там брать характеристики оружия
	private _range = AZ_AI_FireshotSpotRange;
	//private _hasSilencer = ((_unit weaponAccessories _muzzle) param [0, ""]) != "";
	//if (_hasSilencer) then {_range = AZ_AI_FireshotSpotRangeSilencer;};
	//player sideChat format ["Fired: %1 : %2", _unit, ((_unit weaponAccessories _muzzle) param [0, ""])];
	private _targets = _unit nearEntities ["CAManBase", _range];
	{
		private _target = _x;
		if (_unit != _target) then
		{
			if (_target call az_fnc_AI_unitCanSpot) then 
			{
				if ([_unit, _target] call AZ_fnc_Mutant_isEnemy) then 
				{
					_unit setCaptive 0;
					_unit setVariable ["AZ_AI_SpotedTime", time];
					break;
				};
			};
		};

	} forEach _targets;

};

/*
_projectile addEventHandler ["HitPart", {
	params ["_projectile", "_hitEntity", "_projectileOwner", "_pos", "_velocity", "_normal", "_components", "_radius" ,"_surfaceType"];
	
	if (_hitEntity != objNull) then 
	{
		player sideChat format ["%1 : %2 %3", _hitEntity, _components, vectorMagnitude _velocity];
	};
}];
/*
projectile: Object
hitEntity: Object
projectileOwner: Object
pos: Array format PositionASL
velocity: Array format Vector3D
normal: Array format Vector3D
components: Array of Strings - The selections that were hit, in the FireGeometry LOD.
radius: Number - radius (size) of the hitPoint
surfaceType: String
*/

