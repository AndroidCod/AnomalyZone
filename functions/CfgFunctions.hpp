
/*
class CfgFunctions
{
	class myTag
	{
		class myCategory
		{
			class myFunction {file = "myFile.sqf";};
		};
	};
};
This will try to compile function myTag_fnc_myFunction from the following file:
*/

class CfgFunctions
{
    class AZ // myTag
	{
		//tag = "az";		
		class Common // functions\Common
		{
			//file = "scripts\common";
			class getTypeOfDamage {};
			class isAmmoWeapon {};
			class getItemArmor {};
			class getFogPowerASL {};
			class getDayPhase {};
			class inAngleSector {};
			class loadConfigToHashMap {};
			class changeProjectileDirection {};
			class preloadConfigParam {};
			class quickSort {};
			class posInRect {};
			class Rect_isIntersect {};
			
			
			class screenShot {};
			class Calibrovka {};
			
			
		};
		
		
		#include "Player\CfgFunctions.hpp"		
		
		#include "HUD\CfgFunctions.hpp"		
		
		#include "AI\CfgFunctions.hpp"	
		
		#include "Mutant\CfgFunctions.hpp"	
		
	};
	
	#include "Unit\CfgFunctions.hpp"		
	#include "GUI\CfgFunctions.hpp"		
	#include "GearDialog\CfgFunctions.hpp"	
	#include "Item\CfgFunctions.hpp"		
	#include "ItemsContainer\CfgFunctions.hpp"		
};
