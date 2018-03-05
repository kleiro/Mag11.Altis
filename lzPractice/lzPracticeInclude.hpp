//lzPracticeInclude
//To start lzPractice, lzDialog must be spawned

locationList = nearestLocations [(getArray (configFile >> "CfgWorlds" >> worldName >> "CenterPosition")), ["NameVillage","NameCity","NameCityCapital"], 30000];
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

//OpFor spawn table for each difficulty
missionNamespace setVariable ["opforSpawnTable", [
//Mild
[["OIA_InfSquad", 3]],
//Hot
[["OIA_InfSquad", 4], ["OIA_InfTeam_AA", 1], ["OIA_MotInf_MGTeam", 2]],
//We gon Die
[["OIA_InfSquad", 4], ["OIA_MotInf_MGTeam", 2], ["OIA_TankPLatoon_AA", 1]]
]];

lzPractice = compile preprocessFileLineNumbers "lzpractice\lzPractice.sqf";
lzPracticeCancel = compile preprocessFileLineNumbers "lzpractice\lzPracticeCancel.sqf";
lzDialog = compile preprocessFileLineNumbers "lzpractice\lzDialog.sqf";
heloMon = compile preprocessFileLineNumbers "lzpractice\heloMon.sqf";
damagedHelo = compile preprocessFileLineNumbers "lzPractice\damagedHeloPractice.sqf";