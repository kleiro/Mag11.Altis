/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:22:57 
 * @Last Modified by:   MoarRightRudder 
 * @Last Modified time: 2018-03-13 14:22:57 
 */
//smoke
//Spawns a green smoke every 65 seconds on the lz

params ["_taskName","_lzPos"];

while {missionNamespace getVariable ("taskState" + _taskName) == "Created"} do {
	"SmokeShellGreen" createVehicle _lzPos;
	uisleep 65;
};