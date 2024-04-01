// AZ_ItemsContainer_fnc_create = 

params ["_type", "_object", "_mapRect", ["_capacity", 0], ["_access", 0]];

private _container = _mapRect call AZ_GUI_fnc_IMap_create;

_container set ["type", _type]; 
_container set ["armaObject", _object];
_container set ["access", _access]; // access (0 - ReadAndWrite, 1 - ReadOnly)
_container set ["capacity", _capacity]; // 0 - means no limit
_container set ["cargoWeight", 0];
_container set ["itemsList", createHashMap]; // map of items where keyValue its NUMBER slot idc: 10, 20, 30... 
_container set ["freeIDList", []];
_container set ["IDCounter", 0];
_container set ["isPockets", false];


_container
