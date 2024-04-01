//
disableSerialization;

#define TRACE_MODE
#include "..\macros.hpp"

params ["_mode", "_param"];

//private _display = findDisplay 565656;
//if (isNull _display) exitWith { ERROR("dont found display 'Calibrovka'"); false };

if (_mode == "onload") exitWith
{
	_param params ["_display", ["_config", configNull]];
	
	// 16:9 == x2 32:18 == x4 64:36
	//#define SIZE_W 64
	//#define SIZE_H 36
	private _GRID_H = safeZoneH/AZ_GUI_GRID_SIZE_H;
	private _GRID_W = _GRID_H*(3/4);
	private _needUpdateSizes = false;
	if (safeZoneW/_GRID_W < AZ_GUI_GRID_SIZE_W) then
	{
		_GRID_W = safeZoneW/AZ_GUI_GRID_SIZE_W;
		_GRID_H = _GRID_W * (4/3);
		_needUpdateSizes = true;
	};
	_GRID_W = _GRID_W * 2;
	_GRID_H = _GRID_H * 2;
	private _GRID_X = 0.5 - (AZ_GUI_GRID_SIZE_W * 0.5 * _GRID_W);
	private _GRID_Y = 0.5 - (AZ_GUI_GRID_SIZE_H * 0.5 * _GRID_H);
	_display setVariable ["GRID", [_GRID_X, _GRID_Y, _GRID_W, _GRID_H]];
	
	private _unit = player;
	_display setVariable ["unit", _unit];
	
	private _ctrl = _display displayCtrl 1000;
	['setItemType', [_ctrl]] call AZ_fnc_Calibrovka;
};

if (_mode == "setItemType") exitWith
{
	_param params ["_control"];	
	private _display = ctrlParent _control;
	if (isNull _display) exitWith { ERROR("dont found display 'Calibrovka'"); false };
	
	if (ctrlIDC _control == 1000) then { _display setVariable ["AZ_CurrentItemType", ITEM_TYPE_WEAPON_MUZZLE]; };
	if (ctrlIDC _control == 1001) then { _display setVariable ["AZ_CurrentItemType", ITEM_TYPE_WEAPON_POINTER]; };
	if (ctrlIDC _control == 1002) then { _display setVariable ["AZ_CurrentItemType", ITEM_TYPE_WEAPON_OPTIC]; };
	if (ctrlIDC _control == 1003) then { _display setVariable ["AZ_CurrentItemType", ITEM_TYPE_WEAPON_BIPOD]; };
	
	
	private _type = _display getVariable "AZ_CurrentItemType";
	private _key = switch (_type) do 
	{
		case ITEM_TYPE_WEAPON_MUZZLE: { "muzzlePoint" };
		case ITEM_TYPE_WEAPON_OPTIC: { "opticPoint" };
		case ITEM_TYPE_WEAPON_POINTER: { "pointerPoint" };
		case ITEM_TYPE_WEAPON_BIPOD: { "bipodPoint" };
	};
	private _weap = [_display, GEAR_SLOT_ID_WEAPON_PRIMARY] call AZ_GearDialog_fnc_Gear_getItem;
	if (isNil '_weap') exitWith {ERROR("Dont found weapon");};	
	((_weap get "config") get _key) params ["_weapOffsetX", "_weapOffsetY", ["_weapScale", 1]];
	
	private _ctrl = _display displayCtrl 200;
	_ctrl sliderSetPosition (_weapOffsetX*100);
	_ctrl ctrlCommit 0;
	
	_ctrl = _display displayCtrl 201;
	_ctrl sliderSetPosition (_weapOffsetY*100);
	_ctrl ctrlCommit 0;
	
	_ctrl = _display displayCtrl 202;
	_ctrl sliderSetPosition (_weapScale*100);
	_ctrl ctrlCommit 0;
	
	private _optic = _weap get _type;
	((_optic get "config") get "anchorPoint") params ["_itemOffsetX", "_itemOffsetY", ["_itemScale", 1]];
	
	_ctrl = _display displayCtrl 400;
	_ctrl sliderSetPosition (_itemOffsetX*100);
	_ctrl ctrlCommit 0;	
	
	_ctrl = _display displayCtrl 401;
	_ctrl sliderSetPosition (_itemOffsetY*100);
	_ctrl ctrlCommit 0;
	
	_ctrl = _display displayCtrl 402;
	_ctrl sliderSetPosition (_itemScale*100);
	_ctrl ctrlCommit 0;
	
	['slider', [_control]] call AZ_fnc_Calibrovka;
	
};

if (_mode == "slider") exitWith
{
	_param params ["_control", "_newValue"];
	private _display = ctrlParent _control;
	if (isNull _display) exitWith { ERROR("dont found display 'Calibrovka'"); false };
	
	private _weap = [_display, GEAR_SLOT_ID_WEAPON_PRIMARY] call AZ_GearDialog_fnc_Gear_getItem;
	if (isNil '_weap') exitWith {ERROR("Dont found weapon");};
	
	[_display, GEAR_SLOT_ID_WEAPON_PRIMARY, _weap] call AZ_GearDialog_fnc_Gear_UpdateSlot;
	_ctrl = _display displayCtrl 70;
	_ctrl ctrlSetPosition (ctrlPosition(_display displayCtrl (GEAR_SLOT_ID_WEAPON_PRIMARY + 8)));
	_ctrl ctrlCommit 0;
	
	private _weapOffset = [0,0,1];
	private _ctrl = _display displayCtrl 200;
	_weapOffset set [0, (sliderPosition _ctrl) / 100];
	_ctrl = _display displayCtrl 201;
	_weapOffset set [1, (sliderPosition _ctrl) / 100];
	_ctrl = _display displayCtrl 202;
	_weapOffset set [2, (sliderPosition _ctrl) / 100];
	
	private _itemOffset = [0,0,1];
	_ctrl = _display displayCtrl 400;
	_itemOffset set [0, (sliderPosition _ctrl) / 100];
	_ctrl = _display displayCtrl 401;
	_itemOffset set [1, (sliderPosition _ctrl) / 100];
	_ctrl = _display displayCtrl 402;
	_itemOffset set [2, (sliderPosition _ctrl) / 100];
	
	// TRACE_1("%1", _weapOffset);
	
	private _type = _display getVariable "AZ_CurrentItemType";
	private _key = switch (_type) do 
	{
		case ITEM_TYPE_WEAPON_MUZZLE: { "muzzlePoint" };
		case ITEM_TYPE_WEAPON_OPTIC: { "opticPoint" };
		case ITEM_TYPE_WEAPON_POINTER: { "pointerPoint" };
		case ITEM_TYPE_WEAPON_BIPOD: { "bipodPoint" };
	};
	(_weap get "config") set [_key, _weapOffset];
	
	private _optic = _weap get _type;
	if (isNil '_optic') exitWith {ERROR("Dont found weapon item");};
	(_optic get "config") set ["anchorPoint", _itemOffset];
	
	[_display, GEAR_SLOT_ID_WEAPON_PRIMARY, _weap] call AZ_GearDialog_fnc_Gear_UpdateSlot;

	_ctrl = _display displayCtrl 80;
	_ctrl ctrlsetText (format["Weapon point: %1", _key]);
	_ctrl ctrlCommit 0;

	_weapOffset params ["_weapOffsetX", "_weapOffsetY", ["_weapScale", 1]];
	_itemOffset params ["_itemOffsetX", "_itemOffsetY", ["_itemScale", 1]];
	private _s = format ["%1[] = {%2, %3, %4};  anchorPoint[] = {%5, %6, %7};", _key, _weapOffsetX, _weapOffsetY,_weapScale, _itemOffsetX,_itemOffsetY,_itemScale];
	_ctrl = _display displayCtrl 98;
	_ctrl ctrlsetText _s;
	_ctrl ctrlCommit 0;
};

if (_mode == "export") exitWith
{
	_param params ["_control"];
	private _display = ctrlParent _control;
	if (isNull _display) exitWith { ERROR("dont found display 'Calibrovka'"); false };
	
	_ctrl = _display displayCtrl 98;
	private _s = ctrlText _ctrl;
	copyToClipboard _s;
};