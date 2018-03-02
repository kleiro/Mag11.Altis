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
nimObj = [[],[],[],[]];//nimObj nested array: [[objname1,objname2],[objtype1,objtype2],[objpos1,objpos2],[objrot1,objrot2]] Positions are in ASL
iterList = [[],[]]; //List of objects that has been in the safe zone, but not for 5 seconds, sorted: Object, Iterations in, Iterations passed
safeList = []; //List of objects previously in safe zone used in nimitzSafeZone script
a2aTargets =[[],[]]; //List of objects concerning the a2a zone, arrays: Player, Enemy Aircraft for Player
locationList = nearestLocations [[0,0,0], ["NameVillage","NameCity","NameCityCapital"], 25000];

respawnNimVeh = compile preprocessFileLineNumbers "respawnNimVeh.sqf";
nimitzSafeZone = compile preprocessFileLineNumbers "NimitzSafeZone.sqf";
localityChange = compile preprocessFileLineNumbers "LocalityChange.sqf";
a2aRange = compile preprocessFileLineNumbers "Air2AirRange.sqf";
a2aDestroyed = compile preprocessFileLineNumbers "a2aDestroyed.sqf";
a2aKilled = compile preprocessFileLineNumbers "a2aKilled.sqf";

timer = 1;
timer1 = 1;
[] spawn respawnNimVeh;