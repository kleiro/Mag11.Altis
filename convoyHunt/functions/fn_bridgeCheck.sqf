//bridgeCheck
params["_veh","_pushDir"];

while {missionNamespace getVariable "convoyUnitsAlive" != 0 && (missionNamespace getVariable ["convoyArrived", false]) isEqualTo false && _veh getVariable "alive"} do {
	{
		if(["bridge",str _x, false] call bis_fnc_inString) then {
			_xAxis = ((boundingBox _x) select 0) select 0;
			_yAxis = ((boundingBox _x) select 0) select 1;
			_vehDir = getDir _veh;
			_vel = velocity _veh;
			_bridgeDir = getDir _x;
			_bridgeDirArray = [_bridgeDir + 90, _bridgeDir + 270];
			{
				if(_x >= 360) then {
					_bridgeDirArray set [_forEachIndex, _x - 360];
				};
			}forEach _bridgeDirArray;

			switch (true) do {
				case (_vehDir >= (_bridgeDirArray select 0) && _vehDir <= (_bridgeDirArray select 1)) : {
					_pushDir = [(sin _bridgeDir) + ((_vel select 0) * 1.2), (cos _bridgeDir) + ((_vel select 1) * 1.2), _vel select 2];
				};
				default {
					_bridgeDir = _bridgeDir + 180;
					_pushDir = [(sin _bridgeDir) + ((_vel select 0) * 1.2), (cos _bridgeDir) + ((_vel select 1) * 1.2), _vel select 2];
				};
			};
			while{_veh in ([_veh] inAreaArray [getPos _x, _xAxis, _yAxis, getDir _x, true, 20])} do {
				_veh setVelocity _pushDir;
				uisleep .2;
			};
		};
	}forEach (nearestTerrainObjects [_veh, [], 100, true]);
};