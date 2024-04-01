// AZ_Item_fnc_create =
#include "..\macros.hpp"

params ["_configName", ["_amount", 1]];
	
private _item = createHashMap;
private _config = _configName call AZ_Item_fnc_getConfig;

_item set ["config", _config];

// runtime props
_amount = _amount min (_config get "stack");
_item set ["amount", _amount]; // using if stack > 1
_item set ["weight", (_config get "weight")];
_item set ["slotRotation", 0];

private _fnc_createMuzzleMagazine = 
{
	params ["_muzzle", "_config"];
	
	//private _magTypes = _config get "magazineTypes";
	//private _magConfig = _config get "Mag_integral";
	private _defMagName = _config get "magazine";
	if (isNil '_defMagName' or { _defMagName isEqualTo "" }) then
	{
		_muzzle set ["magazine", nil];
	}
	else
	{
		private _mag = [_defMagName, 1] call AZ_Item_fnc_create;		
		// set magazine
		_muzzle set ["magazine", _mag];
	};
};

switch (_config get "type") do
{
	case ITEM_TYPE_AMMO:
	{
		
	};
	case ITEM_TYPE_MAGAZINE: 
	{
		//private _ammo = ((_config get "ammoTypes") select 0);
		//if (isNil '_ammo' or {_ammo isEqualTo ""}) then { ERROR("Invalid Ammo list"); };
		_item set ["armaClass", (_config get "armaClass")];
		_item set ["ammo", ""];
		_item set ["ammoCount", 0];
		//_item set ["isIntegral", ((_config get "isIntegral") != 0)];
		if (((_config get "ammo") isNotEqualTo "") and {(_config get "ammoCount") > 0}) then 
		{
			[_item, (_config get "ammo"), (_config get "ammoCount")] call AZ_Item_fnc_Magazine_setAmmo;
		};
	};
	case ITEM_TYPE_WEAPON_PRIMARY:
	{
		_item set [ITEM_TYPE_WEAPON_MUZZLE, nil];
		_item set [ITEM_TYPE_WEAPON_POINTER, nil];
		_item set [ITEM_TYPE_WEAPON_OPTIC, nil];
		_item set [ITEM_TYPE_WEAPON_BIPOD, nil];
		
		// init muzzle 0
		[_item, _config] call _fnc_createMuzzleMagazine;
		// init mizzle 1
		private _muzzleList = _config get "muzzles";
		if (count _muzzleList > 0) then
		{
			{
				private _name = _x;
				if ((_name isNotEqualTo "this") and {_name isNotEqualTo ""}) then
				{
					private _muzzle = createHashMap;
					private _muzzleConfig = (_config get _name);
					_muzzle set ["config", _muzzleConfig];
					[_muzzle, _muzzleConfig] call _fnc_createMuzzleMagazine;					
					_item set [_name, _muzzle];
				};
				
			} forEach _muzzleList;
		};
	};
};

// init items container
private _cont = _config get "ItemsContainer";
if (not isNil "_cont") then
{
	private _access = _cont get "access";
	private _capacity = _cont get "capacity";
	private _rect = _cont get "rect";
	private _isPockets = _cont get "isPockets";
	
	private _type = switch (_config get "type") do
	{
		case ITEM_TYPE_UNIFORM:	{ CONT_TYPE_UNIFORM	};
		case ITEM_TYPE_VEST:	{ CONT_TYPE_VEST	};
		case ITEM_TYPE_BACKPACK:{ CONT_TYPE_BACPACK	};
		default { ERROR_NO_IMPLEMENTATION; CONT_TYPE_VIRTUAL };
	};
	private _container = [_type, objNull, _rect, _capacity, _access] call AZ_ItemsContainer_fnc_create;
	_container set ["isPockets", (_isPockets != 0)];
	
	_item set ["ItemsContainer", _container];
};

_item



