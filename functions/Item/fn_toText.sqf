//AZ_Item_fnc_toText 

#include "..\macros.hpp"

params ["_item"];

if (isNil "_item") exitWith {""};

private _config = (_item get "config");
private _textTop = "";
private _textBottom = "";

/*
private _fnc_makeLineBreak = 
{
	private _sizeH = (_slotSize select 1);
	private _lineBreak = [];	
	if (_sizeH > 0) then
	{
		_sizeH = (_sizeH * 1) - 1;
		for [{_i=0}, {_i<_sizeH}, {_i=_i+1}] do
		{
			_lineBreak pushBack "<br/>";
		};
		//_lineBreak pushBack "<br/>";
	};
	_lineBreak joinString "";
	
	""
};
*/
switch (_config get "type") do
{
	case ITEM_TYPE_MAGAZINE: 
	{
		private _amount = _item get "amount";
		private _capacity = _config get "capacity";
		private _ammoCount = _item get "ammoCount";
		/*private _ammoType = _item get "ammo";
		if (_ammoType == "") then
		{
			_ammoType = (_config get "displayName");
		}
		else
		{
			private _ammoConfig = _ammoType call AZ_Item_fnc_getConfig;
			_ammoType = _ammoConfig get "displayName";
		};*/
		if (_capacity > 1) then 
		{
			_textTop = format ["%1/%2", _ammoCount, _capacity];
		};
		if (_amount > 1) then 
		{
			_textBottom = format ["<t align='right'>%1</t>", _amount];
		};
	};
	case ITEM_TYPE_WEAPON_PRIMARY: 
	{
		_textTop = format ["%1", (_config get "displayName")];
		
		private _muzzle = _item get ITEM_TYPE_WEAPON_MUZZLE; //ITEM_TYPE_WEAPON_MUZZLE;
		if (not isNil '_muzzle') then { _muzzle = _muzzle get "config" get "picture" } else {_muzzle = "";};
		private _pointer = _item get ITEM_TYPE_WEAPON_POINTER; 
		if (not isNil '_pointer') then { _pointer = _pointer get "config" get "picture" } else {_pointer = "";};
		private _optic = _item get ITEM_TYPE_WEAPON_OPTIC; 
		if (not isNil '_optic') then { _optic = _optic get "config" get "picture" } else {_optic = "";};
		private _bipod = _item get ITEM_TYPE_WEAPON_BIPOD; 
		if (not isNil '_bipod') then { _bipod = _bipod get "config" get "picture" } else {_bipod = "";};
		private _mag = [_item, 0] call AZ_Item_fnc_Weapon_getMagazine; 
		if (not isNil '_mag') then { _mag = _mag call AZ_Item_fnc_Magazine_getPicture; } else {_mag = "";};
		private _GL = [_item, 1] call AZ_Item_fnc_Weapon_getMagazine; 
		if (not isNil '_GL') then { _GL = _GL call AZ_Item_fnc_Magazine_getPicture; } else {_GL = "";};
		
		// _textTop = format ["%1<br/><t size='1'><img image='%2'/><img image='%3'/><img image='%4'/><img image='%5'/></t>", (_config get "displayName"), _muzzle, _pointer, _optic, _bipod];
		_textBottom = format ["<t size='0.9'><img image='%1'/><img image='%2'/><img image='%3'/><img image='%4'/></t><t size='1' align='right'><img image='%5'/><img image='%6'/></t>", _muzzle, _pointer, _optic, _bipod, _GL, _mag];
	};
	case ITEM_TYPE_UNIFORM;//:	{ ERROR_NO_IMPLEMENTATION; };
	case ITEM_TYPE_VEST;//:	{ ERROR_NO_IMPLEMENTATION; };
	case ITEM_TYPE_BACKPACK:
	{
		_textTop = format ["%1", (_config get "displayName")];
		
		private _amount = _item get "amount";
		if (_amount <= 1) then {_amount = "";};
		private _container = _item get "ItemsContainer";
		//private _space = (_container get "space");
		(_container get "space") params ["_free", "_total"];
		// (_config get "slotSize") params ["_slotSizeW", "_slotSizeH"];
		(_item call AZ_Item_fnc_getSlotSize) params ["_slotSizeW", "_slotSizeH"];
		private _color = "#e0e0e0";
		if ((_total - _free) > (_slotSizeW * _slotSizeH)) then { _color = "#d99800"}; 
		_textBottom = format ["<t color='%1'>%2/%3</t><t align='right'>%4</t>", _color, (_total - _free), _total, _amount];
	};	
	case ITEM_TYPE_AMMO;
	default
	{
		_textTop = format ["%1", (_config get "displayName")];
		
		private _amount = _item get "amount";
		if (_amount > 1) then 
		{
			_textBottom = format ["<t align='right'>%1</t>", _amount];
		};
	};
};

_textTop = format ["<t size='0.5'>%1</t>", _textTop];
_textBottom = format ["<t size='0.6'>%1</t>", _textBottom];

[_textTop, _textBottom]
