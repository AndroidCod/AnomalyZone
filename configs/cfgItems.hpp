//


class cfgItems
{

	class Item
	{
		gearSlot[] = {};
		weight = 0;
		stack = 1;
		pocketSet = 0;
		pictureRect[] = {0.5, 0.5, 1, 1};
	};
	
	class Gear : Item
	{
		group = ITEM_GROUP_GEAR;
	};
	// Headgear
	class Helmet : Gear 
	{
		type = ITEM_TYPE_HEADGEAR;
		armaClassParent = "CfgWeapons";
		armaClass = "H_HelmetSpecB_blk";
		preloads[] = {"picture", "displayName"};
		slotSize[] = {2, 2};
		pictureRect[] = {0.5, 0.5, 2, 2};
		gearSlot[] = {GEAR_SLOT_ID_HEADGEAR};
		weight = 1300;
		stack = 1;		
	};	
	
	// Goggle
	class Goggle : Gear 
	{
		type = ITEM_TYPE_GOGGLE;
		armaClassParent = "CfgGlasses";
		armaClass = "rhs_balaclava";
		preloads[] = {"picture", "displayName"};
		slotSize[] = {2, 2};
		pictureRect[] = {0.5, 0.5, 2, 2};
		gearSlot[] = {GEAR_SLOT_ID_GOGGLE};
		weight = 400;
		stack = 1;		
	};	
	
	// NVG
	class NVG : Gear 
	{
		type = ITEM_TYPE_NVG;
		armaClassParent = "CfgWeapons";
		armaClass = "NVGoggles_INDEP";
		preloads[] = {"picture", "displayName"};
		slotSize[] = {2, 2};
		pictureRect[] = {0.5, 0.5, 2, 2};
		gearSlot[] = {GEAR_SLOT_ID_NVG};
		weight = 400;
		stack = 1;		
	};	
	
	// Uniform
	class Uniform : Gear 
	{
		type = ITEM_TYPE_UNIFORM;
		armaClassParent = "CfgWeapons";
		armaClass = "U_B_CombatUniform_mcam";
		preloads[] = {"picture", "displayName"};
		slotSize[] = {2, 3};
		pictureRect[] = {0.5, 0.5, 2, 2};
		gearSlot[] = {GEAR_SLOT_ID_UNIFORM};
		weight = 800;
		stack = 1;
		class ItemsContainer 
		{
			access = 0; // access (0 - ReadAndWrite, 1 - ReadOnly)
			capacity = 0;
			rect[] = {0, 0, 2, 4}; // maximum 2x4
			isPockets = 1;
		};
	};
	
	// Vest
	class Vest : Gear 
	{
		type = ITEM_TYPE_VEST;
		armaClassParent = "CfgWeapons";
		armaClass = "V_PlateCarrierGL_mtp";
		preloads[] = {"picture", "displayName"};
		slotSize[] = {3, 4};
		pictureRect[] = {0.5, 0.5, 3, 3};
		gearSlot[] = {GEAR_SLOT_ID_VEST};
		weight = 2500;
		stack = 1;
		class ItemsContainer 
		{
			access = 0; // access (0 - ReadAndWrite, 1 - ReadOnly)
			capacity = 0;
			rect[] = {0, 0, 7, 4}; // maximum 7x4
			isPockets = 1;
		};
	};
	
	// Backpack
	class Backpack : Gear 
	{
		type = ITEM_TYPE_BACKPACK;
		armaClassParent = "CfgVehicles";
		armaClass = "B_Kitbag_rgr";
		preloads[] = {"picture", "displayName"};
		slotSize[] = {4, 5};
		pictureRect[] = {0.5, 0.5, 4, 4};
		gearSlot[] = {GEAR_SLOT_ID_BACKPACK};
		weight = 1500;
		stack = 1;
		class ItemsContainer 
		{
			access = 0; // access (0 - ReadAndWrite, 1 - ReadOnly)
			capacity = 0;
			rect[] = {2, 1, 7, 9}; //
			isPockets = 0;
		};
	};	
	
	
	// Ammo 
	class Ammo : Item
	{
		group = ITEM_GROUP_AMMO;
		type = ITEM_TYPE_AMMO;
		displayName = "Ammo";
		picture = "";
		slotSize[] = {1, 1};
		weight = 0;
		stack = 1;		
		tracer = 0;
	};
	class Ammo_65x39_caseless : Ammo
	{		
		displayName = "5.45x39 ПС";
		picture = "data\items\ammo\545x39_ca.paa";
		slotSize[] = {1, 1};
		weight = 1.5;
		stack = 100;
		pocketSet = 1;
	};
	class Ammo_65x39_caseless_tracer : Ammo_65x39_caseless
	{
		displayName = "5.45x39 Tracer";
		tracer = 1;	
	};
	class Ammo_762x54 : Ammo
	{
		displayName = "7.62x54";
		picture = "data\items\ammo\762x54_ca.paa";
		slotSize[] = {1, 1};
		weight = 1.5;
		stack = 80;
		pocketSet = 1;
	};	
	class Ammo_G_40mm_HE : Ammo
	{
		displayName = "40mm grenade";
		picture = "\A3\Weapons_f\Data\ui\gear_UGL_slug_CA.paa";
		slotSize[] = {1, 1};
		weight = 150;
		stack = 1;
		pocketSet = 1;
	};
	
	// Magazines
	// configfile >> "CfgMagazines" >> "30Rnd_762x39_Mag_F" >> "picture"
	class Magazine : Item
	{
		group = ITEM_GROUP_AMMO;
		type = ITEM_TYPE_MAGAZINE;
		armaClassParent = "cfgMagazines";
		armaClass = "";
		preloads[] = {};
		displayName = "magazine";
		slotSize[] = {1, 2};
		pictureRect[] = {0.5, 0.5, 1, 2};
		weight = 0;
		stack = 1;
		capacity = 0;
		ammoTypes[] = {};
		isIntegral = 0;
		ammo = ""; // by default creation
		ammoCount = 0; // by default creation
	};
	class MagazineIntegral : Magazine
	{
		isIntegral = 1;
		pocketSet = 0;
		weight = 0;
		displayName = "";
	};
	class Mag_30_65x39_caseless : Magazine 
	{
		armaClass = "30Rnd_65x39_caseless_mag"; // // by default creation and for preloads!
		//preloads[] = {"picture"};
		// picture = "data\items\magazines\30Rnd_762x39_Mag_F.paa";
		picture = "data\items\magazines\Mag_30_65x39_caseless.paa";
		displayName = "";
		slotSize[] = {1, 2};
		pictureRect[] = {0.5, 0.5, 1, 2};
		weight = 150;
		stack = 1;
		capacity = 30;
		ammoTypes[] = {"Ammo_65x39_caseless", "Ammo_65x39_caseless_tracer"};
		Ammo_65x39_caseless = "30Rnd_65x39_caseless_mag"; // arma class by ammo type
		Ammo_65x39_caseless_tracer = "30Rnd_65x39_caseless_mag_Tracer"; // arma class by ammo type
		pocketSet = 1;
	};
	class Mag_Int_1Rnd_GL_40mm : MagazineIntegral 
	{
		capacity = 1;
		ammoTypes[] = {"Ammo_G_40mm_HE"};
		Ammo_G_40mm_HE = "1Rnd_HE_Grenade_shell"; // arma class by ammo type
	};
	class Mag_Int_5Rnd_762x54 : MagazineIntegral 
	{
		capacity = 5;
		ammoTypes[] = {"Ammo_762x54"};
		Ammo_762x54 = "rhsgref_5Rnd_762x54_m38"; // arma class by ammo type
		ammo = "Ammo_762x54"; // by default creation
		ammoCount = 4; // by default creation
	};
	
	// Grenades
	class HandGrenade : Item
	{
		group = ITEM_GROUP_AMMO;
		type = ITEM_TYPE_GRENADE; // THROW type
		armaClassParent = "cfgMagazines";
		armaClass = "HandGrenade"; // "rhs_mag_rgd5";
		//preloads[] = {"displayName"}; // {"picture"};
		displayName = "";
		picture = "data\items\grenades\rgd_5.paa";
		slotSize[] = {1, 1};
		weight = 500;
		stack = 1;
		pocketSet = 1;
	};
	
	// Weapons accessory
	// Muzzles
	class Muzzle_item : Item
	{
		group = ITEM_GROUP_WEAPON;
		type = ITEM_TYPE_WEAPON_MUZZLE;
		weight = 0;
		stack = 1;
		pocketSet = 1;
		armaClassParent = "CfgWeapons";
		anchorPoint[] = {0, 0, 1}; // [offsetX, offsetY, scale]
	};
	class Muzzle_snds_H : Muzzle_item
	{
		armaClass = "muzzle_snds_H";
		preloads[] = {"displayName"}; // "picture", 
		picture = "data\items\muzzleItems\muzzle_snds_H_ca.paa";
		slotSize[] = {2, 1};
		pictureRect[] = {0.5, 0.5, 2,1};
		anchorPoint[] = {0.91, 0.5, 0.5}; // [offsetX, offsetY, scale]
		weight = 100;
	};
	class Muzzle_snds_KZRZP_SVD : Muzzle_item
	{
		armaClass = "CUP_muzzle_snds_KZRZP_SVD";
		preloads[] = {"displayName"}; // "picture", 
		picture = "data\items\muzzleItems\Muzzle_snds_KZRZP_SVD_ca.paa";
		slotSize[] = {2, 1};
		pictureRect[] = {0.5, 0.5, 2, 1};
		anchorPoint[] = {0.9, 0.5, 0.6}; // [offsetX, offsetY, scale] 
		weight = 100;
	};
	class Muzzle_snds_L : Muzzle_item
	{
		armaClass = "muzzle_snds_L";
		preloads[] = {"picture", "displayName"}; //  
		// picture = "data\items\muzzleItems\Muzzle_snds_KZRZP_SVD_ca.paa";
		slotSize[] = {1, 1};
		pictureRect[] = {0.5, 0.5, 1, 1};
		anchorPoint[] = {0, 0, 1}; // [offsetX, offsetY, scale] 
		weight = 100;
	};
	
	
	// Pointers
	class Pointer_item : Item
	{
		group = ITEM_GROUP_WEAPON;
		type = ITEM_TYPE_WEAPON_POINTER;
		weight = 0;
		stack = 1;
		pocketSet = 1;
		armaClassParent = "CfgWeapons";
		anchorPoint[] = {0, 0, 1}; // [offsetX, offsetY, scale]
	};
	class Acc_flashlight : Pointer_item
	{
		armaClass = "acc_flashlight";
		preloads[] = {"picture", "displayName"};
		slotSize[] = {1, 1};
		pictureRect[] = {0.5, 0.5, 1,1};
		weight = 100;
		anchorPoint[] = {0.5, 0.5, 0.5}; // [offsetX, offsetY, scale]
	};
	// Optics	
	class Optic_item : Item
	{
		group = ITEM_GROUP_WEAPON;
		type = ITEM_TYPE_WEAPON_OPTIC;
		weight = 0;
		stack = 1;
		pocketSet = 1;
		armaClassParent = "CfgWeapons";
		anchorPoint[] = {0, 0, 1}; // [offsetX, offsetY, scale]
	};
	class Optic_LRPS : Optic_item
	{
		armaClass = "optic_LRPS";
		preloads[] = {"displayName"}; // "picture",
		picture = "data\items\optics\optic_LRPS_ca.paa";
		slotSize[] = {2, 1};
		pictureRect[] = {0.5, 0.5, 2,1};
		anchorPoint[] = {0.5, 0.7, 0.9}; // [offsetX, offsetY, scale]
		weight = 100;
	};	
	class Optic_PSO_1 : Optic_item
	{
		armaClass = "CUP_optic_PSO_1";
		preloads[] = {"displayName"}; // "picture",
		picture = "data\items\optics\Optic_PSO_1_ca.paa";
		slotSize[] = {2, 1};
		pictureRect[] = {0.5, 0.5, 2, 1};
		anchorPoint[] = {0.4, 0.64, 0.9}; // [offsetX, offsetY, scale]
		weight = 100;
	};	
	// Bipods	
	class Bipod_item : Item
	{
		group = ITEM_GROUP_WEAPON;
		type = ITEM_TYPE_WEAPON_BIPOD;
		weight = 0;
		stack = 1;
		pocketSet = 1;
		armaClassParent = "CfgWeapons";
		anchorPoint[] = {0, 0, 1}; // [offsetX, offsetY, scale]
	};
	class Acc_harris_swivel : Bipod_item
	{
		armaClass = "rhs_acc_harris_swivel";
		preloads[] = {"picture", "displayName"};
		slotSize[] = {1, 1};
		pictureRect[] = {0.5, 0.5, 1,1};
		anchorPoint[] = {0, 0, 1}; // [offsetX, offsetY, scale]
		weight = 100;
	};
	
	// Weapon
	class Weapon : Item
	{
		group = ITEM_GROUP_WEAPON;
		armaClassParent = "CfgWeapons";
		muzzles[] = {"this"};
		magazineTypes[] = {};
		magazine = "";
		muzzleTypes[] = {};
		pointerTypes[] = {};
		opticTypes[] = {};
		bipodTypes[] = {};
		opticPoint[] = {0, 0, 1}; // [offsetX, offsetY, scale]
		muzzlePoint[] = {0, 0, 1}; // [offsetX, offsetY, scale]
		pointerPoint[] = {0, 0, 1}; // [offsetX, offsetY, scale]
		bipodPoint[] = {0, 0, 1}; // [offsetX, offsetY, scale]
	};
	class WeaponPrimary : Weapon
	{
		type = ITEM_TYPE_WEAPON_PRIMARY;
		gearSlot[] = {GEAR_SLOT_ID_WEAPON_PRIMARY, GEAR_SLOT_ID_WEAPON_SECONDARY};
	};
	class arifle : WeaponPrimary
	{		
		armaClass = "arifle_MX_GL_F";
		preloads[] = {"picture", "displayName"};
		slotSize[] = {5, 2};
		pictureRect[] = {0.5, 0.5, 4, 2}; // Need for slot rotation		
		opticPoint[] = {0.5, 0.365, 1}; // [offsetX, offsetY, scale]
		muzzlePoint[] = {0.11, 0.43, 1}; // [offsetX, offsetY, scale]
		pointerPoint[] = {0.25, 0.43, 1}; // [offsetX, offsetY, scale]
		bipodPoint[] = {0, 0, 1}; // [offsetX, offsetY, scale]
		weight = 1500;
		stack = 1;
		muzzles[] = {"this", "GL_3GL_F"};
		// muzzle 0
		magazineTypes[] = {"Mag_30_65x39_caseless"};
		magazine = "";
		// muzzle 1
		class GL_3GL_F // muzzle class same as Arma muzzle class
		{
			magazineTypes[] = {};
			magazine = "Mag_Int_1Rnd_GL_40mm";
		};
		muzzleTypes[] = {"Muzzle_snds_H"};
		pointerTypes[] = {"Acc_flashlight"};
		opticTypes[] = {"Optic_LRPS"};
		bipodTypes[] = {};
	};	
	class Weap_m38 : WeaponPrimary
	{
		armaClass = "rhs_weap_m38";
		preloads[] = {"displayName"};
		picture = "data\items\weapons\weap_m38_ca.paa";
		slotSize[] = {6, 1};
		pictureRect[] = {0.5, 0.5, 5, 2.5}; // Need for slot rotation	
		weight = 1500;
		stack = 1;
		muzzles[] = {"this"};
		// muzzle 0
		magazineTypes[] = {};
		magazine = "Mag_Int_5Rnd_762x54";
		
	};	
	class Weap_SVD : WeaponPrimary
	{
		armaClass = "CUP_srifle_SVD";
		preloads[] = {"picture", "displayName"};
		slotSize[] = {7, 2};
		pictureRect[] = {0.575, 0.35, 7, 3.5}; // Need for slot rotation	
		weight = 1500;
		stack = 1;
		muzzles[] = {"this"};
		// muzzle 0
		magazineTypes[] = {};
		magazine = "";
		muzzleTypes[] = {"Muzzle_snds_KZRZP_SVD"};
		pointerTypes[] = {};
		opticTypes[] = {"Optic_PSO_1"};
		opticPoint[] = {0.65, 0.5, 1}; 
		muzzlePoint[] = {0.07, 0.53, 1};  		
	};
	
	class WeaponHandgun : Weapon
	{
		type = ITEM_TYPE_WEAPON_HANDGUN;
		gearSlot[] = { GEAR_SLOT_ID_WEAPON_HANDGUN };
	};
	class Weap_P07 : WeaponHandgun
	{
		armaClass = "hgun_P07_F";
		preloads[] = {"picture", "displayName"};
		slotSize[] = {2, 1};
		pictureRect[] = {0.5, 0.5, 3, 1.5}; // Need for slot rotation	
		weight = 800;
		stack = 1;
		muzzles[] = {"this"};
		// muzzle 0
		magazineTypes[] = {};
		magazine = ""; // 16Rnd_9x21_Mag
		muzzleTypes[] = {"Muzzle_snds_L"};
		muzzlePoint[] = {0, 0, 1};
	};
};

/*


comment "Exported from Arsenal by android";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local this) exitWith {};

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add weapons";
this addWeapon "CUP_srifle_SVD";
this addPrimaryWeaponItem "CUP_muzzle_snds_KZRZP_SVD";
this addPrimaryWeaponItem "CUP_optic_PSO_1";
this addPrimaryWeaponItem "CUP_10Rnd_762x54_SVD_M";
this addWeapon "hgun_P07_F";
this addHandgunItem "muzzle_snds_L";
this addHandgunItem "16Rnd_9x21_Mag";

comment "Add containers";
this forceAddUniform "rhs_uniform_cu_ocp_1stcav";
this addVest "rhs_6b23";
this addBackpack "B_Carryall_taiga_F";

comment "Add binoculars";
this addWeapon "Binocular";

comment "Add items to containers";
this addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {this addItemToUniform "CUP_10Rnd_762x54_SVD_M";};
this addItemToUniform "16Rnd_9x21_Mag";
for "_i" from 1 to 2 do {this addItemToVest "16Rnd_9x21_Mag";};
for "_i" from 1 to 9 do {this addItemToBackpack "rhs_mag_rgd5";};
this addHeadgear "rhs_ssh68";
this addGoggles "rhs_balaclava";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "ItemRadio";
this linkItem "ItemGPS";
this linkItem "NVGoggles_INDEP";

comment "Set identity";
[this,"WhiteHead_03","rhs_male01cz"] call BIS_fnc_setIdentity;


*/