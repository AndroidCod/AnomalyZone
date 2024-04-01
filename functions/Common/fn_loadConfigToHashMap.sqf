// az_fnc_loadConfigToHashMap 

params ["_cfgClass"];

private _result = createHashMap;
private _props = configProperties [_cfgClass, "true", true];
// note: Hashmaps are case-sensitive so configName cases have to be consistent (e.g. all lowercase)
{
	if (isNumber _x)	then { _result set [configName _x, getNumber _x];	continue; };
	if (isText _x)		then { _result set [configName _x, getText _x];		continue; };
	if (isArray _x)		then { _result set [configName _x, getArray _x];	continue; };
} forEach _props;

private _classes = "true" configClasses _cfgClass;
{
	_result set [configName _x, _x call az_fnc_loadConfigToHashMap];
} forEach _classes;

_result;
