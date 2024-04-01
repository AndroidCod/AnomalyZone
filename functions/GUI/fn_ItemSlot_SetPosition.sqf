//AZ_GUI_fnc_ItemSlot_SetPosition

#define TRACE_MODE
#include "..\macros.hpp"

params ["_display", "_slotID", "_pos", "_item"];

if (isNull _display) exitWith {};
//TRACE_1("%1", _pos);

private _ctrl = _display displayCtrl _slotID + 0;
if (isNil '_pos') then 
{
	_pos = (ctrlPosition _ctrl);
}
else
{
	assert(not isNil "_ctrl"); 
	_ctrl ctrlSetPosition _pos;
	_ctrl ctrlCommit 0;
};

(ctrlPosition _ctrl) params ["_rectX", "_rectY",  "_rectW", "_rectH"];
//_pos params ["_rectX", "_rectY",  "_rectW", "_rectH"];
(_display getVariable "GRID") params ["", "", "_GRID_W", "_GRID_H"];
//private _slotH = round (_rectH/_GRID_H);
private _bottom = [_rectX, _rectY + (_rectH - _GRID_H*0.5), _rectW, _GRID_H*0.5];
//TRACE_1("%1", _slotH);
_ctrl = _display displayCtrl _slotID + 3;
assert(not isNil "_ctrl");
_ctrl ctrlSetPosition _bottom;
_ctrl ctrlCommit 0;

_ctrl = _display displayCtrl _slotID + 2;
assert(not isNil "_ctrl");
_ctrl ctrlSetPosition _pos;
_ctrl ctrlCommit 0;

// picture
_ctrl = _display displayCtrl _slotID + 8;
assert(not isNil "_ctrl");

private _fnc_getPictureRect =
{
	params ["_item"];
	private _imageSize = _item get "config" get "pictureRect";
	if (_item get "config" get "type" == ITEM_TYPE_MAGAZINE) then
	{
		if (_item call AZ_Item_fnc_Magazine_isIntegral) then 
		{
			private _ammo = (_item get "ammo");
			private _ammoCount = (_item get "ammoCount");
			if (_ammo isNotEqualTo "" and {_ammoCount > 0}) then 
			{
				private _ammoConfig = _ammo call AZ_Item_fnc_getConfig;
				if (isNil "_ammoConfig") exitWith { ERROR("Ammo Config exists"); };
				_imageSize =  _ammoConfig get "pictureRect";
			};
		};
	};
	_imageSize
};

// calc size to fit by aspect ratio picture
/*private _slotW = round(_rectW/_GRID_W);
private _slotH = round(_rectH/_GRID_H);
//TRACE_1("image size: %1", _imageSize);
if (isNil '_item' or {_slotW == _slotH}) then  
{
	_ctrl ctrlSetPosition _pos;
}
else
{
	private _imageSize = (_item call _fnc_getPictureRect);
	private _rotation = _item get "slotRotation";
	private _imageAspectRatio = if (_rotation == 0) then { ((_imageSize#2) / (_imageSize#3)) } else { ((_imageSize#3) / (_imageSize#2)) }; 
	private _rect = if (_slotW < _slotH) then
	{
		// vertical
		private _h = _rectW * (4/3) / _imageAspectRatio;
		[_rectX, _rectY+((_rectH-_h)/2), _rectW, _h]
	}
	else
	{
		// horizontal
		private _w = _rectH * (3/4) * _imageAspectRatio;
		[_rectX+((_rectW-_w)/2), _rectY, _w, _rectH]
	};
	_ctrl ctrlSetPosition _rect;
};*/
if (isNil '_item') then 
{
	_ctrl ctrlSetPosition _pos;
}
else
{
	(_item call _fnc_getPictureRect) params ["_picX", "_picY", "_picW", "_picH"];
	private _rotation = _item get "slotRotation";
	if (_rotation == 0) then
	{
		private _w = _picW * _GRID_W;
		private _h = _picH * _GRID_H;
		private _orgX = _rectX + _rectW * _picX - _w * 0.5;
		private _orgY = _rectY + _rectH * _picY - _h * 0.5;		
		_ctrl ctrlSetPosition [_orgX, _orgY, _w, _h];
	}
	else
	{
		private _w = _picH * _GRID_W;
		private _h = _picW * _GRID_H;
		private _orgX = _rectX + _rectW * (1-_picY) - _w * (1-0.5);
		private _orgY = _rectY + _rectH * _picX - _h * 0.5;
		_ctrl ctrlSetPosition [_orgX, _orgY, _w, _h];
	};
};
// _ctrl ctrlSetAngle [_rotation, 0.5, 0.5, false]; // !!! NOT WORK WITH NO QUAD IMAGE SIZE
// поэтому мы не используем стиль ST_KEEP_ASPECT_RATIO для контрола и самостоятельно calc ASPECT RATIO fit
_ctrl ctrlCommit 0;


_ctrl = _display displayCtrl _slotID + 9;
assert(not isNil "_ctrl");
_ctrl ctrlSetPosition _pos;
_ctrl ctrlCommit 0;

if (not isNil '_item') then 
{
switch (_item get "config" get "type") do 
{
	case ITEM_TYPE_WEAPON_SECONDARY;
	case ITEM_TYPE_WEAPON_HANDGUN;
	case ITEM_TYPE_WEAPON_PRIMARY:
	{
		private _fnc_rectScaleAt =
		{
			params ["_rect", "_scale", "_itemOffsetX", "_itemOffsetY", "_rotation"];
			//TRACE_1("scale rect %1", _scale);
			if (_scale == 1) exitWith {_rect};
			_rect params ["_rectX", "_rectY", "_rectW", "_rectH"];
			private _ptX = 0;
			private _ptY = 0;
			if (_rotation == 0) then
			{
				_ptX = _rectX + _rectW * _itemOffsetX;
				_ptY = _rectY + _rectH * _itemOffsetY;
			}
			else
			{
				_ptX = _rectX + _rectW * (1-_itemOffsetY);
				_ptY = _rectY + _rectH * _itemOffsetX;
			};
			private _r = _rectX + _rectW;
			private _b = _rectY + _rectH;
			_rectX = _ptX + (_rectX - _ptX) * _scale;
			_rectY = _ptY + (_rectY - _ptY) * _scale;
			_r = _ptX + (_r - _ptX) * _scale;
			_b = _ptY + (_b - _ptY) * _scale;
			_rectW = _r - _rectX;
			_rectH = _b - _rectY;
			_rect set [0, _rectX];
			_rect set [1, _rectY];
			_rect set [2, _rectW];
			_rect set [3, _rectH];
			_rect
			// x y w h
			// if not rot
				// ptX = x + w * offsetX
				// ptY = y + h * offsetY
			// else
				// ptX = h * (1 - offsetY)
				// ptY = w * offsetX
			// r = x + w 
			// b = y + h 
			// x = ptX + (x - ptX) * scale
			// y = ptY + (y - ptY) * scale
			// r = ptX + (r - ptX) * scale
			// b = ptY + (b - ptY) * scale
			// w = r - x
			// h = b - y
		};
		private _fnc_weaponSlotSetPos = 
		{
			params ["_id", "_type"];
			
			private _ctrl = _display displayCtrl (_slotID + _id);
			private _optic = _item get _type;
			if (isNil '_optic') exitWith 
			{
				_ctrl ctrlSetPosition [0, 0, 0, 0];
				_ctrl ctrlCommit 0;
			};
			(_optic get "config" get "pictureRect") params ["", "", "_picW", "_picH"];
			(_optic get "config" get "anchorPoint") params ["_itemOffsetX", "_itemOffsetY", ["_itemScale", 1]];
			(ctrlPosition (_display displayCtrl (_slotID + 8))) params ["_rectX", "_rectY",  "_rectW", "_rectH"];
			
			([_item, _type] call AZ_Item_fnc_Weapon_getOffsetPoint) params ["_offsetX", "_offsetY", ["_scale", 1]];
			
			private _rotation = _item get "slotRotation";
			private _rect = if (_rotation == 0) then
			{
				private _w = _picW * _GRID_W;
				private _h = _picH * _GRID_H;
				[
					_rectX + _offsetX * _rectW - _itemOffsetX * _w,
					_rectY + _offsetY * _rectH - _itemOffsetY * _h,
					_w,
					_h
				]				
			}
			else
			{
				private _w = (_picH * _GRID_W);
				private _h = (_picW * _GRID_H);
				[
					_rectX + _rectW * (1 - _offsetY) - (_w * (1 - _itemOffsetY)),
					_rectY + _rectH * _offsetX - _h * _itemOffsetX,
					_w,
					_h
				]
			};
			_scale = _scale * _itemScale;
			if (_scale != 1) then 
			{
				_rect = [_rect, _scale, _itemOffsetX, _itemOffsetY, _rotation] call _fnc_rectScaleAt;
			};
			_ctrl ctrlSetPosition _rect;
			_ctrl ctrlCommit 0;
		};
		
		[4, ITEM_TYPE_WEAPON_MUZZLE] call _fnc_weaponSlotSetPos;
		[5, ITEM_TYPE_WEAPON_OPTIC] call _fnc_weaponSlotSetPos;
		[6, ITEM_TYPE_WEAPON_POINTER] call _fnc_weaponSlotSetPos;
		[7, ITEM_TYPE_WEAPON_BIPOD] call _fnc_weaponSlotSetPos;
		
		
	};
};
};

ctrlSetFocus (_display displayCtrl _slotID + 2);