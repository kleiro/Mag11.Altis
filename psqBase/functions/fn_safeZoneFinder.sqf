/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-28 18:43:28 
 * @Last Modified by: MoarRightRudder
 * @Last Modified time: 2018-03-28 19:13:48
 */

//Safe Zone marker finder
//Finds all markers that begin with "safeZone" (not case sensitive)
if !(isServer) exitWith {};

{

	if(_x select [0, 8] == "safeZone") then {
		[_x] spawn psq_fnc_vehicleRespawn;
		[_x] spawn psq_fnc_safeZone;
		[_x, 60] spawn psq_fnc_cleanup;
	};
}forEach allMapMarkers;
