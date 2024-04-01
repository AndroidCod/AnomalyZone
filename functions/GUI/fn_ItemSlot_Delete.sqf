// AZ_GUI_fnc_ItemSlot_Delete 

params ["_display", "_slotID"];

if (isNull _display) exitWith {};

ctrlDelete (_display displayCtrl _slotID + 9);
ctrlDelete (_display displayCtrl _slotID + 8);
ctrlDelete (_display displayCtrl _slotID + 7);
ctrlDelete (_display displayCtrl _slotID + 6);
ctrlDelete (_display displayCtrl _slotID + 5);
ctrlDelete (_display displayCtrl _slotID + 4);
ctrlDelete (_display displayCtrl _slotID + 3);
ctrlDelete (_display displayCtrl _slotID + 2);
ctrlDelete (_display displayCtrl _slotID + 1);
ctrlDelete (_display displayCtrl _slotID + 0);



//[_display] call AZ_GearDialog_fnc_checkSlotFocus;
