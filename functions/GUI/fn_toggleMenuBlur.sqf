params ["_mode"];

//player globalChat format ["[%1] toggleMenuBlur = %2", diag_frameno, _mode];

if (_mode > 0) then
{
	if (isNil "AZ_GearDialogBlur") then 
	{
		AZ_GearDialogBlur = ppEffectCreate ["DynamicBlur", 999];
		AZ_GearDialogBlur ppEffectEnable true;
	};

    AZ_GearDialogBlur ppEffectAdjust [8];
	AZ_GearDialogBlur ppEffectCommit 0.2;
}
else
{
	AZ_GearDialogBlur ppEffectAdjust [0];
	AZ_GearDialogBlur ppEffectCommit 0.3;
	//AZ_GearDialogBlur ppEffectEnable false;
	//ppEffectDestroy AZ_GearDialogBlur;
};


/*
["DynamicBlur", 400, [10]] spawn
{
	params ["_name", "_priority", "_effect", "_handle"];
	while {
		_handle = ppEffectCreate [_name, _priority];
		_handle < 0
	} do {
		_priority = _priority + 1;
	};
	_handle ppEffectEnable true;
	_handle ppEffectAdjust _effect;
	_handle ppEffectCommit 5;
	waitUntil { ppEffectCommitted _handle };
	systemChat "admire effect for a sec";
	uiSleep 3;
	_handle ppEffectEnable false;
	ppEffectDestroy _handle;
};
*/