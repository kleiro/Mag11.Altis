/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:26:19 
 * @Last Modified by: MoarRightRudder
 * @Last Modified time: 2018-03-28 18:49:22
 */
//psqInclude
//

missionNameSpace setVariable ["locationList", (nearestLocations [(getArray (configFile >> "CfgWorlds" >> worldName >> "CenterPosition")), ["NameVillage","NameCity","NameCityCapital"], 40000])];

[] spawn psq_fnc_safeZoneFinder;
[] spawn psq_fnc_damagedHeloPractice;