//Cleanup

params ["_trigger", "_time"];

while {true} do {
    {
    	if ((_x inArea _trigger) && (damage _x) == 1) then {
    		deleteVehicle _x;
    	};
    } forEach vehicles;
	sleep _time;
};
