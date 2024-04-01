// [_unit, GEAR_SLOT_ID_WEAPON_PRIMARY, _muzzleName] call AZ_Unit_fnc_weaponReloaded;

#define TRACE_MODE
#include "..\macros.hpp"

// params ["_unit", "_weaponSlotID", "_muzzleName", "_newMagazine", ["_oldMagazine", nil]];
params ["_unit", "_weaponSlotID", "_muzzleName", "_newMagazine"];

// Magazine - Array of
// 	magazineClass: String - class name of the magazine
//	ammoCount: Number - amount of ammo in magazine
// 	magazineID: Number - global magazine id
// 	magazineCreator: Number - owner of the magazine creator

/*
private _fnc_findCont =
{	
	params ["_magList", "_magazineID"];
	private _ret = false;
	{
		// "Chemlight (Green)(1/1)[id/cr:10000020/0]"
		private _str = _x;
		private _iStart = (_str find ":") + 1;
		private _iEnd = (_str find ["/", _iStart]);
		private _id = parseNumber (_str select [_iStart, _iEnd - _iStart]); 
		//TRACE_2("id: %1 == %2", (_magazineID - 1e+007), (_id - 1e+007));
		if (_id == _magazineID) exitWith {_ret=true;};
		
	} forEach _magList;
	
	_ret
};
private _magList = magazinesDetailUniform _unit;
private _ret = [_magList, _magazineID] call _fnc_findCont;
TRACE_1("magazine in UNIFORM: %1", _ret);
*/
// _newMagazine params ["_newMagazineClass", "_newMagazineAmmoCount"];
_newMagazine params ["_newMagazineClass"];

private _weapon = [_unit, _weaponSlotID] call AZ_Unit_fnc_getGear;
if (isNil '_weapon') exitWith { ERROR("Weapon not found in gear"); };

//
private _curMag = [_weapon, _muzzleName] call AZ_Item_fnc_Weapon_getMagazine;
private _isIntegral = false;
if (not isNil '_curMag') then
{
	_isIntegral = (_curMag call AZ_Item_fnc_Magazine_isIntegral);
};

//
private _fnc_findMagazine = 
{
	private _list = [GEAR_SLOT_ID_VEST, GEAR_SLOT_ID_UNIFORM, GEAR_SLOT_ID_BACKPACK]; 
	private _gearSlotID = 0;
	private _magID = 0;
	private _max = 0;
	private _magCap = 0;
	{
		private _slotID = _x;
		private _gearItem = [_unit, _slotID] call AZ_Unit_fnc_getGear;
		if (not isNil '_gearItem') then
		{
			private _itemsList = (_gearItem get "ItemsContainer") get "itemsList";
			{
				private _itemID = _x;
				private _item = _y;
				if (((_item get "config") get "type") == ITEM_TYPE_MAGAZINE) then
				{
					if ((_item get "armaClass") isEqualTo _newMagazineClass) then
					{
						if (_magCap == 0) then { _magCap = _item get "config" get "capacity"; };
						if ((_item get "ammoCount") > _max) then 
						{				
							if ([_weapon, _item, _muzzleName] call AZ_Item_fnc_Weapon_isCompatibleMagazine) then 
							{
								_gearSlotID = _slotID;
								_magID = _itemID;
								_max = (_item get "ammoCount");
							};
						};
					};
				};
				if (_max > 0 and {_max >= _magCap}) exitWith{};
				
			} forEach _itemsList; 
		};
		if (_max > 0 and {_max >= _magCap}) exitWith {};
		// if (_magID != 0) exitWith { _gearSlotID = _slotID; };
		
	} forEach _list;
	
	[_gearSlotID, _magID]
};

private _fnc_findAmmo = 
{
	params ["_magazine"];
	
	private _list = [GEAR_SLOT_ID_VEST, GEAR_SLOT_ID_UNIFORM, GEAR_SLOT_ID_BACKPACK]; 
	private _gearSlotID = 0;
	private _ammoItemID = 0;
	private _max = 0;
	private _magConfig = _magazine get "config";
	private _magCap = _magConfig get "capacity";	
	{
		private _slotID = _x;
		private _gearItem = [_unit, _slotID] call AZ_Unit_fnc_getGear;
		if (not isNil '_gearItem') then
		{
			// _ammoItemID = [_item, _magazine] call _fnc_findAmmoAtUniform;
			private _itemsList = (_gearItem get "ItemsContainer") get "itemsList";
			{
				private _itemID = _x;
				private _item = _y;
				private _itemConfig = (_item get "config");
				if ((_itemConfig get "type") == ITEM_TYPE_AMMO) then
				{
					private _ammoName = (_itemConfig get "configName");
					if ([_magazine, _ammoName] call AZ_Item_fnc_Magazine_isCompatibleAmmo) then
					{
						if ((_magConfig get _ammoName) isEqualTo _newMagazineClass) then 
						{
							private _amount = (_item get "amount");
							if (_amount > _max) then 
							{
								_gearSlotID = _slotID;
								_ammoItemID = _itemID;
								_max = _amount;
							};					
						};				
					};
				};
				if (_max > 0 and {_max >= _magCap}) exitWith {};
				
			} forEach _itemsList; 
		};
		if (_max > 0 and {_max >= _magCap}) exitWith {};
		//if (_ammoItemID != 0) exitWith { _gearSlotID = _slotID; };
		
	} forEach _list;
	
	[_gearSlotID, _ammoItemID]
};


if (_isIntegral) then 
{
	(_curMag call _fnc_findAmmo) params ['_gearSlotID', '_ammoItemID'];
	if (_ammoItemID == 0 or {_gearSlotID == 0}) exitWith { ERROR("Not found reloaded ammo"); };
	
	private _magConfig = _curMag get "config";
	private _magCap = _magConfig get "capacity";
	([_unit, _gearSlotID, _ammoItemID, _magCap] call AZ_Unit_fnc_takeItem) params ["_newAmmo", "_isDeleted", "_slotRect"];
	
	private _curAmmo = _curMag call AZ_Item_fnc_Magazine_takeAmmo;
	if (not isNil '_curAmmo') then
	{
		if (_isDeleted) then 
		{
			private _itemID = [_unit, _gearSlotID, _curAmmo, _slotRect] call AZ_Unit_fnc_addItem;
			if (isNil "_itemID") then
			{
				_itemID = [_unit, _gearSlotID, _curAmmo] call AZ_Unit_fnc_addItem;
				if (isNil "_itemID") then { ERROR("Cant add item to container"); };
			};
		}
		else
		{
			private _itemID = nil;
			private _list = [GEAR_SLOT_ID_VEST, GEAR_SLOT_ID_UNIFORM, GEAR_SLOT_ID_BACKPACK]; 
			{
				private _gearSlotID = _x;
				_itemID = [_unit, _gearSlotID, _curAmmo] call AZ_Unit_fnc_addItem;
				if (not isNil "_itemID") exitWith {};
			
			} forEach _list;
			if (isNil "_itemID") then { ERROR("Cant add item to Unit"); };
			
		};
	};
	
	if (not ([_unit, _weaponSlotID, _newAmmo, _muzzleName] call AZ_Unit_fnc_setWeaponAmmo)) then { ERROR("Cant set ammo to weapon"); };
}
else
{
	// find and take new magazine
	(0 call _fnc_findMagazine) params ['_gearSlotID', '_magID'];
	if (_magID == 0 or {_gearSlotID == 0}) exitWith { ERROR("Not found reloaded magazine"); };	
	([_unit, _gearSlotID, _magID, 1] call AZ_Unit_fnc_takeItem) params ["_newMag", "_isDeleted", "_slotRect"];
	
	// take current magazine and add it to inventory
	_curMag = [_weapon, _muzzleName] call AZ_Item_fnc_Weapon_takeMagazine; 
	if (not isNil '_curMag') then
	{
		if (_isDeleted) then 
		{
			private _itemID = [_unit, _gearSlotID, _curMag, _slotRect] call AZ_Unit_fnc_addItem;
			if (isNil "_itemID") then
			{
				_itemID = [_unit, _gearSlotID, _curMag] call AZ_Unit_fnc_addItem;
				if (isNil "_itemID") then { ERROR("Cant add item to container"); };
			};
		}
		else
		{
			private _itemID = nil;
			private _list = [GEAR_SLOT_ID_VEST, GEAR_SLOT_ID_UNIFORM, GEAR_SLOT_ID_BACKPACK]; 
			{
				private _gearSlotID = _x;
				_itemID = [_unit, _gearSlotID, _curMag] call AZ_Unit_fnc_addItem;
				if (not isNil "_itemID") exitWith {};
			
			} forEach _list;
			if (isNil "_itemID") then { ERROR("Cant add item to Unit"); };
			
		};
	};
	
	// set 	
	if (not ([_unit, _weaponSlotID, _newMag, _muzzleName] call AZ_Unit_fnc_setWeaponMagazine)) then { ERROR("Cant set magazine to weapon"); };
};

