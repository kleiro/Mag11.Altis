/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:21:40 
 * @Last Modified by:   MoarRightRudder 
 * @Last Modified time: 2018-03-13 14:21:40 
 */
//isGlitched

params["_veh","_wp"];
uisleep 10;
while{missionNamespace getVariable "convoyUnitsAlive" != 0 && (missionNamespace getVariable ["convoyArrived", false]) isEqualTo false && _veh getVariable "alive"} do {

	diag_log format["***IG OUTPUT: looping %1", _veh];
	_lastPos = getPos _veh;

	uisleep 30;

	if(_veh getVariable "alive" && ((getPos _veh) distance _lastPos) < 5) then {

		diag_log format["***IG OUTPUT: %1 is stuck", _veh];
		_veh setPos (_veh getPos [10, (getDir _veh) + 180]);
		(group _veh) setCurrentWaypoint _wp;
		_lastPos = getPos _veh;

		uisleep 30;

		if(_veh getVariable "alive" && ((getPos _veh) distance _lastPos) < 5) then {
			diag_log format["***IG OUTPUT: Removing %1", _veh];
			_veh setVariable ["alive", false];
			_tArr = missionNamespace getVariable "convoyUnitsAlive";
			_tArr = _tArr - 1;
			missionNamespace setVariable ["convoyUnitsAlive", _tArr];
		};
	};
};