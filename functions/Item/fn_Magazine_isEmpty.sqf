// AZ_Item_fnc_Magazine_isEmpty

#include "..\macros.hpp"

params ["_mag"];

#ifdef DEBUG_MODE
if (isNil "_mag") exitWith {ERROR("Invalid params data"); true};
private _config = (_mag get "config");
if ((_config get "type") != ITEM_TYPE_MAGAZINE) exitWith { ERROR("Invalid params data"); true};
#endif

if ((_mag get "ammoCount") == 0) exitWith
{
	//if ((_mag get "ammo") isNotEqualTo "") exitWith { ERROR("Invalid magazine data"); false};
	assert ((_mag get "ammo") isEqualTo "");
	true
};

false
