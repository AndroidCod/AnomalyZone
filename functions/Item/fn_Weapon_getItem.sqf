// true = [_weapon, _itemType] call AZ_Item_fnc_Weapon_getItem

// #define TRACE_MODE
#include "..\macros.hpp"

params ["_weapon", "_itemType"];

(switch (_itemType) do 
{
	case ITEM_TYPE_WEAPON_MUZZLE;
	case ITEM_TYPE_WEAPON_POINTER;
	case ITEM_TYPE_WEAPON_OPTIC;
	case ITEM_TYPE_WEAPON_BIPOD: { _weapon get _itemType };
	default { ERROR("Not supported item type"); nil };
})
