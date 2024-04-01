// _item = [_weapon, _itemType] call AZ_Item_fnc_Weapon_takeItem

// #define TRACE_MODE
#include "..\macros.hpp"

params ["_weapon", "_itemType"];

private _item = _this call AZ_Item_fnc_Weapon_getItem;

switch (_itemType) do 
{
	case ITEM_TYPE_WEAPON_MUZZLE;
	case ITEM_TYPE_WEAPON_POINTER;
	case ITEM_TYPE_WEAPON_OPTIC;
	case ITEM_TYPE_WEAPON_BIPOD: { _weapon set [_itemType, nil]; };
	default { ERROR("Not supported item type");};
};

_item