/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:26:19 
 * @Last Modified by:   MoarRightRudder 
 * @Last Modified time: 2018-03-13 14:26:19 
 */
//psqInclude
//

locationList = nearestLocations [(getArray (configFile >> "CfgWorlds" >> worldName >> "CenterPosition")), ["NameVillage","NameCity","NameCityCapital"], 40000];