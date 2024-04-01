
#include "..\macros.hpp"

disableSerialization;

//AZ_HUD_EnemyStatus_Layer = ;
private _layerID = uiNameSpace getVariable ["AZ_HUD_EnemyStatus_LayerID", -1];
if (_layerID < 0) then
{
	_layerID = ("AZ_HUD_EnemyStatus_LayerID" call BIS_fnc_rscLayer);
	uiNameSpace setVariable ["AZ_HUD_EnemyStatus_LayerID", _layerID];
};

params ["_unit"];

if (isNull _unit) exitWith { _layerID cutFadeOut 0; };

private _unitStat = _unit getVariable ["AZ_UnitStat", nil];
if (isNil "_unitStat") exitWith { _layerID cutFadeOut 0; };


_layerID cutRsc ["AZ_HUD_EnemyStatus", "PLAIN", -1, false]; //show			
//waitUntil {!isNull (uiNameSpace getVariable "AZ_HUD_EnemyStatus")};
private _display = uiNameSpace getVariable "AZ_HUD_EnemyStatus";

// ------------- Update HP... 
private _hp = _unitStat get "hp";

//private _pos = getPosATL _unit;
private _pos = ASLToATL eyePos _unit;

private _v = (ASLToATL eyePos player) vectorFromTo _pos;
_v = [-(_v#1), (_v#0), 0]; // Ort vector [-y, x]
_v = _v vectorMultiply 1.2;
_v = _pos vectorAdd _v;
_v = (worldToScreen _v);	
if (count _v == 0) exitWith { _layerID cutFadeOut 0; };

_pos set [2, ((_pos#2) + 0.5)];	
_pos = (worldToScreen _pos);	
if (count _pos == 0) exitWith { _layerID cutFadeOut 0; };

private _w = (1 * GUI_GRID_W) max (abs( _pos#0 - _v#0 ));

_pos = [((_pos#0) - (0.5 * _w)), _pos#1, _w, 0.12 * GUI_GRID_H];

///
private _ctrl = _display displayCtrl 1000;
_ctrl ctrlSetPosition _pos;
_ctrl ctrlCommit 0;

/// 
_ctrl = _display displayCtrl 1001;
_ctrl ctrlSetPosition _pos;
_ctrl progressSetPosition (1 - (getDammage _unit));
_ctrl ctrlCommit 0;

/*
_ctrl = _display displayCtrl 1002;
_ctrl ctrlSetText format ["%1/%2", round ((1 - (getDammage _unit)) * (_hp#1)), round (_hp#1)];
_ctrl ctrlSetPosition [_pos#0, _pos#1, _w, 1 * GUI_GRID_H];
_ctrl ctrlCommit 0;*/
