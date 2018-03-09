//smoke
//Spawns a green smoke every 65 seconds on the lz

params ["_taskName","_lzPos"];

while {missionNamespace getVariable ("taskState" + _taskName) == "Created"} do {
	"SmokeShellGreen" createVehicle _lzPos;
	uisleep 65;
};