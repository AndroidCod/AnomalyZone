/**********************************************************************************
	Class Unit
/**********************************************************************************/

#include "..\..\macros.hpp"

params ["_unit"];

private _unitStat = _unit getVariable["AZ_UNITSTAT", nil];
assert (not isNil "_unitStat");
if (isNil "_unitStat") exitWith {diag_log "Log: [AZ] Unit dont initialized!"; nil};

_unitStat




