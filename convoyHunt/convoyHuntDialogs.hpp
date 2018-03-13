//convoyHuntDialogs

/* #Ropuka
$[
	1.063,
	["convoyHuntGUI",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[-1000,"convoyHuntBackground",[1,"",["0.4175 * safezoneW + safezoneX","0.313 * safezoneH + safezoneY","0.165 * safezoneW","0.154 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.8],[-1,-1,-1,-1],"","-1"],["idc = 1000;"]],
	[-1001,"convoyHuntTitleBar",[1,"Convoy Hunt",["0.4175 * safezoneW + safezoneX","0.313 * safezoneH + safezoneY","0.165 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.95],[-1,-1,-1,-1],"","-1"],["idc = 1001;"]],
	[-1002,"convoyHuntEnableAAText",[1,"Spawn AA in Convoy:",["0.438125 * safezoneW + safezoneX","0.357 * safezoneH + safezoneY","0.0773437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 1003;"]],
	[-2100,"convoyHuntEnableAACombo",[1,"",["0.525781 * safezoneW + safezoneX","0.357 * safezoneH + safezoneY","0.0360937 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 2101;"]],
	[-2400,"convoyHuntOKButton",[1,"Start",["0.505156 * safezoneW + safezoneX","0.434 * safezoneH + safezoneY","0.0515625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 2400;"]],
	[-2401,"convoyHuntCancelButton",[1,"Cancel",["0.443281 * safezoneW + safezoneX","0.434 * safezoneH + safezoneY","0.0515625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 2401;"]],
	[-2402,"convoyHuntEndHuntButton",[1,"End Current Hunt",["0.448438 * safezoneW + safezoneX","0.39 * safezoneH + safezoneY","0.103125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 2401;"]]
]
*/

class convoyHuntGUI {
	idd = 1630;
	movingEnable = false;
	enableSimulation = true;
	class controls {
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by [Capt] R.Klein, v1.063, #Ropuka)
		////////////////////////////////////////////////////////

		class convoyHuntBackground: RscText
		{
			idc = 1000;

			x = 0.4175 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.165 * safezoneW;
			h = 0.154 * safezoneH;
			colorBackground[] = {0,0,0,0.8};
		};
		class convoyHuntTitleBar: RscText
		{
			idc = 1001;

			text = "Convoy Hunt"; //--- ToDo: Localize;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.165 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0,0,0,0.95};
		};
		class convoyHuntEnableAAText: RscText
		{
			idc = 1003;

			text = "Spawn AA in Convoy:"; //--- ToDo: Localize;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class convoyHuntEnableAACombo: RscCombo
		{
			idc = 2101;

			x = 0.525781 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class convoyHuntOKButton: RscButtonMenu
		{
			idc = 2400;

			text = "Start"; //--- ToDo: Localize;
			x = 0.505156 * safezoneW + safezoneX;
			y = 0.434 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class convoyHuntCancelButton: RscButtonMenu
		{
			idc = 2401;

			text = "Cancel"; //--- ToDo: Localize;
			x = 0.443281 * safezoneW + safezoneX;
			y = 0.434 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class convoyHuntEndHuntButton: RscButtonMenu
		{
			idc = 2402;

			text = "End Current Hunt"; //--- ToDo: Localize;
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};