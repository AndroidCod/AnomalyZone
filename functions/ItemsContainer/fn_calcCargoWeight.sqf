// AZ_ItemsContainer_fnc_calcCargoWeight = 

//#include "..\macros.hpp"

params ["_container"];

private _itemsList = _container get "itemsList";
private _w = 0;
{
	//private _id = _x;
	private _item = _y;
	_w = _w + (_item call AZ_Item_fnc_calcWeight);// 
	
} forEach _itemsList;

_container set ["cargoWeight", _w];

_w
