/*
* @Author:  DnA
* @Profile: http://steamcommunity.com/id/dna_uk
* @Date:    2014-06-04 17:32:06
* @Last Modified by:   DnA
* @Last Modified time: 2014-06-09 01:44:17
*/

class DNA_Race
{
	tag = "DNA";
	class Race
	{
		file = "race\functions";
		class markerRelativeDirTo;
		class raceHint;
		class raceInit
		{
			preInit = 1;
		};
		class raceManager
		{
			ext = ".fsm";
		};
		class raceUpdateLap;
		class raceUpdateStage;
		class raceUpdateTime;
	};
};

class PSQ_Race
{
	tag = "PSQ";
	class functions{
		file = "race\functions";
		class kartAction;
		class raceReset;
	};
};