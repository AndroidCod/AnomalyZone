//


class MyDrink
{
 
	idd = -1;
	movingEnable = 0;
	enableSimulation = 1;
 
	class ControlsBackground
	{
		class StaticText_Background_Left: azStaticText
		{
			idc = 1;
			colorBackground[] = {0.8,0.8,0.8,1};
			colorText[] = {1,1,1,1};
			shadow = 0;
			text = "";
			x = X(0); // Horizontal coordinates
			y = Y(0); // Vertical coordinates
			w = W(10); // Width
			h = H(36); // Height	
		};		
		class StaticText_Background_R1: azStaticText
		{
			idc = 2;
			colorBackground[] = {0.0, 0.75, 0.0, 1};
			colorText[] = {1,1,1,1};
			shadow = 0;
			text = "";
			x = X(10); // Horizontal coordinates
			y = Y(0); // Vertical coordinates
			w = W(18); // Width
			h = H(36); // Height	
		};		
		class StaticText_Background_R2: azStaticText
		{
			idc = 3;
			colorBackground[] = {0.0, 0.75, 0.0, 1};
			colorText[] = {1,1,1,1};
			shadow = 0;
			text = "";
			x = X(30); // Horizontal coordinates
			y = Y(0); // Vertical coordinates
			w = W(18); // Width
			h = H(18); // Height	
		};
		class StaticText_Background_R3: azStaticText
		{
			idc = 4;
			colorBackground[] = {0.0, 0.75, 0.0, 1};
			colorText[] = {1,1,1,1};
			shadow = 0;
			text = "";
			x = X(29); // Horizontal coordinates
			y = Y(19); // Vertical coordinates
			w = W(34); // Width
			h = H(17); // Height	
		};
	};
 
	class Controls
	{
		// direction

		class dirX : azStaticTextMulti
		{
			idc = 100;
			x = X(1);
			y = Y(1);
			w = W(2);
			h = H(2);
			text = "1";
			
			onMouseButtonDown = "['slider', _this] call AZ_fnc_screenShot";
		};		
		class dirY : dirX
		{
			idc = 101;
			x = X(1 + 2 + 0.5);
			text = "0";
		};		
		class dirZ : dirX
		{
			idc = 102;
			x = X(1+2+0.5+2+0.5);
			text = "0";
		};		
		
		class upX : dirX
		{
			idc = 200;
			x = X(1);
			y = Y(1+2+0.5);
			text = "0";
		};		
		class upY : upX
		{
			idc = 201;
			x = X(1+2+0.5);
			text = "0";
		};
		class upZ : upX
		{
			idc = 202;
			x = X(1+2+0.5+2+0.5);
			text = "1";
		};
		
		class slider_dirX : azSlider
		{
			idc = 99;
			x = X(1);
			y = Y(1 + 6);
			w = W(1+2.5*3);
			h = H(1);

			sliderRange[] = {-1,1};
			sliderStep = 0.1;
			sliderPosition = 1;
			
			class Value // Link to a control which will show slider value
			{
				idc = 100; // Control IDC (has to be defined ABOVE the slider control)
				format = "%.g"; // Text format, value is represented by variable %g (float) or %.f (integer)
				type = SPTPlain; // Format, can be SPTPlain or SPTPercents (multiplies the value by 100)
				colorBase[] = {1,1,1,1}; // Text color
				colorActive[] = {1,0.5,0,1}; // Text color when the slider is active
			};

			onSliderPosChanged = "['slider', _this] call AZ_fnc_screenShot";
		};
		class slider_dirY : slider_dirX
		{
			idc = 98;
			y = Y(1 + 6 + 2*1);			
			sliderPosition = 0;
			
			class Value : Value // Link to a control which will show slider value
			{
				idc = 101; // Control IDC (has to be defined ABOVE the slider control)
			};
		};		
		class slider_dirZ : slider_dirX
		{
			idc = 97;
			y = Y(1 + 6 + 2*2);			
			sliderPosition = 0;
			class Value : Value // Link to a control which will show slider value
			{
				idc = 102; // Control IDC (has to be defined ABOVE the slider control)
			};
		};		
		
		class slider_upX : slider_dirX
		{
			idc = 96;
			y = Y(1 + 6 + 2*4);			
			sliderPosition = 0;
			class Value : Value // Link to a control which will show slider value
			{
				idc = 200; // Control IDC (has to be defined ABOVE the slider control)
			};
		};		
		class slider_upY : slider_dirX
		{
			idc = 95;
			y = Y(1 + 6 + 2*5);			
			sliderPosition = 0;
			class Value : Value // Link to a control which will show slider value
			{
				idc = 201; // Control IDC (has to be defined ABOVE the slider control)
			};
		};		
		class slider_upZ : slider_dirX
		{
			idc = 94;
			y = Y(1 + 6 + 2*6);			
			sliderPosition = 1;
			class Value : Value // Link to a control which will show slider value
			{
				idc = 202; // Control IDC (has to be defined ABOVE the slider control)
			};
		};
		
		class Model_Edit : azEdit
		{
			idc = 80; // Control identification (without it, the control won't be displayed)

			x = X(1);
			y = Y(21);
			w = W(1+8);
			h = H(1);

			text = "Model path"; // Displayed text
			sizeEx = H(1); // Text size
			font = GUI_FONT_NORMAL; // Font from CfgFontFamilies
			colorText[] = {0,0,0,1}; // Text and frame color
			colorDisabled[] = {1,1,1,0.5}; // Disabled text and frame color
			colorSelection[] = {1,0.5,0,1}; // Text selection color
		};
		class Model_Apply : azStaticTextMulti
		{
			idc = 81;
			x = X(1);
			y = Y(22);
			w = W(1+8);
			h = H(2);
			text = "Apply model";
			
			onMouseButtonDown = "['apply', _this] call AZ_fnc_screenShot;";
		};	
		// Up
		
		class scale : azStaticTextMulti
		{
			idc = 70;
			x = X(1);
			y = Y(25);
			w = W(2);
			h = H(2);
			text = "1";
			
			//onMouseButtonDown = "";
		};		
		class slider_Scale : azSlider
		{
			idc = 71;
			x = X(1);
			y = Y(27);
			w = W(8);
			h = H(1);

			sliderRange[] = {0.5, 10};
			sliderStep = 0.5;
			sliderPosition = 1;
			
			class Value // Link to a control which will show slider value
			{
				idc = 70; // Control IDC (has to be defined ABOVE the slider control)
				format = "%.g"; // Text format, value is represented by variable %g (float) or %.f (integer)
				type = SPTPlain; // Format, can be SPTPlain or SPTPercents (multiplies the value by 100)
				colorBase[] = {1,1,1,1}; // Text color
				colorActive[] = {1,0.5,0,1}; // Text color when the slider is active
			};

			onSliderPosChanged = "((ctrlParent(_this select 0)) displayCtrl 50) ctrlSetModelScale (_this#1)";
		};
	};
 
	class Objects
	{
 
		class Can
		{
 
			//onObjectMoved = "systemChat str _this";
 
			idc = 50; 
			type = 82;
			//model = "\A3\Structures_F\Items\Food\Can_V3_F.p3d";
			// model = "\rhsafrf\addons\rhs_weapons\grenades\frag_rgd5";
			model = "rhsusf\addons\rhsusf_weapons\magazines\rhs_stanag_mag";
			
			scale = 1;
 
			//direction[] = {0, -0.35, -0.65};
			//up[] = {0, 0.65, -0.35}; 
			direction[] = {1, 0, 0};
			up[] = {0, 1, 0}; 
 
			//position[] = {0,0,0.2}; optional
 
			x = 0.5;
			y = 0.5;
			z = 1;
 
			//positionBack[] = {0,0,1.2}; optional
 
			xBack = 0.5;
			yBack = 0.5;
			zBack = 1.2;
 
			inBack = 1;
			enableZoom = 1;
			zoomDuration = 0.001;
		};
	};
};
