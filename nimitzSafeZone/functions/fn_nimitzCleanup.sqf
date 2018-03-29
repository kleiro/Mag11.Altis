/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:24:28 
 * @Last Modified by:   MoarRightRudder 
 * @Last Modified time: 2018-03-13 14:24:28 
 */
//nimitzCleanup

params["_nimitz","_time"];

while {true} do {
	{
		if(damage _x == 1) then {deleteVehicle _x};
	}forEach ([_nimitz] call psq_fnc_unitsOnNimitz);
	uisleep _time;
};