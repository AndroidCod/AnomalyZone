
 
#include "..\macros.hpp"

_fnc_getItemArmor = 
{
	params ["_item", "_hitpoint"];

	//if ("" in [_item, _hitpoint]) exitWith { 0 };
	if ("" in [_item]) exitWith { 0 };

	private _armor = 0;
	private _itemInfo = configFile >> "CfgWeapons" >> _item >> "ItemInfo";

	if (getNumber (_itemInfo >> "type") == TYPE_UNIFORM) then 
	{
		private _unitCfg = configFile >> "CfgVehicles" >> getText (_itemInfo >> "uniformClass");
		if (_hitpoint == "") then 
		{
			// TODO: I'm not sure if this should be multiplied by the base armor value or not
			_armor = getNumber (_unitCfg >> "armorStructural");
		}
		else 
		{
			private _entry = _unitCfg >> "HitPoints" >> _hitpoint;
			_armor = getNumber (_unitCfg >> "armor") * (1 max getNumber (_entry >> "armor"));
		};
	} 
	else 
	{
		private _condition = format ["getText (_x >> 'hitpointName') == '%1'", _hitpoint];
		private _entry = configProperties [_itemInfo >> "HitpointsProtectionInfo", _condition] param [0, configNull];

		_armor = getNumber (_entry >> "armor");
	};

	_armor // return

};


params ["_unit", "_hitpoint"];

private _uniform = uniform _unit;
// If unit is naked, use its underwear class instead
if (_uniform isEqualTo "") then {
    _uniform = getText (configOf _unit >> "nakedUniform");
};

private _armor = 0;

_armor = _armor + ([_uniform, _hitpoint] call _fnc_getItemArmor);
_armor = _armor + ([vest _unit, _hitpoint] call _fnc_getItemArmor);
_armor = _armor + ([headgear _unit, _hitpoint] call _fnc_getItemArmor);


_armor // return