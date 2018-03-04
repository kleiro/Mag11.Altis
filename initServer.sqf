/*
* @Author:  DnA
* @Profile: http://steamcommunity.com/id/dna_uk
* @Date:    2014-04-24 09:20:06
* @Last Modified by:   DnA
* @Last Modified time: 2014-06-14 07:42:39
*/

enableSaving [ false, false ];

//--- Singleplayer
if ( !isMultiplayer ) then {

	//--- Delete other switchable
	{ if ( !isPlayer _x ) then { deleteVehicle _x } } forEach switchableUnits;

};

locationList = nearestLocations [(getArray (configFile >> "CfgWorlds" >> worldName >> "CenterPosition")), ["NameVillage","NameCity","NameCityCapital"], 30000];

nimObj = [[],[],[],[]];//nimObj nested array: [[objname1,objname2],[objtype1,objtype2],[objpos1,objpos2],[objrot1,objrot2]] Positions are in ASL
iterList = [[],[]]; //List of objects that has been in the safe zone, but not for 5 seconds, format: Object, Iterations in, Iterations passed
safeList = []; //List of objects previously in safe zone used in nimitzSafeZone script
a2aTargets =[[],[]]; //List of objects concerning the a2a zone, arrays: Player, Enemy Aircraft for Player
taskIndex = 100;

missionNamespace setVariable["lzTasks",[]];
missionNamespace setVariable ["lzpDropOff",[14169.9,16264.5,0]];
missionNamespace setVariable ["lzpNames",[
"Budweiser",
"Heineken",
"Jack Daniels",
"Leinies",
"Miller",
"Raw Dog",
"FUBAR",
"Moonshine",
"Pooter",
"Landshark",
"Gaben",
"Bjork Bjork",
"Chippewa",
"Mississippi",
"Commiefornia",
"Corona",
"Grey Goose",
"Gordon",
"Hangover",
"OMGWTFBBQ",
"Bronco",
"Bulldog",
"Cactus",
"Brickyard",
"Charlie Brown",
"Cobra",
"Colt",
"Armalite",
"Dragon",
"Hurricane",
"Low Ball",
"Smelly Smell",
"Ranger",
"Snoopy",
"Dexter",
"Johnny Bravo",
"CatDog",
"Apollo",
"Saturn",
"Voyager",
"Enterprise",
"Tauri",
"Proxima",
"Milky Way",
"Kevin Bacon"
]];

respawnNimVeh = compile preprocessFileLineNumbers "respawnNimVeh.sqf";
nimitzSafeZone = compile preprocessFileLineNumbers "NimitzSafeZone.sqf";
localityChange = compile preprocessFileLineNumbers "LocalityChange.sqf";
a2aRange = compile preprocessFileLineNumbers "Air2AirRange.sqf";
a2aDestroyed = compile preprocessFileLineNumbers "a2aDestroyed.sqf";
a2aKilled = compile preprocessFileLineNumbers "a2aKilled.sqf";
damagedHelo = compile preprocessFileLineNumbers "damagedHeloPractice.sqf";
lzPractice = compile preprocessFileLineNumbers "lzPractice.sqf";
lzPracticeCancel = compile preprocessFileLineNumbers "lzPracticeCancel.sqf";
lzDialog = compile preprocessFileLineNumbers "lzDialog.sqf";
heloMon = compile preprocessFileLineNumbers "heloMon.sqf";

timer = 1;
timer1 = 1;
[] spawn respawnNimVeh;

DHP = 1;
diag_log "***InitServer Complete";
