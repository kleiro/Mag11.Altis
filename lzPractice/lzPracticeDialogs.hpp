//RKleinsdialogs.hpp

/* #Lupobo
$[
	1.063,
	["lzDialog",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1000,"lzPracticeBackground",[1,"",["0.365937 * safezoneW + safezoneX","0.379 * safezoneH + safezoneY","0.268125 * safezoneW","0.242 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.65],[-1,-1,-1,-1],"","-1"],["idc = 1000;"]],
	[1001,"lzPracticeTitleBar",[1,"Landing Zone Practice",["0.365937 * safezoneW + safezoneX","0.379 * safezoneH + safezoneY","0.268125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[0.05,0.05,0.05,0.98],[-1,-1,-1,-1],"","-1"],["idc = 1001;"]],
	[2100,"uh1yCombo",[1,"",["0.45875 * safezoneW + safezoneX","0.467 * safezoneH + safezoneY","0.037125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 2100;"]],
	[2101,"ch53Combo",[1,"",["0.45875 * safezoneW + safezoneX","0.511 * safezoneH + safezoneY","0.037125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 2101;"]],
	[2102,"difficultyCombo",[1,"",["0.432969 * safezoneW + safezoneX","0.423 * safezoneH + safezoneY","0.136125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 2102;"]],
	[1002,"uh1yText",[1,"UH-1Y's to be used:",["0.371094 * safezoneW + safezoneX","0.467 * safezoneH + safezoneY","0.0928125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 1002;"]],
	[1003,"ch53Text",[1,"CH-53's to be used:",["0.371094 * safezoneW + safezoneX","0.511 * safezoneH + safezoneY","0.0928125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 1003;"]],
	[1004,"difficultyText",[1,"Difficulty:",["0.371094 * safezoneW + safezoneX","0.423 * safezoneH + safezoneY","0.0495 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 1004;"]],
	[2400,"startButton",[1,"Start",["0.443281 * safezoneW + safezoneX","0.566 * safezoneH + safezoneY","0.0556875 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,0.8],[-1,-1,-1,-1],"","-1"],["idc = 2400;","font = |RobotoCondensed|;","align = |Center|;"]],
	[2401,"cancelButton",[1,"Cancel",["0.37625 * safezoneW + safezoneX","0.566 * safezoneH + safezoneY","0.0556875 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,0.8],[-1,-1,-1,-1],"","-1"],["idc = 2401;","font = |RobotoCondensed|;","align = |Center|;"]],
	[2402,"endScenarioButton",[1,"End Scenario",["0.510312 * safezoneW + safezoneX","0.544 * safezoneH + safezoneY","0.113437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 2402;","font = |RobotoCondensed|;","align = |Center|;"]],
	[1005,"runningScenariosListbox: RscListBox",[1,"",["0.510312 * safezoneW + safezoneX","0.489 * safezoneH + safezoneY","0.113437 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.8],[-1,-1,-1,-1],"","-1"],["idc = 1500;"]],
	[1006,"runningScenariosText",[1,"Running Scenarios",["0.510312 * safezoneW + safezoneX","0.467 * safezoneH + safezoneY","0.113437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 1002;","align = |Center|;"]]
]
*/





class lzDialog {
	idd = 69;
	movingEnable = false;
	enableSimulation = true;

	class controls {
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by [Capt] R.Klein, v1.063, #Lupobo)
		////////////////////////////////////////////////////////

		class lzPracticeBackground: RscText
		{
			idc = 1000;

			x = 0.365937 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.268125 * safezoneW;
			h = 0.242 * safezoneH;
			colorBackground[] = {0,0,0,0.65};
		};
		class lzPracticeTitleBar: RscText
		{
			idc = 1001;

			text = "Landing Zone Practice"; //--- ToDo: Localize;
			x = 0.365937 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.268125 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.05,0.05,0.05,0.98};
		};
		class uh1yCombo: RscCombo
		{
			idc = 2100;

			x = 0.45875 * safezoneW + safezoneX;
			y = 0.467 * safezoneH + safezoneY;
			w = 0.037125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class ch53Combo: RscCombo
		{
			idc = 2101;

			x = 0.45875 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.037125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class difficultyCombo: RscCombo
		{
			idc = 2102;

			x = 0.432969 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.136125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class uh1yText: RscText
		{
			idc = 1002;

			text = "UH-1Y's to be used:"; //--- ToDo: Localize;
			x = 0.371094 * safezoneW + safezoneX;
			y = 0.467 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class ch53Text: RscText
		{
			idc = 1003;

			text = "CH-53's to be used:"; //--- ToDo: Localize;
			x = 0.371094 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class difficultyText: RscText
		{
			idc = 1004;

			text = "Difficulty:"; //--- ToDo: Localize;
			x = 0.371094 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.0495 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class startButton: RscButtonMenu
		{
			idc = 2400;
			font = "RobotoCondensed";
			align = "Center";

			text = "Start"; //--- ToDo: Localize;
			x = 0.443281 * safezoneW + safezoneX;
			y = 0.566 * safezoneH + safezoneY;
			w = 0.0556875 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.8};
		};
		class cancelButton: RscButtonMenu
		{
			idc = 2401;
			font = "RobotoCondensed";
			align = "Center";

			text = "Cancel"; //--- ToDo: Localize;
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.566 * safezoneH + safezoneY;
			w = 0.0556875 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.8};
		};
		class endScenarioButton: RscButtonMenu
		{
			idc = 2402;
			font = "RobotoCondensed";
			align = "Center";

			text = "End Scenario"; //--- ToDo: Localize;
			x = 0.510312 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class runningScenariosListbox: RscListBox
		{
			idc = 1500;

			x = 0.510312 * safezoneW + safezoneX;
			y = 0.489 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.044 * safezoneH;
			colorBackground[] = {0,0,0,0.8};
		};
		class runningScenariosText: RscText
		{
			idc = 1002;
			align = "Center";

			text = "Running Scenarios"; //--- ToDo: Localize;
			x = 0.510312 * safezoneW + safezoneX;
			y = 0.467 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.022 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////



	};
};

/* #Heziwu
$[
	1.063,
	["lzWarning",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1000,"lzWarningBackground",[1,"",["0.396875 * safezoneW + safezoneX","0.379 * safezoneH + safezoneY","0.20625 * safezoneW","0.198 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.8],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"lzWarningTitleBar",[1,"LZ Practice Warning",["0.396875 * safezoneW + safezoneX","0.379 * safezoneH + safezoneY","0.20625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.95],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"lzWarningMainText",[1,"The maximum of 2 LZ scenarios are currently running. Please wait or check current tasks in the map to join an active LZ scenario.",["0.427813 * safezoneW + safezoneX","0.423 * safezoneH + safezoneY","0.144375 * safezoneW","0.088 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,0],[-1,-1,-1,-1],"","-1"],[]],
	[2400,"lzWarningButton",[1,"OK",["0.469062 * safezoneW + safezoneX","0.533 * safezoneH + safezoneY","0.061875 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/



class lzWarning {
	idd = 690;
	movingEnable = false;
	enableSimulation = true;

	class controls {
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by [Capt] R.Klein, v1.063, #Heziwu)
		////////////////////////////////////////////////////////

		class lzWarningBackground: RscText
		{
			idc = 1000;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.20625 * safezoneW;
			h = 0.198 * safezoneH;
			colorBackground[] = {0,0,0,0.8};
		};
		class lzWarningTitleBar: RscText
		{
			idc = 1001;
			text = "LZ Practice Warning"; //--- ToDo: Localize;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.20625 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0,0,0,0.95};
		};
		class lzWarningMainText: RscStructuredText
		{
			idc = 1100;
			text = "The maximum of 2 LZ scenarios are currently running. Please wait or check current tasks in the map to join an active LZ scenario."; //--- ToDo: Localize;
			x = 0.427813 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.088 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
		};
		class lzWarningButton: RscButtonMenu
		{
			idc = 2400;
			text = "OK"; //--- ToDo: Localize;
			font = "RobotoCondensed";
			align = "Center";
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.022 * safezoneH;
			action = closeDialog 1;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////


	};
};
