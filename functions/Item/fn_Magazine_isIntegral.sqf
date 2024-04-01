// true = _magazine call AZ_Item_fnc_Magazine_isIntegral

#include "..\macros.hpp"

params ["_magazine"];

private _magConfig = (_magazine get "config");
if (isNil '_magConfig' or { (_magConfig get "type") != ITEM_TYPE_MAGAZINE }) exitWith { ERROR("Invalid params data"); false};

(_magConfig get "isIntegral" != 0)