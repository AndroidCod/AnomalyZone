// unit OnReloaded

#define TRACE_MODE
#include "..\macros.hpp"

params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];

TRACE_1("%1", _this);

// _newMagazine - Array of
// magazineClass: String - class name of the magazine
// ammoCount: Number - amount of ammo in magazine
// magazineID: Number - global magazine id
// magazineCreator: Number - owner of the magazine creator
if (vehicle _unit != _unit) exitWith {}; // "Unit is in a vehicle"
if (_weapon isEqualTo "Throw") exitWith {};


//private _isManual = _unit getVariable "AZ_ManualReload";
//TRACE_1("OnReloaded manual: %1", _isManual);
//if (not isNil "_isManual" and {_isManual}) exitWith { _unit setVariable ["AZ_ManualReload", false]; };


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
if (_wpnSlotID == 0) exitWith { ERROR("Not found weapon"); };
if (_weapon isEqualTo _muzzle) then { _muzzle = 0; };
[_unit, _wpnSlotID, _muzzle, _newMagazine] call AZ_Unit_fnc_weaponReloaded;

