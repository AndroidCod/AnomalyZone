/****************************************************************************************
	HEAD
	"face_hub": Unit dies at damage equal to or above 1
	"neck": Unit dies at damage equal to or above 1
	"head": Unit dies at damage equal to or above 1
	
	BODY
	"pelvis": Unit dies at damage equal to or above 1
	"spine1": Unit dies at damage equal to or above 1
	"spine2": Unit dies at damage equal to or above 1
	"spine3": Unit dies at damage equal to or above 1
	"body": Unit dies at damage equal to or above 1

	HANDS
	"arms": Unit doesn't die with damage to this part
	"hands": Unit doesn't die with damage to this part
	
	LEGS
	"legs": Unit doesn't die with damage to this part
	
	LEGS - неможем бегать при уроне >=0.5 
	HANDS - чем больше тем больше раскачка оружия
****************************************************************************************/

params ["_unit"];

private _headDamage = 0;
private _bodyDamage = 0;
//private _handDamage = 0;
//private _legsDamage = 0;
private _headSelections = ["face_hub", "neck", "head"];
private _bodySelections = ["pelvis", "spine1", "spine2", "spine3", "body"];

//private _handSelections = ["arms", "hands"];
//private _legsSelections = ["legs"];
{
	_headDamage = (_unit getHit _x) max _headDamage;		
} forEach _headSelections;
//diag_log format ["[%1]call az_fnc_Unit_getDamage: %2", diag_frameno, _headDamage];
{
	_bodyDamage = (_unit getHit _x) max _bodyDamage;		
} forEach _bodySelections;
//diag_log format ["[%1]call az_fnc_Unit_getDamage: %2", diag_frameno, _bodyDamage];
/*
{
	_handDamage = (_unit getHit _x) max _handDamage;		
} forEach _handSelections;
//diag_log format ["[%1]call az_fnc_Unit_getDamage: %2", diag_frameno, _handDamage];
{
	_legsDamage = (_unit getHit _x) max _legsDamage;		
} forEach _legsSelections;
*/
//diag_log format ["[%1]call az_fnc_Unit_getDamage: %2", diag_frameno, _legsDamage];
_headDamage = (_headDamage max _bodyDamage) max ( getDammage _unit );
//diag_log format ["[%1]call az_fnc_Unit_getDamage: %2", diag_frameno, _headDamage];

_headDamage;
