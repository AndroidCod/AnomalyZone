// AZ_fnc_posInRect = 

params ["_pos", "_rect"];

((_pos#0) > (_rect#0) and {(_pos#0) < ((_rect#0) + (_rect#2)) and {(_pos#1) > (_rect#1) and {(_pos#1) < ((_rect#1) + (_rect#3))}}})
