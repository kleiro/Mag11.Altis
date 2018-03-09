//Air2AirDialogs

/* #Casufe
$[
	1.063,
	["a2aGUI",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[-1000,"a2aBackground",[1,"",["0.427812 * safezoneW + safezoneX","0.346 * safezoneH + safezoneY","0.144375 * safezoneW","0.308 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.75],[-1,-1,-1,-1],"","-1"],["idc = 1000;"]],
	[-1001,"a2aTitlebar",[1,"Air To Air Range Spawn Options",["0.427812 * safezoneW + safezoneX","0.346 * safezoneH + safezoneY","0.144375 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.95],[-1,-1,-1,-1],"","-1"],["idc = 1001;"]],
	[-2100,"a2aDifficultyCombo",[1,"",["0.520625 * safezoneW + safezoneX","0.401 * safezoneH + safezoneY","0.037125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 2100;"]],
	[-1002,"a2aDifficultyText",[1,"Number of Enemies:",["0.438125 * safezoneW + safezoneX","0.401 * safezoneH + safezoneY","0.0928125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 1002;"]],
	[-1003,"a2aSpawnListText",[1,"Enemy Spawn Table",["0.463906 * safezoneW + safezoneX","0.456 * safezoneH + safezoneY","0.0773437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 1003;"]],
	[-1004,"a2aListbox: RscListBox",[1,"",["0.438125 * safezoneW + safezoneX","0.489 * safezoneH + safezoneY","0.12375 * safezoneW","0.11 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 1500;","style = 32;"]],
	[-2400,"a2aOKButton",[1,"OK",["0.474219 * safezoneW + safezoneX","0.61 * safezoneH + safezoneY","0.0495 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 2400;"]]
]
*/



class a2aGUI {
	idd = 1430;
	movingEnable = false;
	enableSimulation = true;

	class controls {
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by [Capt] R.Klein, v1.063, #Casufe)
		////////////////////////////////////////////////////////

		class a2aBackground: RscText
		{
			idc = 1000;

			x = 0.427812 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.308 * safezoneH;
			colorBackground[] = {0,0,0,0.75};
		};
		class a2aTitlebar: RscText
		{
			idc = 1001;

			text = "Air To Air Range Spawn Options"; //--- ToDo: Localize;
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0,0,0,0.95};
		};
		class a2aDifficultyCombo: RscCombo
		{
			idc = 2100;

			x = 0.520625 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.037125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class a2aDifficultyText: RscText
		{
			idc = 1002;

			text = "Number of Enemies:"; //--- ToDo: Localize;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class a2aSpawnListText: RscText
		{
			idc = 1003;

			text = "Enemy Spawn Table"; //--- ToDo: Localize;
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class a2aListbox: RscListBox
		{
			idc = 1500;
			style = 32;

			x = 0.438125 * safezoneW + safezoneX;
			y = 0.489 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.11 * safezoneH;
		};
		class a2aOKButton: RscButtonMenu
		{
			idc = 2400;

			text = "OK"; //--- ToDo: Localize;
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0495 * safezoneW;
			h = 0.022 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////


	};
};