/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:24:22 
 * @Last Modified by: MoarRightRudder
 * @Last Modified time: 2018-05-17 15:37:48
 */
//locateNimitzCarriers

private["_nimitzList"];
_nimitzList = [];

{
	if(["nimspots",str _x, false] call bis_fnc_inString) then {_nimitzList pushBack _x;};
}forEach vehicles;
diag_log format ["*** LNC OUTPUT: List - %1", _nimitzList];
{
	_x setVariable ["isNimInit",true];
	[_x] call psq_fnc_respawnNimitz;
	[_x] spawn psq_fnc_nimitzSafeZone;
	[_x, 60] spawn psq_fnc_nimitzCleanUp;
}forEach _nimitzList;