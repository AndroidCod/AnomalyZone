// AZ_Item_fnc_hashSortBy = 
// This function used for BIS_fnc_sortBy
// Compare Items by Group_Type_Height_Width
//format: Group_Type_Height_Width

#define DIGIT 5
#define HASH(n)  (((((n)/(10^DIGIT)) tofixed DIGIT) splitString ".") select 1)

/*private _fnc_formatNumber = 
{
	// 56 --> "00056"
	params ["_number", ["_digit", 5]];	
	//((((abs _number)/(10^_digit)) tofixed _digit)select[2, _digit])
	((((_number/(10^_digit)) tofixed _digit)splitString ".")#1)
};*/

private _item = (_input0 get _x);
private _itemConfig = _item get "config";
(_item call AZ_Item_fnc_getSlotSize) params ["_slotSizeW", "_slotSizeH"];
private _s = [];
_s pushBack HASH(_itemConfig get "group");
_s pushBack HASH(_itemConfig get "type");
_s pushBack HASH(_slotSizeH);
_s pushBack HASH(_slotSizeW);

_s joinString "_" // --> "00001_00021_00520_00052"	 
