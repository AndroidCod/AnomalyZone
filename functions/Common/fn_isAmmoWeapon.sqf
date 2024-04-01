/*
 * Author: Glowbal
 * Updates the vitals. Is expected to be called every second.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob] call ACE_medical_fnc_handleUnitVitals
 *
 * Public: No
 */


params ["_weapon", "_projectile"];

if (_weapon == "" || _projectile == "") exitWith {false};
private _ret = false;
private _mags = (configFile >> "CfgWeapons" >> _weapon >> "magazines") call BIS_fnc_getCfgData;
if (not isNil("_mags")) then
{
	{
		private _proj = (configFile >> "CfgMagazines" >> _x >> "ammo") call BIS_fnc_getCfgData;
		if (not isNil("_proj")) then
		{
			if (_proj isEqualTo _projectile) exitWith { _ret = true; };			
		};
	} foreach _mags;
	
};
//private _mags = compatibleMagazines [_weapon, "this"];

//player globalChat format ["%1 - %2 - %3", _weapon, _projectile, _ret];


_ret
