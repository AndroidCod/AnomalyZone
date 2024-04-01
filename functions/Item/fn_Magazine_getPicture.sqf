// _picture = _mag call AZ_Item_fnc_Magazine_getPicture;

#define TRACE_MODE
#include "..\macros.hpp"

params ["_mag"];

private _picture = "";
if (_mag call AZ_Item_fnc_Magazine_isIntegral) then 
{
	private _ammo = (_mag get "ammo");
	private _ammoCount = (_mag get "ammoCount");
	if (_ammo isNotEqualTo "" and {_ammoCount > 0}) then 
	{
		private _ammoConfig = _ammo call AZ_Item_fnc_getConfig;
		if (isNil "_ammoConfig") exitWith { ERROR("Ammo Config exists"); };
		_picture =  _ammoConfig get "picture";
	};
}
else
{
	_picture = (_mag get "config" get "picture");
};

_picture