// private AZ_GearDialog_fnc_dropAt = 

#define TRACE_MODE
#include "..\macros.hpp"

params ["_display", "_item", "_slotID", "_slotParentIDC", ["_position", nil]];

if (isNull _display) exitWith {false};

private _dropDone = false;

private _fnc_dropAtPrimaryWeaponMag = 
{
	params ["_weaponSlotID", "_muzzleIndex"];
	
	private _dragItemType = ((_item get "config") get "type");
	if (_dragItemType == ITEM_TYPE_AMMO) exitWith
	{
		private _unit = _display call AZ_GearDialog_fnc_getUnit; 
		if ([_unit, _weaponSlotID, _item, _muzzleIndex] call AZ_Unit_fnc_addWeaponAmmo) then
		{
			if (_item get "amount" > 0) then
			{
				_dropDone = false; // !!! need Back drag item
			}
			else { _dropDone = true; };
			[_display, _weaponSlotID] call AZ_GearDialog_fnc_Gear_onSlotChanged;
		};		
	};
	if (_dragItemType == ITEM_TYPE_MAGAZINE) exitWith 
	{			
		private _unit = _display call AZ_GearDialog_fnc_getUnit; 
		private _weapon = [_unit, _weaponSlotID] call AZ_Unit_fnc_getGear;
		if (isNil "_weapon") exitWith {};
		if (not([_weapon, _item, _muzzleIndex] call AZ_Item_fnc_Weapon_isCompatibleMagazine)) exitWith {};
		
		private _currentMag = [_weapon, _muzzleIndex] call AZ_Item_fnc_Weapon_getMagazine;
		if (not isNil "_currentMag") exitWith {};
		
		// set primary weapon magazine in to main muzzle
		if (not ([_unit, _weaponSlotID, _item, _muzzleIndex] call AZ_Unit_fnc_setWeaponMagazine)) exitWith {};
		[_display, _weaponSlotID] call AZ_GearDialog_fnc_Gear_onSlotChanged;
		_dropDone = true;
	};
};

switch (_slotParentIDC) do 
{
	case 0:
	{	
		switch (_slotID) do 
		{
			case 0:
			{
				ERROR_NO_IMPLEMENTATION;
			};
			// Drop on Gear slot
			case GEAR_SLOT_ID_NVG;
			case GEAR_SLOT_ID_GOGGLE;
			case GEAR_SLOT_ID_HEADGEAR;
			case GEAR_SLOT_ID_UNIFORM;
			case GEAR_SLOT_ID_VEST;
			case GEAR_SLOT_ID_BACKPACK:
			{
				// add drag item to gear slot	
				if ([_display, _slotID, _item] call AZ_GearDialog_fnc_Gear_setItem) then {  _dropDone = true; };
			};
			case GEAR_SLOT_ID_WEAPON_SECONDARY;
			case GEAR_SLOT_ID_WEAPON_HANDGUN;
			case GEAR_SLOT_ID_WEAPON_PRIMARY:
			{
				private _dragItemType = ((_item get "config") get "type");
				switch (_dragItemType) do 
				{
					case ITEM_TYPE_WEAPON_SECONDARY;
					case ITEM_TYPE_WEAPON_HANDGUN;
					case ITEM_TYPE_WEAPON_PRIMARY:
					{
						// add drag item to slot	
						if ([_display, _slotID, _item] call AZ_GearDialog_fnc_Gear_setItem) then {  _dropDone = true; };
					};
					case ITEM_TYPE_WEAPON_MUZZLE;
					case ITEM_TYPE_WEAPON_OPTIC;
					case ITEM_TYPE_WEAPON_BIPOD;
					case ITEM_TYPE_WEAPON_POINTER:
					{
						private _unit = _display call AZ_GearDialog_fnc_getUnit;
						private _weapon = [_unit, _slotID] call AZ_Unit_fnc_getGear;
						if (isNil "_weapon") exitWith {};
						private _curItem = [_weapon, _dragItemType] call AZ_Item_fnc_Weapon_getItem;
						if (not isNil "_curItem") exitWith {};
						
						if ([_unit, _slotID, _item] call AZ_Unit_fnc_setWeaponItem) then 
						{
							[_display, _slotID] call AZ_GearDialog_fnc_Gear_OnSlotChanged;
							_dropDone = true;
						};
					};
					case ITEM_TYPE_MAGAZINE:
					{
						private _unit = _display call AZ_GearDialog_fnc_getUnit; 
						private _weapon = [_unit, _slotID] call AZ_Unit_fnc_getGear;
						if (isNil "_weapon") exitWith {};
						//TRACE_1("%1", (_weapon get "config" get "configName"));
						private _muzzle = [_weapon, _item] call AZ_Item_fnc_Weapon_getMuzzleByMagazine;
						if (isNil "_muzzle") exitWith {};
						//TRACE_1("%1", _muzzle get "config" get "configName");
						[_slotID, (_muzzle get "config" get "configName")] call _fnc_dropAtPrimaryWeaponMag;
					};
				};
			};
			case GEAR_SLOT_ID_WEAPON_PRIMARY_MAG_0:
			{
				[GEAR_SLOT_ID_WEAPON_PRIMARY, 0] call _fnc_dropAtPrimaryWeaponMag;
			};			
			case GEAR_SLOT_ID_WEAPON_PRIMARY_MAG_1:
			{
				[GEAR_SLOT_ID_WEAPON_PRIMARY, 1] call _fnc_dropAtPrimaryWeaponMag;
			};
			default { ERROR_NO_IMPLEMENTATION; };
		};
	};
	// Drop on Container
	case GEAR_DIALOG_UNIFORM_CONTAINER_IDC;
	case GEAR_DIALOG_VEST_CONTAINER_IDC;
	case GEAR_DIALOG_BACKPACK_CONTAINER_IDC; // Drop on Right container
	case GEAR_DIALOG_LEFT_CONTAINER_IDC: // Drop on Left container
	{
		// DROP on container or slot in container
		private _needAdd = true;
		if (_slotID != _slotParentIDC) then
		{
			// DROP on slot
			//ERROR_NO_IMPLEMENTATION;
			_needAdd = true; // тут обрабатываем индивидуальное для итема действие(stack, add magazine or ...), и если не нужно добавлять итем как новый то ставим ложь
		};
		if (_needAdd) then // DROP on container
		{				
			private _resault = [_display, _slotParentIDC, _item, _position] call AZ_GearDialog_fnc_Container_addItem;
			if (isNil "_resault") then
			{
				// try add at auto position 
				_resault = [_display, _slotParentIDC, _item] call AZ_GearDialog_fnc_Container_addItem;
			};
			if (not isNil "_resault") then { _dropDone = true; };
		};

	};
	default { ERROR_NO_IMPLEMENTATION; };
};

_dropDone
