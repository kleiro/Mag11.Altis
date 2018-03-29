/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:26:03 
 * @Last Modified by: MoarRightRudder
 * @Last Modified time: 2018-03-28 18:43:58
 */
//Cleanup

params ["_marker", "_time"];

while {true} do {
    {
    	if ((_x inArea _marker) && (damage _x) == 1) then {
    		deleteVehicle _x;
    	};
    } forEach ([_marker] call psq_fnc_unitsInArea);
	uisleep _time;
};
