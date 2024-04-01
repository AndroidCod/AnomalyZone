// AZ_Item_fnc_isEquals = 
#include "..\macros.hpp"

params ["_itemA", "_itemB"];
	
if ((_itemA get "config") isNotEqualRef (_itemB get "config")) exitWith {false};

private _config = _itemA get "config";
switch (_config get "type") do
{
	case ITEM_TYPE_MAGAZINE: 
	{
		((_itemA get "ammoCount") == (_itemB get "ammoCount")) and {(_itemA get "ammo") == (_itemB get "ammo")}
	};
	case ITEM_TYPE_AMMO;
	default
	{
	};
};
