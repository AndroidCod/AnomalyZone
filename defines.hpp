// git version 0.1

// aoutor CHEREDNIKOV email: asdasd@scfsdf.com

#include "\a3\ui_f\hpp\defineCommonGrids.inc"
//#include "\a3\ui_f\hpp\definecommon.inc"
//#include "\a3\ui_f\hpp\defineCommonColors.inc"
//#include "\a3\ui_f\hpp\defineresincl.inc" // all arma 3 Control types NOT USE IN SCRIPTs

#define CT_
/*******************/
/*  Controls       */
/*******************/

// Control types
#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_HITZONES         17
#define CT_CONTROLS_TABLE   19
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102
#define CT_ITEMSLOT         103
#define CT_CHECKBOX         77
#define CT_VEHICLE_DIRECTION 105
// Static styles
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0C

#define ST_TYPE           0xF0
#define ST_SINGLE         0x00
#define ST_MULTI          0x10
#define ST_TITLE_BAR      0x20
#define ST_PICTURE        0x30
#define ST_FRAME          0x40
#define ST_BACKGROUND     0x50
#define ST_GROUP_BOX      0x60
#define ST_GROUP_BOX2     0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT      0xA0
#define ST_LINE           0xB0
#define ST_UPPERCASE      0xC0
#define ST_LOWERCASE      0xD0

#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800

#define ST_TITLE          ST_TITLE_BAR + ST_CENTER

// Slider styles
#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400

#define SL_TEXTURES       0x10

// progress bar
#define ST_VERTICAL       0x01
#define ST_HORIZONTAL     0

// Listbox styles
#define LB_TEXTURES       0x10
#define LB_MULTI          0x20

// Tree styles
#define TR_SHOWROOT       1
#define TR_AUTOCOLLAPSE   2

// MessageBox styles
#define MB_BUTTON_OK      1
#define MB_BUTTON_CANCEL  2
#define MB_BUTTON_USER    4
#define MB_ERROR_DIALOG   8



// handle damage types...
#define __AZ_DAMAGE_TYPE_NONE 		0
#define __AZ_DAMAGE_TYPE_BULLET 	1
#define __AZ_DAMAGE_TYPE_GRENADE 	2
#define __AZ_DAMAGE_TYPE_EXPLOSIVE 	3
#define __AZ_DAMAGE_TYPE_SHELL 		4


///////////////////////////////////////////////////////////////////////////
/// Text Sizes
///////////////////////////////////////////////////////////////////////////
//MUF - text sizes are using new grid (40/25)
#define GUI_TEXT_SIZE_SMALL		(GUI_GRID_H * 0.8)
#define GUI_TEXT_SIZE_MEDIUM		(GUI_GRID_H * 1)
#define GUI_TEXT_SIZE_LARGE		(GUI_GRID_H * 1.2)

#define IGUI_TEXT_SIZE_MEDIUM		(GUI_GRID_H * 0.8)


///////////////////////////////////////////////////////////////////////////
/// Fonts
///////////////////////////////////////////////////////////////////////////

//Changed by MUF - TODO: set proper fonts when available - PREPARED FOR FONT CHANGE (was Zeppelin32Mono, changed to Purista/Etelka)

//GUI_FONT_MONO - used for optics active parts
//GUI_FONT_BOLD - used for titles
#define GUI_FONT_NORMAL			RobotoCondensed
#define GUI_FONT_BOLD			RobotoCondensedBold
#define GUI_FONT_THIN			RobotoCondensedLight
#define GUI_FONT_MONO			EtelkaMonospacePro
#define GUI_FONT_NARROW			EtelkaNarrowMediumPro

#define GUI_FONT_CODE			LucidaConsoleB//Deprecated - for engine debug only (has only two sizes, which causes errors).
#define GUI_FONT_SYSTEM			TahomaB//Deprecated - for engine debug only (has only one size, which causes errors).


///////////////////////////////////////////////////////////////////////////
/// AZ GUI 16:9
///////////////////////////////////////////////////////////////////////////
// working area (16:9) screen centered grids
// 16:9 == x2 32:18 == x4 64:36
#define AZ_GUI_GRID_SIZE_W	64
#define AZ_GUI_GRID_SIZE_H	36
#define AZ_GUI_GRID_H (safeZoneH/AZ_GUI_GRID_SIZE_H)
#define AZ_GUI_GRID_W (AZ_GUI_GRID_H*(3/4))
//#define TEST 55
#if __EVAL((safeZoneW/AZ_GUI_GRID_W) >= AZ_GUI_GRID_SIZE_W)
	#undef AZ_GUI_GRID_W
	#undef AZ_GUI_GRID_H
	#define AZ_GUI_GRID_W (safeZoneW/AZ_GUI_GRID_SIZE_W)
	#define AZ_GUI_GRID_H (AZ_GUI_GRID_W * (4/3))
#endif

#define AZ_GUI_GRID_X (0.5 - (AZ_GUI_GRID_SIZE_W * 0.5 * AZ_GUI_GRID_W))
#define AZ_GUI_GRID_Y (0.5 - (AZ_GUI_GRID_SIZE_H * 0.5 * AZ_GUI_GRID_H))

#define X(a) ((a) * AZ_GUI_GRID_W + AZ_GUI_GRID_X)
#define Y(a) ((a) * AZ_GUI_GRID_H + AZ_GUI_GRID_Y)
#define W(a) ((a) * AZ_GUI_GRID_W)
#define H(a) ((a) * AZ_GUI_GRID_H)

#define AZ_GUI_TEXT_SIZE_SMALL 	(AZ_GUI_GRID_H * 0.8)
#define AZ_GUI_TEXT_SIZE_MEDIUM (AZ_GUI_GRID_H * 1)
#define AZ_GUI_TEXT_SIZE_LARGE 	(AZ_GUI_GRID_H * 1.2)

///////////////////////////////////////////////////////////////////////////
/// Item types
///////////////////////////////////////////////////////////////////////////
#define ITEM_STACK_MAX 1E+30

#define ITEM_GROUP_WEAPON 	20000
	#define ITEM_TYPE_WEAPON_HANDGUN 	20001
	#define ITEM_TYPE_WEAPON_PRIMARY 	20002
	#define ITEM_TYPE_WEAPON_SECONDARY 	20003
	#define ITEM_TYPE_WEAPON_MUZZLE 	20004
	#define ITEM_TYPE_WEAPON_POINTER 	20005
	#define ITEM_TYPE_WEAPON_OPTIC 		20006
	#define ITEM_TYPE_WEAPON_BIPOD 		20007
#define ITEM_TYPE_VES
#define ITEM_GROUP_AMMO 	19000
#define ITEM_TYPE_AMMO	 	19001
#define ITEM_TYPE_MAGAZINE 	19002
	#define ITEM_TYPE_GRENADE 	19003
	

#define ITEM_GROUP_GEAR 	18000
	#define ITEM_TYPE_HEADGEAR 	18001
	#define ITEM_TYPE_UNIFORM 	18002
	#define ITEM_TYPE_BACKPACK 	18003
	#define ITEM_TYPE_VEST 		18004
	#define ITEM_TYPE_GOGGLE 	18005
	#define ITEM_TYPE_BINOCULAR 18006
	#define ITEM_TYPE_NVG 		18007
	
// magazine types
#define ITEM_TYPE_NVG 602
//#define ITEM_TYPE_MAGAZINE_HANDGUN_AND_GL 16 // mainly
//#define ITEM_TYPE_MAGAZINE_PRIMARY_AND_THROW 256
//#define ITEM_TYPE_MAGAZINE_SECONDARY_AND_PUT 512 // mainly
//#define ITEM_TYPE_MAGAZINE_MISSILE 768
// more types
//#define ITEM_TYPE_BINOCULAR_AND_NVG 4096
//#define ITEM_TYPE_WEAPON_VEHICLE 65536
//#define TYPE_ITEM 131072
// item types
//#define ITEM_TYPE_MUZZLE 101
//#define ITEM_TYPE_OPTICS 201
//#define ITEM_TYPE_FLASHLIGHT 301
// #define ITEM_TYPE_BIPOD 302
// #define ITEM_TYPE_FIRST_AID_KIT 401
// #define ITEM_TYPE_FINS 501 // not implemented
// #define ITEM_TYPE_BREATHING_BOMB 601 // not implemented

//#define ITEM_TYPE_GOGGLE 603
// #define ITEM_TYPE_SCUBA 604 // not implemented

// #define ITEM_TYPE_FACTOR 607
// #define ITEM_TYPE_RADIO 611
// #define ITEM_TYPE_HMD 616
// #define ITEM_TYPE_BINOCULAR 617
// #define ITEM_TYPE_MEDIKIT 619
// #define ITEM_TYPE_TOOLKIT 620
// #define ITEM_TYPE_UAV_TERMINAL 621
//#define TYPE_BINOCULAR 617

///////////////////////////////////////////////////////////////////////////
/// Gear Dialog
///////////////////////////////////////////////////////////////////////////
#define GEAR_DIALOG_IDD 556699

#define GEAR_DIALOG_CONTAINER_IDC_CAPACITY 500000
#define GEAR_DIALOG_LEFT_CONTAINER_IDC 1000
#define GEAR_DIALOG_BACKPACK_CONTAINER_IDC (GEAR_DIALOG_LEFT_CONTAINER_IDC + GEAR_DIALOG_CONTAINER_IDC_CAPACITY)
#define GEAR_DIALOG_UNIFORM_CONTAINER_IDC (GEAR_DIALOG_BACKPACK_CONTAINER_IDC + GEAR_DIALOG_CONTAINER_IDC_CAPACITY)
#define GEAR_DIALOG_VEST_CONTAINER_IDC (GEAR_DIALOG_UNIFORM_CONTAINER_IDC + GEAR_DIALOG_CONTAINER_IDC_CAPACITY)

#define GEAR_DIALOG_DRAG_SLOT_IDC 990

// Gear Slots ID
#define GEAR_SLOT_ID_NVG 		100
#define GEAR_SLOT_ID_HEADGEAR 	110
#define GEAR_SLOT_ID_GOGGLE 	120

#define GEAR_SLOT_ID_UNIFORM 	130
#define GEAR_SLOT_ID_VEST 		140
#define GEAR_SLOT_ID_BACKPACK 	150

#define GEAR_SLOT_ID_WEAPON_PRIMARY 		160
#define GEAR_SLOT_ID_WEAPON_PRIMARY_MAG_0 	170
#define GEAR_SLOT_ID_WEAPON_PRIMARY_MAG_1 	180
#define GEAR_SLOT_ID_WEAPON_SECONDARY 		190
#define GEAR_SLOT_ID_WEAPON_HANDGUN 		200

#define GEAR_SLOT_ID_BINOCULAR 	210
#define GEAR_SLOT_ID_MAP 		220
#define GEAR_SLOT_ID_RADIO 		230
#define GEAR_SLOT_ID_COMPASS 	240
#define GEAR_SLOT_ID_WATCH 		250
// ["ItemMap", "ItemGPS", "ItemRadio", "ItemCompass", "ItemWatch", "NVGoggles"]


#define ITEMS_MAP_SORT_MODE_DEFAULT 	0
#define ITEMS_MAP_SORT_MODE_GROUP 		1
//#define ITEMS_MAP_SORT_MODE_FIXEDSIZE 	2

#define LEFT_X(a) X(0.5 + (a))
#define LEFT_Y(a) Y(1 + (a))

#define CENTER_X(a) X(22.5 + (a))
#define CENTER_Y(a) Y(1 + (a))

#define RIGHT_X(a) X(41 + (a))
#define RIGHT_Y(a) 1 + (a))

#define GEAR_SLOT_PAD 0.15

///////////////////////////////////////////////////////////////////////////
/// Container types
///////////////////////////////////////////////////////////////////////////
#define CONT_TYPE_VIRTUAL 	0
#define CONT_TYPE_UNIFORM 	1
#define CONT_TYPE_VEST 		2
#define CONT_TYPE_BACPACK 	4
#define CONT_TYPE_CARGO 	8

///////////////////////////////////////////////////////////////////////////
/// Loadout filter presets
///////////////////////////////////////////////////////////////////////////
#define LOADOUT_WEAPON_PRIMARY 		0
#define LOADOUT_WEAPON_SECONDARY 	1
#define LOADOUT_WEAPON_HANDGUN 		2
#define LOADOUT_UNIFORM 			3
#define LOADOUT_VEST 				4
#define LOADOUT_BACKPACK 			5
#define LOADOUT_HEADGEAR 			6
#define LOADOUT_GOGGLE 				7
#define LOADOUT_BINOCULAR 			8
#define LOADOUT_ASSIGNED_ITEMS 		9



/*
#define AZ_GUI_SLOT_COLORBACK   "#(argb,8,8,3color(0.25,0.25,0.25,0.75)"
#define AZ_GUI_SLOT_TEXTSIZE	(0.7 * GUI_GRID_CENTER_H)

*/
