/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:21:12 
 * @Last Modified by:   MoarRightRudder 
 * @Last Modified time: 2018-03-13 14:21:12 
 */
//Air2AirInclude
//Requires a marker to be placed. Recommended dimensions are 1500x1500m

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

["a2aMkr", 2000] spawn psq_fnc_a2aRange; //Marker name, altitude of marker (air range will be +/- 500m of altitude)