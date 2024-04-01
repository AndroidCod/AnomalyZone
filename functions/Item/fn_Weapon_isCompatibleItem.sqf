// AZ_Item_fnc_Weapon_isCompatibleItem

// #define TRACE_MODE
#include "..\macros.hpp"

params ["_weapon", "_item"];

#ifdef DEBUG_MODE
if (isNil "_weapon") exitWith { ERROR("Invalid param"); false };
private _type = (_weapon get "config") get "type";
if (_type != ITEM_TYPE_WEAPON_HANDGUN and {_type != ITEM_TYPE_WEAPON_PRIMARY and {_type != ITEM_TYPE_WEAPON_SECONDARY}}) exitWith { ERROR("Item is not weapon"); false };
#endif

private _weaponConfig = _weapon get "config";
private _config = _item get "config";
(switch (_config get "type") do 
{
	case ITEM_TYPE_WEAPON_MUZZLE: { (_config get "configName") in (_weaponConfig get "muzzleTypes") };
	case ITEM_TYPE_WEAPON_POINTER: { (_config get "configName") in (_weaponConfig get "pointerTypes")};
	case ITEM_TYPE_WEAPON_OPTIC: { (_config get "configName") in (_weaponConfig get "opticTypes") };
	case ITEM_TYPE_WEAPON_BIPOD: {(_config get "configName") in (_weaponConfig get "bipodTypes")};
	default { ERROR("Not supported item type"); false};
})


