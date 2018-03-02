//RKleinsdialogs.hpp

/* #Wevece
$[
	1.063,
	["LZPracticeGUI",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[-1000,"lzPracticeBackground",[1,"",["0.381406 * safezoneW + safezoneX","0.346 * safezoneH + safezoneY","0.226875 * safezoneW","0.242 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.65],[-1,-1,-1,-1],"","-1"],[]],
	[-1001,"lzPracticeTitleBar",[1,"Landing Zone Practice",["0.381406 * safezoneW + safezoneX","0.346 * safezoneH + safezoneY","0.226875 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[0.05,0.05,0.05,0.98],[-1,-1,-1,-1],"","-1"],[]],
	[-2100,"uh1yCombo",[1,"",["0.474219 * safezoneW + safezoneX","0.445 * safezoneH + safezoneY","0.0309375 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-2101,"ch53Combo",[1,"",["0.474219 * safezoneW + safezoneX","0.5 * safezoneH + safezoneY","0.0309375 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-2102,"difficultyCombo",[1,"",["0.474219 * safezoneW + safezoneX","0.39 * safezoneH + safezoneY","0.113437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1002,"uh1yText",[1,"UH-1Y's to be used:",["0.391719 * safezoneW + safezoneX","0.445 * safezoneH + safezoneY","0.0773437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1003,"ch53Text",[1,"CH-53's to be used:",["0.391719 * safezoneW + safezoneX","0.5 * safezoneH + safezoneY","0.0773437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1004,"difficultyText",[1,"Difficulty:",["0.391719 * safezoneW + safezoneX","0.39 * safezoneH + safezoneY","0.04125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2400,"startButton",[1,"Start",["0.515469 * safezoneW + safezoneX","0.544 * safezoneH + safezoneY","0.0567187 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,0.8],[-1,-1,-1,-1],"","-1"],[]],
	[2401,"cancelButton",[1,"Cancel",["0.4175 * safezoneW + safezoneX","0.544 * safezoneH + safezoneY","0.0567187 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,0.8],[-1,-1,-1,-1],"","-1"],[]]
]
*/


class lzDialog {
	idd = 69;
	movingEnable = false;
	enableSimulation = true;

	class controls {
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by [Capt] R.Klein, v1.063, #Wevece)
		////////////////////////////////////////////////////////

		class lzPracticeBackground: RscText
		{
			idc = 1000;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.226875 * safezoneW;
			h = 0.242 * safezoneH;
			colorBackground[] = {0,0,0,0.65};
		};
		class lzPracticeTitleBar: RscText
		{
			idc = 1001;
			text = "Landing Zone Practice"; //--- ToDo: Localize;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.226875 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.05,0.05,0.05,0.98};
		};
		class uh1yCombo: RscCombo
		{
			idc = 2100;
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class ch53Combo: RscCombo
		{
			idc = 2101;
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class difficultyCombo: RscCombo
		{
			idc = 2102;
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class uh1yText: RscText
		{
			idc = 1002;
			text = "UH-1Y's to be used:"; //--- ToDo: Localize;
			x = 0.391719 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class ch53Text: RscText
		{
			idc = 1003;
			text = "CH-53's to be used:"; //--- ToDo: Localize;
			x = 0.391719 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class difficultyText: RscText
		{
			idc = 1004;
			text = "Difficulty:"; //--- ToDo: Localize;
			x = 0.391719 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class startButton: RscButtonMenu
		{
			idc = 2400;
			text = "Start"; //--- ToDo: Localize;
			font = "RobotoCondensed";
			align = "Center";
			x = 0.515469 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.8};
		};
		class cancelButton: RscButtonMenu
		{
			idc = 2401;
			text = "Cancel"; //--- ToDo: Localize;
			font = "RobotoCondensed";
			align = "Center";
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.8};
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};



