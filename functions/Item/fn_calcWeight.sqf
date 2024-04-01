// _weight =  _item call AZ_Item_fnc_calcWeight

#define TRACE_MODE
#include "..\macros.hpp"

params ["_item"];

private _config = _item get "config";
private _w = _config get "weight";

switch (_config get "type") do
{
	case ITEM_TYPE_AMMO:
	{	ERROR_NO_IMPLEMENTATION;	
	};
	case ITEM_TYPE_MAGAZINE: 
	{ERROR_NO_IMPLEMENTATION;
	};
	case ITEM_TYPE_WEAPON_PRIMARY:
	{	ERROR_NO_IMPLEMENTATION;	
	};
	default {ERROR_NO_IMPLEMENTATION;};
};


(_w * (_item get "amount"))