/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:23:07 
 * @Last Modified by:   MoarRightRudder 
 * @Last Modified time: 2018-03-13 14:23:07 
 */
//lzPracticeInclude
//To start lzPractice, lzDialog must be spawned

taskIndex = 100;
missionNamespace setVariable["lzTasks",[],true];
missionNamespace setVariable ["lzpDropOff",[15320.488,17455.217,0]];
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
"Kevin Bacon",
"McDonalds",
"Waffle House",
"Subway",
"Qdoba",
"Chipotle",
"Jersey Mikes",
"Skittles",
"KitKat",
"Skid Row",
"AYYLMAO"
]];
//Blufor spawn table
missionNamespace setVariable ["bluforSpawnTable", ["B_Soldier_SL_F","B_Soldier_AT_F","B_Soldier_LAT_F","B_Medic_F","B_Soldier_A_F","B_Soldier_AR_F"]];
//OpFor spawn table for each difficulty
//CfgGroups must be in their own arrays. Vehicles should be entered into one single array.
missionNamespace setVariable ["opforSpawnTable",
	[
		//Cold
		[],
		//Mild
		[[(configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >>"OIA_InfSquad"), 4]],
		//Hot
		[
			[(configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >>"OIA_InfSquad"), 5],
			[(configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AA"), 1],
			[["O_MRAP_02_hmg_F","O_MRAP_02_hmg_F"], 1]
		],
		//We gon Die
		[
			[(configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >>"OIA_InfSquad"), 5],
			[["O_MRAP_02_hmg_F","O_MRAP_02_hmg_F","O_APC_Tracked_02_AA_F"], 1]
		]
	]
];
