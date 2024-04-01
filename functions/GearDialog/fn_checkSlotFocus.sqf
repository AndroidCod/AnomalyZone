// [_display] call AZ_GearDialog_fnc_checkSlotFocus

params ["_display"];
//params ["_ctrl"];

private _ctrl = focusedCtrl _display;

//player globalChat format ['focused [%1]', _ctrl]; 

private _foc = ctrlIDC _ctrl;
//if ((_foc mod 10) > 0) then 
//{
	//ctrlSetFocus controlNull;
	_foc = floor (_foc / 10) * 10; 
	private _display = ctrlParent _ctrl;
	ctrlSetFocus (_display displayCtrl _foc);
//};