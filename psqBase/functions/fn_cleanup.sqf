/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:26:03 
 * @Last Modified by:   MoarRightRudder 
 * @Last Modified time: 2018-03-13 14:26:03 
 */
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
