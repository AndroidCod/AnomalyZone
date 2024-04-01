
#define TRACE_MODE
#include "..\macros.hpp"

params ["_display", ["_config", configNull]];
//params [["_display", nil]];

[1] call AZ_GUI_fnc_toggleMenuBlur;//blur background/ cool

private _GearDialog_Params = uiNameSpace getVariable ["AZ_GearDialog_Params", nil];
if (isNil "_params") then
{
	 _GearDialog_Params = [ITEMS_MAP_SORT_MODE_GROUP, [], ITEMS_MAP_SORT_MODE_GROUP, []];
	//_GearDialog_Params = [ITEMS_MAP_SORT_MODE_DEFAULT, [], ITEMS_MAP_SORT_MODE_DEFAULT, []];
	uiNameSpace setVariable ["AZ_GearDialog_Params", _GearDialog_Params];	
}; 
_GearDialog_Params params ["_leftContainerSortMode", "_leftContainerFilter", "_rightContainerSortMode", "_rightContainerFilter"]; 

//TRACE_1("%1", TEST);
//ERROR_1("%1", _leftContainerFilter);

// _display setVariable ["OnDrag", AZ_GearDialog_fnc_OnDrag];
// _display setVariable ["OnDragMove", AZ_GearDialog_fnc_OnDragMove];
// _display setVariable ["OnDrop", AZ_GearDialog_fnc_OnDrop];

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

if (_needUpdateSizes) then
{
	
	/*
	// test
	private _controlsGroup = _display displayCtrl 2000;
	_controlsGroup ctrlSetPosition [
		1 * _GRID_W + _GRID_X,
		1 * _GRID_H + _GRID_Y,
		(20+0.5) * _GRID_W,
		34 * _GRID_H
	];
	_controlsGroup ctrlCommit 0;

	//
	private _ctrl = _display displayCtrl 1000;
	_ctrl ctrlSetPosition [
		1 * _GRID_W + _GRID_X,
		1 * _GRID_H + _GRID_Y,
		20 * _GRID_W,
		34 * _GRID_H
	];
	_ctrl ctrlCommit 0;
	*/
};

// Creating gear weapons slots dynamicaly


/*
(uiNameSpace getVariable ["AZ_GearDialog_OpenedParam", []]) params ["_unit", "_container",  "_secondaryContainer"];

private _ibox = _container getVariable ["AZ_ItemsBox", nil];
*/ 
// gen random items
private _items = [
	"Helmet",
	"Goggle",
	"NVG",
	"Uniform",
	"Vest",
	"Backpack",
	"arifle",
	//"Mag_30_65x39_caseless",
	"Ammo_65x39_caseless",
	"HandGrenade",
	"Weap_m38",
	"Ammo_762x54",
	"Ammo_G_40mm_HE",
	"Muzzle_snds_H",
	"Acc_flashlight",
	"Optic_LRPS",
	"Acc_harris_swivel",
	"Weap_SVD",
	"Optic_PSO_1",
	"Muzzle_snds_KZRZP_SVD",
	"Muzzle_snds_L",
	"Weap_P07"
];
private _container = [CONT_TYPE_VIRTUAL, objNull, [0, 0, 10, 30]] call AZ_ItemsContainer_fnc_create;
for [{_i=0}, {_i<50}, {_i=_i+1}] do
{
	[_container, [selectRandom _items, 1 + round random 20]] call AZ_ItemsContainer_fnc_addItem;
};
for "_i" from 1 to 8 do 
{
	private _mag =["Mag_30_65x39_caseless", "Ammo_65x39_caseless_tracer", floor (1 + random 30)] call AZ_Item_fnc_Magazine_create;
	[_container, _mag] call AZ_ItemsContainer_fnc_addItem;
};
_display setVariable ["AZ_LeftContainer_Data", _container];
[_display, GEAR_DIALOG_LEFT_CONTAINER_IDC] call AZ_GearDialog_fnc_Container_update;

private _unit = player;
_display setVariable ["unit", _unit];

// Update Gear slots:
private _gearSlotsList = [
	GEAR_SLOT_ID_UNIFORM,
	GEAR_SLOT_ID_VEST,
	GEAR_SLOT_ID_BACKPACK,
	GEAR_SLOT_ID_GOGGLE,
	GEAR_SLOT_ID_NVG,
	GEAR_SLOT_ID_HEADGEAR,
	GEAR_SLOT_ID_WEAPON_PRIMARY,
	GEAR_SLOT_ID_WEAPON_SECONDARY,
	GEAR_SLOT_ID_WEAPON_HANDGUN
	
];
{
	private _params = [_display, _x];
	_params call AZ_GearDialog_fnc_Gear_OnSlotChanged;
	
} forEach _gearSlotsList;



/*
private _camera = "camera" camCreate position player;
_camera cameraEffect ["internal", "BACK"];
_camera camSetTarget ((getPosATL player)vectorAdd [0, 0, 1]);
private _newPos = player getRelPos [2, 0];
_newPos set [2, 1];	
_camera camSetPos _newPos;
_camera camSetFOV 0.6;
//_camera camSetFocus [1.5, 1];
showCinemaBorder false;
_camera camCommit 0;
uiNameSpace setVariable ["AZ_GearDialog_Camera", [_camera, -1, [0,0], 2, 0, 1]];
*/



