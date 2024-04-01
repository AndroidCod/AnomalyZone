/*class azCameraControl : azStaticTextMulti
{
	style = ST_LEFT + ST_MULTI; // Style
	colorBackground[] = {0,0,0,0}; // Fill color
	text = "";
	onMouseButtonDown = "_this call AZ_GearDialog_fnc_controlCamera_OnMouseDown";
	onMouseMoving = "_this call AZ_GearDialog_fnc_controlCamera_OnMouseMoving";
	onMouseButtonUp = "_this call AZ_GearDialog_fnc_controlCamera_OnMouseUp";
	//onMouseEnter = "_this call AZ_GUI_fnc_controlOnMouseEnter";
	onMouseZChanged = "_this call AZ_GearDialog_fnc_controlCamera_onMouseZChanged";
};*/

#define AZ_SLOT(id, orgX, orgY, width, height, pad) \
	class Slot_##id##_09 : azStaticText { \
		idc = id + 9; \
		x = X(orgX + pad); \
		y = Y(orgY + pad); \
		w = W(width - pad); \
		h = H(height - pad); \
		text = ""; }; \
	class Slot_##id##_08 : azPicture { \
		idc = id + 8; \
		x = X(orgX + pad); \
		y = Y(orgY + pad); \
		w = W(width - pad); \
		h = H(height - pad); \
		text = ""; }; \
	class Slot_##id##_03 : azStructuredText_Slot { \
		idc = id + 3; \
		x = X(orgX + pad); \
		y = Y(((orgY + (height - 1)))); \
		w = W(width - pad); \
		h = H(1); \
		text = ""; }; \
	class Slot_##id##_02 : azStructuredText_Slot { \
		idc = id + 2; \
		x = X(orgX + pad); \
		y = Y(orgY + pad); \
		w = W(width - pad); \
		h = H(height - pad); \
		text = ""; }; \
	class Slot_##id##_01 : azFrame { \
		idc = id + 0; \
		x = X(orgX + pad); \
		y = Y(orgY + pad); \
		w = W(width - pad); \
		h = H(height - pad); \
		text = ""; };

#define AZ_SLOT_WEAPON(id, orgX, orgY, width, height, pad) AZ_SLOT(id, orgX, orgY, width, height, pad) \
	class Slot_##id##_04 : azPicture { \
		idc = id + 4; \
		x = X(orgX + pad); \
		y = Y(orgY + pad); \
		w = W(width - pad); \
		h = H(height - pad); \
		text = ""; }; \
	class Slot_##id##_05 : azPicture { \
		idc = id + 5; \
		x = X(orgX + pad); \
		y = Y(orgY + pad); \
		w = W(width - pad); \
		h = H(height - pad); \
		text = ""; };\
	class Slot_##id##_06 : azPicture { \
		idc = id + 6; \
		x = X(orgX + pad); \
		y = Y(orgY + pad); \
		w = W(width - pad); \
		h = H(height - pad); \
		text = ""; };\
	class Slot_##id##_07 : azPicture { \
		idc = id + 7; \
		x = X(orgX + pad); \
		y = Y(orgY + pad); \
		w = W(width - pad); \
		h = H(height - pad); \
		text = ""; };

/*
	class Slot_##id##_00 : azDragAndDrop { \
		idc = id; \
		x = X(orgX + pad); \
		y = Y(orgY + pad); \
		w = W(width - pad); \
		h = H(height - pad); \
		text = ""; };
*/

#define AZ_SLOT_LEFT_WEAPON(id, orgX, orgY, width, height, pad) 	AZ_SLOT_WEAPON(id, (0.5 + (orgX)), (1 + (orgY)), width, height, pad)
#define AZ_SLOT_LEFT(id, orgX, orgY, width, height, pad) 	AZ_SLOT(id, (0.5 + (orgX)), (1 + (orgY)), width, height, pad)
#define AZ_SLOT_CENTER(id, orgX, orgY, width, height, pad) 	AZ_SLOT(id, (22.5 + (orgX)), (1 + (orgY)), width, height, pad)
#define AZ_SLOT_RIGHT(id, orgX, orgY, width, height, pad) 	AZ_SLOT(id, (41 + (orgX)), (1 + (orgY)), width, height, pad)

#define AZ_SLOT_GEAR(id, orgX, orgY, width, height) 	AZ_SLOT_LEFT(id, orgX, orgY, width, height, GEAR_SLOT_PAD)
#define AZ_SLOT_GEAR_WEAPON(id, orgX, orgY, width, height) 	AZ_SLOT_LEFT_WEAPON(id, orgX, orgY, width, height, GEAR_SLOT_PAD)


class azStructuredText_Slot : azStructuredText
{
	colorBackground[] = {0,0,0,0}; // Fill color
	text = ""; // Displayed text
	size = 1 * AZ_GUI_GRID_H; // Text size 
	shadow = 2; // 2 - outline
	class Attributes
	{
		align = "left"; // Text align
		//valign = "middle"; // !!! broken
		color = "#C0C0C0"; // Text color
		colorLink = "#D09B43";
		size = 1; // Text size
		font = GUI_FONT_NORMAL; // Font from CfgFontFamilies
		shadow = 2; //<t shadow='0'>Text with no shadow</t> <t shadow='1'>Text with default black shadow</t><t shadow='2'>Text with default black outline</t>
		shadowColor = "#000000";
		shadowOffset = 0.1;
	};
};

class ControlsGroup_Container : azControlsGroup_NoScroll_W
{
	idc = 0;
	x = 0; // Horizontal coordinates
	y = 0; // Vertical coordinates
	w = 1; // Width
	h = 1; // Height		
	class Controls
	{
	};
};
class ControlsGroup_Container_Uniform : azControlsGroup_NoScroll
{

};

class ControlsGroup_Container_BackGround : azStaticText
{
	idc = 0;
	colorBackground[] = {0.07,0.07,0.07,0.9};		
	colorText[] = {1,1,1,1}; // Text color			
	shadow = 0;
	text = "";
	x = 0; // Horizontal coordinates
	y = 0; // Vertical coordinates
	w = 1; // Width
	h = 1; // Height
};
class ControlsGroup_Container_Frame : azFrame
{
	idc = 0;
	colorBackground[] = {0.07,0.7,0.07,0.9};		
	colorText[] = {0.5,0.5,0.5,1}; // Text color			
	shadow = 0;
	font = GUI_FONT_NORMAL;
	sizeEx = GUI_GRID_CENTER_H;
	text = "";
	x = 0; // Horizontal coordinates
	y = 0; // Vertical coordinates
	w = 1; // Width
	h = 1; // Height
};

class azGearDialog
{
	idd = GEAR_DIALOG_IDD;
	access = 0;
	movingEnable = 0;
	enableSimulation = 1;
    onLoad = "_this call AZ_GearDialog_fnc_OnLoad";
	onUnload = "_this call AZ_GearDialog_fnc_OnUnLoad";
	onMouseMoving = "_this call AZ_GearDialog_fnc_OnMouseMoving"; 
	onMouseButtonDown = "_this call AZ_GearDialog_fnc_OnMouseDown";
	onMouseButtonUp = "_this call AZ_GearDialog_fnc_OnMouseUp";
	//onMouseZChanged = "_this call AZ_GearDialog_fnc_OnMouseZChanged";
	
	class ControlsBackground
	{
		class StaticText_Background_Left: azStaticText
		{
			idc = 50;
			colorBackground[] = {0.01,0.01,0.01,0.8};
			colorText[] = {1,1,1,1};
			shadow = 0;
			text = "";
			x = LEFT_X(0); // Horizontal coordinates
			y = LEFT_Y(0); // Vertical coordinates
			w = W(40); // Width
			h = H(34); // Height	
		};
		/*class StaticText_ItemsBackground_Left : azStaticText
		{
			idc = 51;
			colorBackground[] = {0.07,0.07,0.07,0.9};		
			colorText[] = {1,1,1,1}; // Text color			
			shadow = 0;
			text = "";
			x = LEFT_X(0.5); // Horizontal coordinates
			y = LEFT_Y(2); // Vertical coordinates
			w = W(20); // Width
			h = H(30); // Height	
		};*/
/*
		class StaticText_Background_Center: StaticText_Background_Left
		{
			idc = 60;	
			x = CENTER_X(0); // Horizontal coordinates
			y = CENTER_Y(0); // Vertical coordinates
			w = W(19); // Width
			h = H(34); // Height
		};*/
		/*class PocketCell_0_0 : StaticText_ItemsBackground_Left
		{
			idc = 61;
			x = CENTER_X(2 + GEAR_SLOT_PAD); // Horizontal coordinates
			y = CENTER_Y(14 + GEAR_SLOT_PAD); // Vertical coordinates
			w = W(3 - GEAR_SLOT_PAD); // Width
			h = H(3 - GEAR_SLOT_PAD); // Height	
		};*/
		/*class StaticText_Pockets_Uniform : azStaticText
		{
			idc = 61;
			colorBackground[] = {0.07,0.07,0.07,0.9};		
			colorText[] = {1,1,1,1}; // Text color			
			shadow = 0;
			text = "";
			x = CENTER_X(2); // Horizontal coordinates
			y = CENTER_Y(14); // Vertical coordinates
			w = W(4); // Width
			h = H(8); // Height	
		};		
		class StaticText_Pockets_Vest : StaticText_Pockets_Uniform
		{
			idc = 62;
			x = CENTER_X(2+4+0.5); // Horizontal coordinates0
			y = CENTER_Y(14); // Vertical coordinates
			w = W(8); // Width
			h = H(8); // Height	
		};		
		class StaticText_Pockets_Backpack : StaticText_Pockets_Uniform
		{
			idc = 63;
			x = CENTER_X(2+4+0.5+8+0.5); // Horizontal coordinates
			y = CENTER_Y(14); // Vertical coordinates
			w = W(2); // Width
			h = H(8); // Height	
		};
		*/
		class StaticText_Background_Rigth: StaticText_Background_Left
		{
			idc = 70;
			x = RIGHT_X(0); // Horizontal coordinates
			y = RIGHT_Y(0); // Vertical coordinates
			w = W(22.5); // Width
			h = H(34); // Height
		};
		/*class StaticText_ItemsBackground_Right : StaticText_ItemsBackground_Left
		{
			idc = 71;
			x = RIGHT_X(1.5); // Horizontal coordinates
			y = RIGHT_Y(2); // Vertical coordinates
			w = W(20); // Width
			h = H(30); // Height	
		};*/
		
		
	};
	class Controls
	{
		// LEFT 
		class ControlsGroup_LeftContainer : ControlsGroup_Container
		{
			idc = GEAR_DIALOG_LEFT_CONTAINER_IDC;
			x = RIGHT_X(1); // Horizontal coordinates
			y = RIGHT_Y(2); // Vertical coordinates
			w = W(20.5+0.05); // Width
			h = H(30+0.05); // Height		
			class Controls
			{
				class ControlsGroup_LeftContainer_BackGround : ControlsGroup_Container_BackGround
				{
					idc = GEAR_DIALOG_LEFT_CONTAINER_IDC + 1;
				};
				class ControlsGroup_Container_Frame_Left : ControlsGroup_Container_Frame
				{
					idc = GEAR_DIALOG_LEFT_CONTAINER_IDC + 2;
				};
			};
		};
		
		// Uniform pockets
		class ControlsGroup_UniformContainer : ControlsGroup_Container_Uniform
		{
			idc = GEAR_DIALOG_UNIFORM_CONTAINER_IDC;
			x = LEFT_X(19); // Horizontal coordinates
			y = LEFT_Y(2); // Vertical coordinates
			w = W(4.5+0.05); // Width
			h = H(8+0.05); // Height			
			class Controls
			{
				class ControlsGroup_UniformContainer_BackGround : ControlsGroup_Container_BackGround
				{
					idc = GEAR_DIALOG_UNIFORM_CONTAINER_IDC + 1;
				};	
				class ControlsGroup_Container_Frame_Uniform : ControlsGroup_Container_Frame
				{
					idc = GEAR_DIALOG_UNIFORM_CONTAINER_IDC + 2;
				};
			};
		};

		// Vest pockets
		class ControlsGroup_VestContainer : ControlsGroup_Container_Uniform
		{
			idc = GEAR_DIALOG_VEST_CONTAINER_IDC;
			x = LEFT_X(19 + 6); // Horizontal coordinates
			y = LEFT_Y(2); // Vertical coordinates
			w = W(14.5+0.05); // Width
			h = H(8+0.05); // Height			
			class Controls
			{
				class ControlsGroup_VestContainer_BackGround : ControlsGroup_Container_BackGround
				{
					idc = GEAR_DIALOG_VEST_CONTAINER_IDC + 1;
				};	
				class ControlsGroup_Container_Frame_Vest : ControlsGroup_Container_Frame
				{
					idc = GEAR_DIALOG_VEST_CONTAINER_IDC + 2;
				};
				
			};
		};		
		
		// Backpack
		class ControlsGroup_BackpackContainer : ControlsGroup_Container_Uniform
		{
			idc = GEAR_DIALOG_BACKPACK_CONTAINER_IDC;
			x = LEFT_X(19); // Horizontal coordinates
			y = LEFT_Y(2+10); // Vertical coordinates
			w = W(20.5+0.05); // Width
			h = H(20+0.05); // Height			
			class Controls
			{
				class ControlsGroup_RightContainer_BackGround : ControlsGroup_Container_BackGround
				{
					idc = GEAR_DIALOG_BACKPACK_CONTAINER_IDC + 1;
				};	
				class ControlsGroup_Container_Frame_Backpack : ControlsGroup_Container_Frame
				{
					idc = GEAR_DIALOG_BACKPACK_CONTAINER_IDC + 2;
				};
			};
		};
		
		// Belt
		//...
		
		// GEAR 
		// head slots
		AZ_SLOT_GEAR(GEAR_SLOT_ID_NVG, 2, 2, 5, 5)
		AZ_SLOT_GEAR(GEAR_SLOT_ID_HEADGEAR, 7, 2, 5, 5)
		AZ_SLOT_GEAR(GEAR_SLOT_ID_GOGGLE, 12, 2, 5, 5)
		
		// body slots
		AZ_SLOT_GEAR(GEAR_SLOT_ID_UNIFORM, 2, 7, 5, 7)
		AZ_SLOT_GEAR(GEAR_SLOT_ID_VEST, 7, 7, 5, 7)
		AZ_SLOT_GEAR(GEAR_SLOT_ID_BACKPACK, 12, 7, 5, 7)
		
		// Weapon primary
		AZ_SLOT_LEFT_WEAPON(GEAR_SLOT_ID_WEAPON_PRIMARY, 2, 18, 15, 4, 0)
		// AZ_SLOT_GEAR_WEAPON(GEAR_SLOT_ID_WEAPON_PRIMARY, 2, 18, 10, 4)
		AZ_SLOT_GEAR(GEAR_SLOT_ID_WEAPON_PRIMARY_MAG_0, 2+10+1+2, 18, 2, 4)
		AZ_SLOT_GEAR(GEAR_SLOT_ID_WEAPON_PRIMARY_MAG_1, 2+10+1, 18, 2, 4)
		
		// Weapon secondary
		//AZ_SLOT_GEAR_WEAPON(GEAR_SLOT_ID_WEAPON_SECONDARY, 2, (18+4+1), 10, 4)
		AZ_SLOT_LEFT_WEAPON(GEAR_SLOT_ID_WEAPON_SECONDARY, 2, (18+4+1), 11, 4, 0)
		
		// Weapon Handgun
		// AZ_SLOT_GEAR_WEAPON(GEAR_SLOT_ID_WEAPON_HANDGUN, 2+10+1, (18+4+1), 4, 4)
		AZ_SLOT_LEFT_WEAPON(GEAR_SLOT_ID_WEAPON_HANDGUN, 2+10+1, 18+4+1, 4, 4, 0)
		
		/*
		class azCameraControl_Center : azCameraControl
		{
			idc = 50;
			x = 21 * AZ_GUI_GRID_W + AZ_GUI_GRID_X; // Horizontal coordinates
			y = 1 * AZ_GUI_GRID_H + AZ_GUI_GRID_Y; // Vertical coordinates
			w = 22 * AZ_GUI_GRID_W; // Width
			h = 34 * AZ_GUI_GRID_H; // Height
		};
		*/
	};
	/*class Objects
	{
		//Objects
	};*/
};

