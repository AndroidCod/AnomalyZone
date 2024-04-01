// AZ_Item_fnc_Magazine_isFull

#include "..\macros.hpp"

params ["_mag"];

#ifdef DEBUG_MODE
if (isNil "_mag") exitWith {ERROR("Invalid params data"); true};
if (((_mag get "config") get "type") != ITEM_TYPE_MAGAZINE) exitWith { ERROR("Invalid params data"); true};
#endif

// private _config = (_mag get "config");
if ((_mag get "ammoCount") == ((_mag get "config") get "capacity")) exitWith
{
	//if ((_mag get "ammo") isNotEqualTo "") exitWith { ERROR("Invalid magazine data"); false};
	assert ((_mag get "ammo") isNotEqualTo "");
	true
};

false