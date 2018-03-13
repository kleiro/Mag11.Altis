//psqInclude
//

locationList = nearestLocations [(getArray (configFile >> "CfgWorlds" >> worldName >> "CenterPosition")), ["NameVillage","NameCity","NameCityCapital"], 40000];