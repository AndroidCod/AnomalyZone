
class AZ_HUD_EnemyStatus
{
	idd = 4100;
	fadein = 0;
	fadeout = 0;
	duration = 0.1;
	onLoad = "uinamespace setVariable ['AZ_HUD_EnemyStatus',_this select 0]";
	onUnLoad = "uinamespace setVariable ['AZ_HUD_EnemyStatus', nil]";	
	class Controls
	{
		
		// HP bar
		class StaticText_HP_Background: azStaticText
		{
			idc = 1000;
			style = ST_CENTER;
			colorBackground[] = {0,0,0,0.6};
			colorText[] = {1,1,1,1};
			shadow = 0;
			text = "";
			x = 0 * GUI_GRID_W + GUI_GRID_X; // Horizontal coordinates
			y = 0 * GUI_GRID_H + GUI_GRID_Y; // Vertical coordinates
			w = 3 * GUI_GRID_W; // Width
			h = 0.1 * GUI_GRID_H; // Height			
		};
		class ProgressBar_HP: azProgressBar 
		{
			idc = 1001;
			texture = "#(argb,8,8,3)color(0.64,0.21,0.18,0.9)";
			//texture = "configs\hud\textures\ui_actor_rad_gs.paa";
			colorBar[] = {1,1,1,1}; // Bar color
			colorFrame[] = {0,0,0,0}; // Frame color
			x = 0 * GUI_GRID_W + GUI_GRID_X; // Horizontal coordinates
			y = 0 * GUI_GRID_H + GUI_GRID_Y; // Vertical coordinates
			w = 3 * GUI_GRID_W; // Width
			h = 0.1 * GUI_GRID_H; // Height
		};
		/*class StaticText_HP: azStaticText
		{
			idc = 1002;
			style = ST_CENTER;
			colorBackground[] = {0,0,0,0};
			//colorText[] = {0,0.75,0,0.8};
			colorText[] = {0.8,0.8,0.8,0.8};
			shadow = 0;
			sizeEx = 0.6 * GUI_GRID_CENTER_H; // Text size
			x = 1 * GUI_GRID_W + GUI_GRID_X; // Horizontal coordinates
			y = 23 * GUI_GRID_H + GUI_GRID_Y; // Vertical coordinates
			w = 10 * GUI_GRID_W; // Width
			h = 0.3 * GUI_GRID_H; // Height			
		};*/

	};
};
