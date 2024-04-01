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

//#define TRACE_MODE
#include "..\macros.hpp"

params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

_this call az_fnc_AI_onFired;

// 
private _wpnSlotID = 0;
switch true do 
{
	case (primaryWeapon _unit isEqualTo _weapon):
	{
		_wpnSlotID = GEAR_SLOT_ID_WEAPON_PRIMARY;
	};
	case (secondaryWeapon _unit isEqualTo _weapon):
	{
		_wpnSlotID = GEAR_SLOT_ID_WEAPON_SECONDARY;
	};
	case (handgunWeapon _unit isEqualTo _weapon):
	{
		_wpnSlotID = GEAR_SLOT_ID_WEAPON_HANDGUN;
	};
};
if (_wpnSlotID != 0) then
{
	private _weapon = [_unit, _wpnSlotID] call AZ_Unit_fnc_getGear;
	if (isNil "_weapon") exitWith { ERROR("weapon do not be empty"); };
	
	private _muzzleName = if (_weapon isEqualTo _muzzle) then { 0 } else { _muzzle };
	private _currentMag = [_weapon, _muzzleName] call AZ_Item_fnc_Weapon_getMagazine;
	if (isNil "_currentMag") exitWith{ ERROR("weapon not have magazine"); };
	
	private _ammo = [_currentMag, 1] call AZ_Item_fnc_Magazine_takeAmmo;
};


/*
Точность можно только ухудшить функция [common\fnc_changeProjectileDirection.sqf].
так-как нет возможности узнать направление в котором оружие стреляет
weaponDirection - дает только направления оружия без учета выставленной дальности стрельбы
*/
private _fnc_getPseudoRandomList =
{
	private _var = missionNamespace getVariable ["AZ_PseudoRandomList", nil];
	if (isNil "_var") then
	{
		AZ_PseudoRandomList = [];
		// Construct a list of pseudo random 2D vectors
		for "_i" from 0 to 30 do 
		{
			AZ_PseudoRandomList pushBack [-1 + random 2, -1 + random 2];
		};
		_var = AZ_PseudoRandomList;
	};
	
	_var
};

// Коэффициент ухудшения точности. 
// Берем из текущегго оружия. 
// Процент от дисперсии оружия который будет добавлен к основной дисперсии 
private _weaponDispertionCoef = 0; 
if (_weaponDispertionCoef > 0) then
{	
	if ((_muzzle == (primaryWeapon _unit)) or {_muzzle == (handgunWeapon _unit)}) then // Only rifle or pistol muzzles (ignore grenades / GLs)
	//private _damType = _ammo call az_fnc_getTypeOfDamage;
	//if (_damType == __AZ_DAMAGE_TYPE_BULLET) then
	{
		// dispersion = 0.0003; - In-game weapon dispersion in radians. Bigger value = more dispersion.
		private _disp = (configFile >> "CfgWeapons" >> _weapon >> _mode >> "dispersion") call BIS_fnc_getCfgData; //!!!нужно проверить пути
		if (not isNil "_disp") then 
		{
			_disp = _disp * _weaponDispertionCoef;
			
			// Get the pseudo random values for dispersion from the remaining ammo count
			private _prndList = call _fnc_getPseudoRandomList;
			(_prndList) select ((_unit ammo _weapon) mod (count _prndList)) params ["_dispersionX", "_dispersionY"];
			//player sideChat format ["%1", _disp];
			[_projectile, deg(_disp * _dispersionX), deg(_disp * _dispersionY), 0] call az_fnc_changeProjectileDirection;
		};
	};
};


// Скорострельность можно только увеличить. больше еденицы нет эффекта
//_unit setWeaponReloadingTime [_unit, _muzzle, 2.5];
/*
_projectile setVariable ["AZ_PPPP", 999];
_projectile addEventHandler ["HitPart", {
	params ["_projectile", "_hitEntity", "_projectileOwner", "_pos", "_velocity", "_normal", "_components", "_radius" ,"_surfaceType"];
	
	if (_hitEntity != objNull) then 
	{
		player sideChat format ["hitPart: %1 : %2 %3", _hitEntity, _components, _surfaceType];
		player sideChat format ["variable: %1 : %2", "AZ_PPPP", _projectile getVariable "AZ_PPPP"];
	};
}];*/
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

