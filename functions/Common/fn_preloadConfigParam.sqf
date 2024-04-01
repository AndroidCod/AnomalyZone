//AZ_fnc_preloadConfigParam

params ["_configParent", ["_parameter", "", [""]], ["_parameterValue", "", [""]]]; // configEntry or filePath

if (_parameterValue isEqualTo "" or {_parameter isEqualTo ""}) exitWith { _parameterValue };

//player sidechat format ["%1 = %2", _parameter, _parameterValue];

private _config = (_configParent >> _parameterValue);
if (_config call BIS_fnc_getCfgIsClass) then 
{
	private _data = (_config >> _parameter) call BIS_fnc_getCfgData;
	if (not isNil "_data") then 
	{
		_parameterValue = _data;
	};
};

_parameterValue
