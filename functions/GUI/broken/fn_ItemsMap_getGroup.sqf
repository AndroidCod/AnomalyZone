// [_ItemsMap, _groupID] call AZ_GUI_fnc_ItemsMap_getGroup;

//#define TRACE_MODE
#include "..\macros.hpp"

params ["_ItemsMap", "_groupID"];

private _groupsList = (_ItemsMap get "groupsList");
private _group = _groupsList get _groupID;
if (isNil "_group") exitWith { ERROR("Group exist in ItemsMap"); };

_group

