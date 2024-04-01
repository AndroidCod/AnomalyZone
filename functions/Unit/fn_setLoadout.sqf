// _unit call AZ_Unit_fnc_setLoadout

#define TRACE_MODE
#include "..\macros.hpp"

params ["_unit", ["_filter", [], [[], 0]]];

if (typeName _filter isEqualTo "SCALAR") then
{
	_filter = [_filter];
}; 
if (typeName _filter isNotEqualTo "ARRAY") exitWith { ERROR("Invalid params type"); }; 

private _fnc_getWeaponItem = 
{
	params ["_weapon", "_itemType"];
	private _wpnItem = (_weapon get _itemType);
	if (isNil "_wpnItem") exitWith { "" };
	(_wpnItem get "config" get "armaClass")
};

private _fnc_getWeaponMagazine = 
{
	params ["_weapon", "_muzzleIndex"];

	if ( _muzzleIndex >= (count (_weapon get "config" get "muzzles"))) exitWith { [] };  

	private _mag = [_weapon, _muzzleIndex] call AZ_Item_fnc_Weapon_getMagazine;
	if (isNil '_mag') exitWith { [] };
	
	private _class = (_mag get "armaClass");
	if (_class isEqualTo "") exitWith { [] };
	
	[_class, (_mag get "ammoCount")]
};

private _fnc_getWeapon =
{
	params ["_gearSlotID"];
	private _w = [_unit, _gearSlotID] call AZ_Unit_fnc_getGear;
	if (isNil '_w') exitWith { [] };	
	if ((_gearSlotID == GEAR_SLOT_ID_WEAPON_SECONDARY) and {(_w get "config" get "type") == ITEM_TYPE_WEAPON_PRIMARY}) exitWith { [] };
	[
		(_w get "config" get "armaClass"),
		([_w, ITEM_TYPE_WEAPON_MUZZLE] call _fnc_getWeaponItem),
		([_w, ITEM_TYPE_WEAPON_POINTER] call _fnc_getWeaponItem),
		([_w, ITEM_TYPE_WEAPON_OPTIC] call _fnc_getWeaponItem),
		([_w, 0] call _fnc_getWeaponMagazine),
		([_w, 1] call _fnc_getWeaponMagazine),
		([_w, ITEM_TYPE_WEAPON_BIPOD] call _fnc_getWeaponItem)
	]
};

private _fnc_makeMagazinesFromAmmo =
{
	params ["_loadout", "_ammoItem", "_weaponSlotID", "_muzzleIndex"];
	
	private _weapon = [_unit, _weaponSlotID] call AZ_Unit_fnc_getGear;
	if (isNil '_weapon') exitWith {};
	if (_weaponSlotID == GEAR_SLOT_ID_WEAPON_SECONDARY and { (_weapon get "config" get "type") == ITEM_TYPE_WEAPON_PRIMARY }) exitWith {};
	
	private _magazine = [_weapon, _muzzleIndex] call AZ_Item_fnc_Weapon_getMagazine;
	if (isNil '_magazine') exitWith {}; 
	if (_magazine call AZ_Item_fnc_Magazine_isIntegral) then
	{
		private _ammoType = (_ammoItem get "config") get "configName";
		if ([_magazine, _ammoType] call AZ_Item_fnc_Magazine_isCompatibleAmmo) then 
		{
			// create arma magazines from Ammo stack
			private _ammoCount = _ammoItem get "amount";
			private _magConfig = _magazine get "config";
			private _magArmaClass = _magConfig get _ammoType;
			private _magCap = _magConfig get "capacity"; 
			private _count = floor (_ammoCount / _magCap);
			if (_count > 0) then { _loadout pushBack [_magArmaClass, _count, _magCap]; };
			_count = _ammoCount - (_count * _magCap);
			if (_count > 0) then { _loadout pushBack [_magArmaClass, 1, _count]; };
		};
	};
};

private _fnc_getContainer = 
{
	params ["_itemContainer"];
	
	private _container = _itemContainer get "ItemsContainer";
	if (isNil '_container') exitWith { [] };
	
	private _loadout = [];
	private _itemsList = (_container get "itemsList");
	{
		private _item = _y;
		private _itemConfig = _item get "config";
		private _itemType = _itemConfig get "type";
		switch (_itemType) do
		{
			case ITEM_TYPE_MAGAZINE:
			{
				if (_item get "ammoCount" > 0) then
				{
					_loadout pushBack [(_item get "armaClass"), (_item get "amount"), (_item get "ammoCount")];
				};
			};
			case ITEM_TYPE_GRENADE:
			{
				// TRACE_1("%1", (_itemConfig get "armaClass")); 
				_loadout pushBack [(_itemConfig get "armaClass"), (_item get "amount"), 1];
			};
			case ITEM_TYPE_AMMO:
			{
				// create magazines from ammo. Using for weapon with integral magazine  
				[_loadout, _item, GEAR_SLOT_ID_WEAPON_PRIMARY, 0] call _fnc_makeMagazinesFromAmmo;
				[_loadout, _item, GEAR_SLOT_ID_WEAPON_PRIMARY, 1] call _fnc_makeMagazinesFromAmmo;
			};
		};
		
	} forEach _itemsList;
	
	_loadout
};

private _fnc_getUniform =
{
	params ["_gearSlotID"];
	private _item = [_unit, _gearSlotID] call AZ_Unit_fnc_getGear;
	if (isNil '_item') exitWith { [] };
	
	[	
		(_item get "config" get "armaClass"),
		// (if (_gearSlotID != GEAR_SLOT_ID_BACKPACK) then {(_item call _fnc_getContainer)} else {[]})
		(_item call _fnc_getContainer)
	]
};

private _fnc_getGear =
{
	params ["_gearSlotID"];
	private _item = [_unit, _gearSlotID] call AZ_Unit_fnc_getGear;
	if (isNil '_item') exitWith { "" };
	(_item get "config" get "armaClass")
};

private _loadout = if (count _filter > 0) then 
 {
	private _load = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil];
	{
		private _id = _x;
		switch (_id) do 
		{
			case GEAR_SLOT_ID_WEAPON_PRIMARY: 	{ _load set [LOADOUT_WEAPON_PRIMARY, (_id call _fnc_getWeapon)];};
			case GEAR_SLOT_ID_WEAPON_SECONDARY: { _load set [LOADOUT_WEAPON_SECONDARY, (_id call _fnc_getWeapon)];};
			case GEAR_SLOT_ID_WEAPON_HANDGUN: 	{ _load set [LOADOUT_WEAPON_HANDGUN, (_id call _fnc_getWeapon)];};
			
			case GEAR_SLOT_ID_UNIFORM: 	{ _load set [LOADOUT_UNIFORM, (_id call _fnc_getUniform)];};
			case GEAR_SLOT_ID_VEST: 	{ _load set [LOADOUT_VEST, (_id call _fnc_getUniform)];};
			case GEAR_SLOT_ID_BACKPACK: { _load set [LOADOUT_BACKPACK, (_id call _fnc_getUniform)];};
			
			case GEAR_SLOT_ID_HEADGEAR: { _load set [LOADOUT_HEADGEAR, (_id call _fnc_getGear)];};
			case GEAR_SLOT_ID_GOGGLE: 	{ _load set [LOADOUT_GOGGLE, (_id call _fnc_getGear)];};
			
			//case LOADOUT_BINOCULAR: { _load set [LOADOUT_BINOCULAR, (["", "", "", "", [], [], ""])]; };
			case GEAR_SLOT_ID_NVG: { _load set [LOADOUT_ASSIGNED_ITEMS, (["", "", "", "", "", (GEAR_SLOT_ID_NVG call _fnc_getGear)])]; };
			default { ERROR_NO_IMPLEMENTATION; };
		};
		
	}forEach _filter;
	_load
 }
 else 
 {
	[
		(GEAR_SLOT_ID_WEAPON_PRIMARY call _fnc_getWeapon),
		(GEAR_SLOT_ID_WEAPON_SECONDARY call _fnc_getWeapon),	// Secondary weapon info (see primary above)
		(GEAR_SLOT_ID_WEAPON_HANDGUN call _fnc_getWeapon),
		
		(GEAR_SLOT_ID_UNIFORM call _fnc_getUniform), // Uniform
		(GEAR_SLOT_ID_VEST call _fnc_getUniform), // Vest Info
		(GEAR_SLOT_ID_BACKPACK call _fnc_getUniform), // Backpack Info
		
		(GEAR_SLOT_ID_HEADGEAR call _fnc_getGear), // Helmet
		(GEAR_SLOT_ID_GOGGLE call _fnc_getGear),						//Facewear glasses/bandanna etc
		["", "", "", "", [], [], ""], //["Binocular", "", "", "", [], [], ""],	// Weapon Binocular (follows same layout as other weapons above)
		["", "", "", "", "", (GEAR_SLOT_ID_NVG call _fnc_getGear)] 
		//["ItemMap", "ItemGPS", "ItemRadio", "ItemCompass", "ItemWatch", "NVGoggles"]	// AssignedItems ItemGPS can also be a UAV Terminal
	]
 };
 

// Array in format [weapon, muzzle, firemode, magazine, ammoCount, roundReloadPhase, magazineReloadPhase], where:
private _wstate = weaponState _unit;
// set
_unit setUnitLoadout [_loadout, false];

// unit selectWeapon [weapon, muzzle, firemode]
_unit selectWeapon [_wstate#0, _wstate#1, _wstate#2];
