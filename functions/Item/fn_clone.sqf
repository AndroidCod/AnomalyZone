// AZ_Item_fnc_clone = 

private _item = _this;

private _itemConfig = _item get "config";
private _configName = _itemConfig get "configName";
private _clone = [_configName, (_item get "amount")] call AZ_Item_fnc_create;

switch (_itemConfig get "type") do
{
	case ITEM_TYPE_MAGAZINE: 
	{
		_clone set ["ammoCount", (_item get "ammoCount")];
		_clone set ["ammo", (_item get "ammo")];
	};
	case ITEM_TYPE_AMMO;
	default {};		
};

_clone
