//Air2AirInclude
//Requires a trigger (type none) with the following activation and statements:
//triggerActivation["Any Player","Present",true], triggerStatements["timer ==1", "[thisList] call a2aRange;", "timer1=1;"]
//timer can be initialized in initServer

a2aTargets =[[],[]]; //List of objects concerning the a2a zone, arrays: Player, Enemy Aircraft for Player

missionNameSpace setVariable ["EACSpawnTable", [
//Spawn table for enemy aircraft in the a2a range
"O_Plane_Fighter_02_Stealth_F",
"O_PLane_CAS_02_dynamicLoadout_F",
"rhs_mig29s_vvsc",
"rhs_mig29sm_vvsc",
"RHS_Su25SM_vvsc",
"RHS_t50_vvs_052",
"RHS_TU95MS_vvs_chelyabinsk",
"I_plane_fighter_04_f",
"I_plane_fighter_03_dynamicloadout_F",
"B_Plane_Fighter_01_Stealth_F",
"B_Plane_CAS_01_dynamicLoadout_F",
"FLAN_EA18G",
"C_Plane_civil_01_racing_f"
]];

missionNameSpace setVariable ["EACSet", +(missionNameSpace getVariable "EACSpawnTable")];
