// az_fnc_Mutant_BlindDog_AoEHit

params ["_unit", "_attackData"];

// _attackData - HashMap, preloaded config

player sideChat format['[%1] AoE hit in range=%2', _unit, _attackData get "range"];