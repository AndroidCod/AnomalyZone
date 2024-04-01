class azStaticText
{
	access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
	idc = CT_STATIC; // Control identification (without it, the control won't be displayed)
	type = CT_STATIC; // Type
	style = ST_LEFT; // Style
	default = 0; // Control selected by default (only one within a display can be used)
	blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.

	x = 0 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X; // Horizontal coordinates
	y = 0 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y; // Vertical coordinates
	w = 1 * GUI_GRID_CENTER_W; // Width
	h = 1 * GUI_GRID_CENTER_H; // Height

	colorBackground[] = {0.2,0.2,0.2,1}; // Fill color

	text = ""; // Displayed text
	sizeEx = GUI_GRID_CENTER_H; // Text size
	font = GUI_FONT_NORMAL; // Font from CfgFontFamilies
	shadow = 1; // Shadow (0 - none, 1 - directional, color affected by colorShadow, 2 - black outline)
	lineSpacing = 1; // When ST_MULTI style is used, this defines distance between lines (1 is text height)
	fixedWidth = 0; // 1 (true) to enable monospace
	colorText[] = {1,1,1,1}; // Text color
	colorShadow[] = {0,0,0,0.5}; // Text shadow color (used only when shadow is 1)

	tooltip = ""; // Tooltip text
	tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
	tooltipColorText[] = {1,1,1,1}; // Tooltip text color
	tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color

	moving = 0; // 1 (true) to allow dragging the whole display by the control

	autoplay = 0; // Play video automatically (only for style ST_PICTURE with text pointing to an .ogv file)
	loops = 0; // Number of video repeats (only for style ST_PICTURE with text pointing to an .ogv file)

	tileW = 1; // Number of tiles horizontally (only for style ST_TILE_PICTURE)
	tileH = 1; // Number of tiles vertically (only for style ST_TILE_PICTURE)

	deletable = 0;

	// onCanDestroy = "systemChat str ['onCanDestroy',_this]; true";
	// onDestroy = "systemChat str ['onDestroy',_this]; false";
	// onMouseEnter = "systemChat str ['onMouseEnter',_this]; false";
	// onMouseExit = "systemChat str ['onMouseExit',_this]; false";
	// onSetFocus = "systemChat str ['onSetFocus',_this]; false";
	// onKillFocus = "systemChat str ['onKillFocus',_this]; false";
	// onKeyDown = "systemChat str ['onKeyDown',_this]; false";
	// onKeyUp = "systemChat str ['onKeyUp',_this]; false";
	// onMouseButtonDown = "systemChat str ['onMouseButtonDown',_this]; false";
	// onMouseButtonUp = "systemChat str ['onMouseButtonUp',_this]; false";
	// onMouseButtonClick = "systemChat str ['onMouseButtonClick',_this]; false";
	// onMouseButtonDblClick = "systemChat str ['onMouseButtonDblClick',_this]; false";
	// onMouseZChanged = "systemChat str ['onMouseZChanged',_this]; false";
	// onMouseMoving = "";
	// onMouseHolding = "";
	//onVideoStopped = "systemChat str ['onVideoStopped',_this]; false";
};
class azStaticTextMulti : azStaticText
{
	style = ST_LEFT + ST_MULTI; // Style
};
class azDragAndDrop : azStaticTextMulti
{
	style = ST_LEFT + ST_MULTI; // Style
	colorBackground[] = {0,0,0,0}; // Fill color
	text = "";
	//onMouseButtonDown = "_this call AZ_GUI_fnc_controlOnMouseDown";
	//onMouseMoving = "_this call AZ_GUI_fnc_controlOnMouseMove";
	//onMouseButtonUp = "_this call AZ_GUI_fnc_controlOnMouseUp";
	//onMouseEnter = "_this call AZ_GUI_fnc_controlOnMouseEnter";
	//onMouseExit = "_this call AZ_GUI_fnc_controlOnMouseExit";
	//onSetFocus = "_this call AZ_GearDialog_fnc_checkSlotFocus";
};


class azPicture : azStaticText
{
	style = ST_LEFT + ST_PICTURE;
	text = ""; // texture path
	shadow=0;
	colorText[]={1,1,1,1};
	// angle = 90;
};
class azPicture90 : azPicture
{
	angle = 90;
};
class azPictureKeepAspect: azPicture
{
	style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
	// style="0x30 + 0x800";
	// onSetFocus = "_this call AZ_GearDialog_fnc_checkSlotFocus";
	// angle = 90;
};
class azPictureKeepAspect90: azPictureKeepAspect
{
	angle = 90;
};
class azPictureAllowPixelSplit: azPicture
{
	pixelPrecise=0;
};
class azPictureKeepAspectAllowPixelSplit: azPictureAllowPixelSplit
{
	style="0x30 + 0x800";
};
class azPictureTile : azPicture
{
	style = ST_LEFT + ST_TILE_PICTURE;	
	tileW = 1; // Number of tiles horizontally (only for style ST_TILE_PICTURE)
	tileH = 1; // Number of tiles vertically (only for style ST_TILE_PICTURE)
};
class azFrame : azStaticText
{
	type = CT_STATIC;
	style = ST_FRAME;
	shadow = 0;
	colorText[] = {0.5,0.5,0.5,1}; // frame color
	font = GUI_FONT_NORMAL;
	sizeEx = GUI_GRID_CENTER_H;
	text = "";
	//onSetFocus = "_this call AZ_GearDialog_fnc_checkSlotFocus";
};

class azProgressBar
{
	access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
	idc = CT_PROGRESS; // Control identification (without it, the control won't be displayed)
	type = CT_PROGRESS; // Type
	style = ST_HORIZONTAL; // Style
	default = 0; // Control selected by default (only one within a display can be used)
	blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.

	x = 0 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X; // Horizontal coordinates
	y = 0 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y; // Vertical coordinates
	w = 1 * GUI_GRID_CENTER_W; // Width
	h = 1 * GUI_GRID_CENTER_H; // Height

	texture = "#(argb,8,8,3)color(1,1,1,1)"; // Bar texture
	colorBar[] = {1,1,1,1}; // Bar color
	colorFrame[] = {0,0,0,1}; // Frame color

	tooltip = ""; // Tooltip text
	tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
	tooltipColorText[] = {1,1,1,1}; // Tooltip text color
	tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color

	//onCanDestroy = "systemChat str ['onCanDestroy',_this]; true";
	//onDestroy = "systemChat str ['onDestroy',_this]; false";
};

class azStructuredText
{
	access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
	idc = CT_STRUCTURED_TEXT; // Control identification (without it, the control won't be displayed)
	type = CT_STRUCTURED_TEXT; // Type
	style = ST_LEFT; // Style
	default = 0; // Control selected by default (only one within a display can be used)
	blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.

	x = 0 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X; // Horizontal coordinates
	y = 0 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y; // Vertical coordinates
	w = 1 * GUI_GRID_CENTER_W; // Width
	h = 1 * GUI_GRID_CENTER_H; // Height

	colorBackground[] = {0,0,0,0}; // Fill color
	colorText[] = {1,1,1,1};
	
	text = ""; // Displayed text
	size = GUI_GRID_CENTER_H; // Text size

	tooltip = ""; // Tooltip text
	tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
	tooltipColorText[] = {1,1,1,1}; // Tooltip text color
	tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color
	shadow = 1;
	colorShadow[] = {0,0,0,1}; // Text shadow color (used only when shadow is 1)
	class Attributes
	{
		align = "left"; // Text align
		valign = "middle"; // !!! broken
		color = "#ffffff"; // Text color
		colorLink = "#D09B43";
		size = 1; // Text size
		font = GUI_FONT_NORMAL; // Font from CfgFontFamilies
		shadow = 2; //<t shadow='0'>Text with no shadow</t> <t shadow='1'>Text with default black shadow</t><t shadow='2'>Text with default black outline</t>
		shadowColor = "#000000";
		shadowOffset = 0.5;
	};
	//onCanDestroy = "systemChat str ['onCanDestroy',_this]; true";
	//onDestroy = "systemChat str ['onDestroy',_this]; false";
	//onSetFocus = "_this call AZ_GearDialog_fnc_checkSlotFocus";
};

class azControlsGroup
{
	access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
	idc = CT_CONTROLS_GROUP; // Control identification (without it, the control won't be displayed)
	type = CT_CONTROLS_GROUP; // Type
	style = ST_MULTI; // Style
	blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.

	x = 0 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X; // Horizontal coordinates
	y = 0 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y; // Vertical coordinates
	w = 1 * GUI_GRID_CENTER_W; // Width
	h = 1 * GUI_GRID_CENTER_H; // Height

	class Controls
	{
	};
	// Scrollbar configuration (applied only when LB_TEXTURES style is used)
	class VScrollBar
	{
		width = 0.5 * GUI_GRID_W; // set to 0 for disable
		height = 0; // Unknown?
		scrollSpeed = 0.06; // Unknown?

		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)

		color[] = {1,1,1,1}; // Scrollbar color

		autoScrollEnabled = 0; // 1 to enable automatic scrolling
		autoScrollDelay = 0; // Time after autoscroll is initiated
		autoScrollRewind = 0; // Repeat the autoscroll once it's finished
		autoScrollSpeed = 0; // Autoscroll speed
	};
	class HScrollBar
	{
		width = 0; // Unknown?
		height = 0.5 * GUI_GRID_H; // set to 0 for disable
		scrollSpeed = 0.06; // Unknown?

		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)

		color[] = {1,1,1,1}; // Scrollbar color
	};

	// onCanDestroy = "systemChat str ['onCanDestroy',_this]; true";
	// onDestroy = "systemChat str ['onDestroy',_this]; false";
	// onMouseButtonDown = "systemChat str ['onMouseButtonDown',_this]; false";
	// onMouseButtonUp = "systemChat str ['onMouseButtonUp',_this]; false";
	// onMouseButtonClick = "systemChat str ['onMouseButtonClick',_this]; false";
	// onMouseButtonDblClick = "systemChat str ['onMouseButtonDblClick',_this]; false";
	// onMouseZChanged = "systemChat str ['onMouseZChanged',_this]; false";
	// onMouseMoving = "";
	// onMouseHolding = "";
};
class azControlsGroup_NoScroll_W : azControlsGroup
{
	class HScrollBar : HScrollBar
	{
		height = 0; // set to 0 for disable
	};	
};
class azControlsGroup_NoScroll : azControlsGroup_NoScroll_W
{
	class VScrollBar : VScrollBar
	{
		width = 0; // set to 0 for disable
	};
};

class azSlider
{
	access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
	idc = CT_SLIDER; // Control identification (without it, the control won't be displayed)
	type = CT_SLIDER; // Type
	style = SL_HORZ; // Style
	default = 0; // Control selected by default (only one within a display can be used)
	blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.

	x = 1 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X; // Horizontal coordinates
	y = 7 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y; // Vertical coordinates
	w = 7 * GUI_GRID_CENTER_W; // Width
	h = 1 * GUI_GRID_CENTER_H; // Height

	color[] = {0,0,0,1}; // Text color
	colorDisabled[] = {1,1,1,0.5}; // Disabled text color
	colorActive[] = {1,0.5,0,1}; // Text selection color

	tooltip = "CT_SLIDER"; // Tooltip text
	tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
	tooltipColorText[] = {1,1,1,1}; // Tooltip text color
	tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color

	class Title // Link to a title (obsolete?)
	{
		idc = -1; // Control IDC (has to be defined ABOVE the slider control)
		colorBase[] = {1,1,1,1}; // Text color
		colorActive[] = {1,0.5,0,1}; // Text color when the slider is active
	};
	class Value // Link to a control which will show slider value
	{
		idc = 1200; // Control IDC (has to be defined ABOVE the slider control)
		format = "%.g"; // Text format, value is represented by variable %g (float) or %.f (integer)
		type = SPTPlain; // Format, can be SPTPlain or SPTPercents (multiplies the value by 100)
		colorBase[] = {1,1,1,1}; // Text color
		colorActive[] = {1,0.5,0,1}; // Text color when the slider is active
	};

	// onCanDestroy = "systemChat str ['onCanDestroy',_this]; true";
	// onDestroy = "systemChat str ['onDestroy',_this]; false";
	// onSetFocus = "systemChat str ['onSetFocus',_this]; false";
	// onKillFocus = "systemChat str ['onKillFocus',_this]; false";
	// onKeyDown = "systemChat str ['onKeyDown',_this]; false";
	// onKeyUp = "systemChat str ['onKeyUp',_this]; false";
	// onMouseButtonDown = "systemChat str ['onMouseButtonDown',_this]; false";
	// onMouseButtonUp = "systemChat str ['onMouseButtonUp',_this]; false";
	// onMouseButtonClick = "systemChat str ['onMouseButtonClick',_this]; false";
	// onMouseButtonDblClick = "systemChat str ['onMouseButtonDblClick',_this]; false";
	// onMouseZChanged = "systemChat str ['onMouseZChanged',_this]; false";
	// onMouseMoving = "";
	// onMouseHolding = "";

	//onSliderPosChanged = "systemChat str ['onSliderPosChanged',_this]; false";
};
class azEdit
{
	access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
	idc = CT_EDIT; // Control identification (without it, the control won't be displayed)
	type = CT_EDIT; // Type
	style = ST_LEFT; // Style
	default = 0; // Control selected by default (only one within a display can be used)
	blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.

	x = 1 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X; // Horizontal coordinates
	y = 5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y; // Vertical coordinates
	w = 10 * GUI_GRID_CENTER_W; // Width
	h = 1 * GUI_GRID_CENTER_H; // Height

	text = "CT_EDIT"; // Displayed text
	sizeEx = GUI_GRID_CENTER_H; // Text size
	font = GUI_FONT_NORMAL; // Font from CfgFontFamilies
	shadow = 0; // Shadow (0 - none, 1 - N/A, 2 - black outline)
	colorText[] = {0,0,0,1}; // Text and frame color
	colorDisabled[] = {1,1,1,0.5}; // Disabled text and frame color
	colorSelection[] = {1,0.5,0,1}; // Text selection color

	tooltip = "CT_EDIT"; // Tooltip text
	tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
	tooltipColorText[] = {1,1,1,1}; // Tooltip text color
	tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color

	canModify = 1; // True (1) to allow text editing, 0 to disable it
	autocomplete = "scripting"; // Text autocomplete, can be "scripting" (scripting commands) or "general" (previously typed text)

	// onCanDestroy = "systemChat str ['onCanDestroy',_this]; true";
	// onDestroy = "systemChat str ['onDestroy',_this]; false";
	// onSetFocus = "systemChat str ['onSetFocus',_this]; false";
	// onKillFocus = "systemChat str ['onKillFocus',_this]; false";
	// onKeyDown = "systemChat str ['onKeyDown',_this]; false";
	// onKeyUp = "systemChat str ['onKeyUp',_this]; false";
	// onMouseButtonDown = "systemChat str ['onMouseButtonDown',_this]; false";
	// onMouseButtonUp = "systemChat str ['onMouseButtonUp',_this]; false";
	// onMouseButtonClick = "systemChat str ['onMouseButtonClick',_this]; false";
	// onMouseButtonDblClick = "systemChat str ['onMouseButtonDblClick',_this]; false";
	// onMouseZChanged = "systemChat str ['onMouseZChanged',_this]; false";
	// onMouseMoving = "";
	// onMouseHolding = "";
};