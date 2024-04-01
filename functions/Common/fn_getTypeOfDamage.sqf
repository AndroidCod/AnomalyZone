/*
 * Author: Glowbal
 * Get the type of damage based upon the projectile.
 *
 * Arguments:
 * 0: The projectile classname or object <STRING>
 *
 * ReturnValue:
 * Type of damage <NUMBER>
 *
 * Public: No
 */
 
#include "..\macros.hpp"

params ["_typeOfProjectile"];

if (_typeOfProjectile == "")					exitWith { __AZ_DAMAGE_TYPE_NONE };
if (_typeOfProjectile isKindOf "BulletBase") 	exitWith { __AZ_DAMAGE_TYPE_BULLET };
if (_typeOfProjectile isKindOf "ShotgunBase") 	exitWith { __AZ_DAMAGE_TYPE_BULLET };
if (_typeOfProjectile isKindOf "GrenadeCore") 	exitWith { __AZ_DAMAGE_TYPE_GRENADE };
if (_typeOfProjectile isKindOf "TimeBombCore") 	exitWith { __AZ_DAMAGE_TYPE_EXPLOSIVE };
if (_typeOfProjectile isKindOf "MineCore") 		exitWith { __AZ_DAMAGE_TYPE_EXPLOSIVE };
if (_typeOfProjectile isKindOf "FuelExplosion") exitWith { __AZ_DAMAGE_TYPE_EXPLOSIVE };
if (_typeOfProjectile isKindOf "ShellBase") 	exitWith { __AZ_DAMAGE_TYPE_SHELL };
if (_typeOfProjectile isKindOf "RocketBase") 	exitWith { __AZ_DAMAGE_TYPE_EXPLOSIVE };
if (_typeOfProjectile isKindOf "MissileBase") 	exitWith { __AZ_DAMAGE_TYPE_EXPLOSIVE };
if (_typeOfProjectile isKindOf "LaserBombCore") exitWith { __AZ_DAMAGE_TYPE_EXPLOSIVE };
if (_typeOfProjectile isKindOf "BombCore") 		exitWith { __AZ_DAMAGE_TYPE_EXPLOSIVE };
if (_typeOfProjectile isKindOf "Grenade") 		exitWith { __AZ_DAMAGE_TYPE_GRENADE };



//toLower _typeOfProjectile
__AZ_DAMAGETYPE_NONE
