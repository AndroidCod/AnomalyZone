// _offsetPoint = [_weapon, _itemType] call AZ_Item_fnc_Weapon_getOffsetPoint

#define TRACE_MODE
#include "..\macros.hpp"

params ["_weapon", "_itemType"];

private _key = switch (_itemType) do 
{
	case ITEM_TYPE_WEAPON_MUZZLE: 	{ "muzzlePoint"	};
	case ITEM_TYPE_WEAPON_OPTIC: 	{ "opticPoint" 	};
	case ITEM_TYPE_WEAPON_POINTER: 	{ "pointerPoint"};
	case ITEM_TYPE_WEAPON_BIPOD: 	{ "bipodPoint" 	};
	default { ERROR("Unsupported item type"); };
};

(_weapon get "config" get _key)