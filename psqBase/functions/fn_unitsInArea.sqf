/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-28 17:53:46 
 * @Last Modified by: MoarRightRudder
 * @Last Modified time: 2018-05-17 16:34:22
 */

//Units in Area

params["_marker"];
_units = [];

if((typeName _marker) == "String") then {
	_units = vehicles inAreaArray [getMarkerPos _marker, (markerSize _marker) select 0, (markerSize _marker) select 1, MarkerDir _marker, true, 20];
	_units append (playableUnits inAreaArray [getMarkerPos _marker, (markerSize _marker) select 0, (markerSize _marker) select 1, MarkerDir _marker, true, 20]);
} else {
	diag_log format["UIA OUPUT: %1", _marker];
	_units = vehicles inAreaArray [getPos _marker, (triggerArea _marker) select 0, (triggerArea _marker) select 1, getDir _marker, true, 20];
	_units append (playableUnits inAreaArray [getPos _marker, (triggerArea _marker) select 0, (triggerArea _marker) select 1, getDir _marker, true, 20]);
};


_units