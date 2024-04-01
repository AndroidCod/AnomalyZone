// AZ_Item_fnc_getConfig 

params ["_configName"];
/*params [["_configName", "", ["", createHashMap]]];	
if (typeName _configName == "HASHMAP") then 
{
	_configName = _configName get "configName";
};*/
	
private _cfgItems = missionNamespace getVariable "AZ_CfgItems";
if (isNil "_cfgItems") then 
{
	_cfgItems = createHashMap;
	missionNamespace setVariable ["AZ_CfgItems", _cfgItems];
};

private _itemConfig = _cfgItems get _configName;

if (isNil "_itemConfig") then
{	
	_itemConfig = (missionConfigFile >> "cfgItems" >> _configName) call az_fnc_loadConfigToHashMap;
	// preloads 
	private _preloads = _itemConfig get "preloads";
	if (count _preloads > 0 ) then
	{
		private _armaClass = (configFile >> (_itemConfig get "armaClassParent") >> (_itemConfig get "armaClass"));
		{
			private _data = (_armaClass >> _x) call BIS_fnc_getCfgData;
			if (not isNil "_data") then 
			{
				_itemConfig set [_x, _data];
			};		
			
		} forEach _preloads;
	};
	_itemConfig set ["configName", _configName];
	_cfgItems set [_configName, _itemConfig];
};

_itemConfig
