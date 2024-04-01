//


class WeaponUICalibrationDialog
{
 
	idd = 565656;
	movingEnable = 0;
	enableSimulation = 0;
	onLoad = "['onload', _this] call AZ_fnc_Calibrovka";
	
	class ControlsBackground
	{
		class StaticText_Background_Left: azStaticText
		{
			idc = 1;
			colorBackground[] = {0.4,0.4,0.4,1};
			colorText[] = {1,1,1,1};
			shadow = 0;
			text = "";
			x = X(0); // Horizontal coordinates
			y = Y(0); // Vertical coordinates
			w = W(64); // Width
			h = H(36); // Height	
		};		

	};
 
	class Controls
	{
		AZ_SLOT_LEFT_WEAPON(GEAR_SLOT_ID_WEAPON_PRIMARY, 6, 6, 14, 4, 0)
		
		class FrameWeaponPicture : azFrame
		{
			idc = 70;
			x = X(6);
			y = Y(6);
			w = W(14);
			h = H(4);
			colorText[] = {0.8,0.15,0.15,1}; // frame color
			text = "";
		};	
		
		class Muzzle: azStaticTextMulti
		{
			idc = 1000;
			x = X(1);
			y = Y(14);
			w = W(4);
			h = H(1);
			text = "muzzlePoint";
			onMouseButtonDown = "['setItemType', _this] call AZ_fnc_Calibrovka";
		};
		class Pointer: Muzzle
		{
			idc = 1001;
			x = X(1+4+1);
			text = "pointerPoint";
		};
		class Optic: Muzzle
		{
			idc = 1002;
			x = X(1+4+1+4+1);
			text = "opticPoint";
		};
		class Bipod: Muzzle
		{
			idc = 1003;
			x = X(1+4+1+4+1+4+1);
			text = "bipodPoint";
		};
		
		class FrameWeapon : azFrame
		{
			idc = 80;
			x = X(0.5);
			y = Y(16);
			w = W(18);
			h = H(8);
			colorText[] = {0.15,0.15,0.15,1}; // frame color
			text = "Weapon point: %1";
		};		
		class FrameItem : FrameWeapon
		{
			idc = 81;
			x = X(19);
			y = Y(16);
			w = W(18);
			h = H(8);
			text = "Item 'anchorPoint'";
		};
		
		class WeaponOffset_X: azStaticTextMulti
		{
			idc = 100;
			x = X(1);
			y = Y(18);
			w = W(5);
			h = H(1);
			text = "0";
		};	
		class WeaponOffset_Y: WeaponOffset_X
		{
			idc = 101;
			x = X(1);
			y = Y(18+2);
			w = W(5);
			h = H(1);
			text = "0";			
			//onMouseButtonDown = "['slider', _this] call AZ_fnc_screenShot";
		};		
		class WeaponOffset_Scale: WeaponOffset_X
		{
			idc = 102;
			x = X(1);
			y = Y(18+4);
			w = W(5);
			h = H(1);
			text = "1";			
			//onMouseButtonDown = "['slider', _this] call AZ_fnc_screenShot";
		};
		class ItemOffset_X: azStaticTextMulti
		{
			idc = 300;
			x = X(20);
			y = Y(18);
			w = W(5);
			h = H(1);
			text = "0";
		};	
		class ItemOffset_Y: ItemOffset_X
		{
			idc = 301;
			y = Y(18+2);
			text = "0";			
		};	
		class ItemOffset_Scale: ItemOffset_X
		{
			idc = 302;
			y = Y(18+4);
			text = "1";			
		};		
			
		
		
		class slider_WeaponOffset_X : azSlider
		{
			idc = 200;
			x = X(1+6);
			y = Y(18);
			w = W(10);
			h = H(1);
			sliderRange[] = {0,100};
			sliderStep = 1;
			sliderPosition = 0;
			class Value // Link to a control which will show slider value
			{
				idc = 100; // Control IDC (has to be defined ABOVE the slider control)
				format = "%.f"; // Text format, value is represented by variable %g (float) or %.f (integer)
				type = SPTPlain; // Format, can be SPTPlain or SPTPercents (multiplies the value by 100)
				colorBase[] = {1,1,1,1}; // Text color
				colorActive[] = {1,0.5,0,1}; // Text color when the slider is active
			};
			onSliderPosChanged = "['slider', _this] call AZ_fnc_Calibrovka";
		};
		class slider_WeaponOffset_Y : slider_WeaponOffset_X
		{
			idc = 201;
			y = Y(18 + 2);			
			sliderPosition = 0;			
			class Value : Value // Link to a control which will show slider value
			{
				idc = 101; // Control IDC (has to be defined ABOVE the slider control)
			};
		};
		class slider_WeaponOffset_Scale : slider_WeaponOffset_X
		{
			idc = 202;
			y = Y(18 + 4);	
			sliderRange[] = {0,200};			
			sliderPosition = 100;			
			class Value : Value // Link to a control which will show slider value
			{
				idc = 102; // Control IDC (has to be defined ABOVE the slider control)
			};
		};
		
		class slider_ItemOffset_X : slider_WeaponOffset_X
		{
			idc = 400;
			x = X(26);
			y = Y(18);
			w = W(10);
			h = H(1);	
			sliderPosition = 0;			
			class Value : Value // Link to a control which will show slider value
			{
				idc = 300; // Control IDC (has to be defined ABOVE the slider control)
			};
		};		
		class slider_ItemOffset_Y : slider_ItemOffset_X
		{
			idc = 401;
			y = Y(18+2);
			class Value : Value // Link to a control which will show slider value
			{
				idc = 301; // Control IDC (has to be defined ABOVE the slider control)
			};
		};		
		class slider_ItemOffset_S : slider_ItemOffset_X
		{
			idc = 402;
			y = Y(18+4);
			sliderRange[] = {0,200};		
			sliderPosition = 100;		
			class Value : Value // Link to a control which will show slider value
			{
				idc = 302; // Control IDC (has to be defined ABOVE the slider control)
			};
		};
		
		class ExportData : azStaticTextMulti
		{
			idc = 98;
			x = X(1);
			y = Y(26);
			w = W(30);
			h = H(1);
			text = "Export";
		};
		class Export : azStaticTextMulti
		{
			idc = 99;
			x = X(1+30+1);
			y = Y(26);
			w = W(5);
			h = H(1);
			text = "Export";
			
			onMouseButtonDown = "['export', _this] call AZ_fnc_Calibrovka";
		};	

		
		

		
	};

};
