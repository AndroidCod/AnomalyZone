class CfgSounds
{
	sounds[] = {};
	class Firelake
	{
		// how the sound is referred to in the editor (e.g. trigger effects)
		name = "Firelake_sound";

		// filename, volume, pitch, distance (optional)
		sound[] = { "\sounds\Firelake.ogg", 25, 1, 100 }; //!!! Обязательно путь к файлу начинать с \ иначе не работает

		// subtitle delay in seconds, subtitle text
		titles[] = { };
	};
	
	#include "stamina_sound.hpp"
};