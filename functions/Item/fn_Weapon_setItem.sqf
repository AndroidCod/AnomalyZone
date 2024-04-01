// true = [_weapon, _item] call AZ_Item_fnc_Weapon_setItem

#define TRACE_MODE
#include "..\macros.hpp"

params ["_weapon", "_item"];

if (_this call AZ_Item_fnc_Weapon_isCompatibleItem) exitWith 
{
	private _config = _item get "config";
	// TRACE_1("weapon set item: %1", _config get "configName");
	(switch (_config get "type") do 
	{
		case ITEM_TYPE_WEAPON_MUZZLE;
		case ITEM_TYPE_WEAPON_POINTER;
		case ITEM_TYPE_WEAPON_OPTIC;
		case ITEM_TYPE_WEAPON_BIPOD: { _weapon set [(_config get "type"), _item]; true };
		default { ERROR("Not supported item type"); false };
	})
};

false