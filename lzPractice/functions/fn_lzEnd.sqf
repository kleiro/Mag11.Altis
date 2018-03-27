/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:22:32 
 * @Last Modified by:   MoarRightRudder 
 * @Last Modified time: 2018-03-13 14:22:32 
 */
//lzEnd
//checks for units within 20 meters of the delivery point and deletes them & ends the practice scenario
params ["_taskName","_dialogArray"];
_despawned = 0;

while {_despawned < (count (missionNamespace getVariable ("bluforUnitsList" + _taskName))) && missionNameSpace getVariable ("taskState" + _taskName) == "Created"} do {
	uisleep 5;
	mkfDelete = [];
	{
		if ((_x distance (missionNamespace getVariable "lzpDropOff")) < 30 && (isNull objectParent _x)) then {
			mkfDelete pushBack _x;
			deleteVehicle _x;
			_despawned = _despawned + 1;
		};
	}forEach (missionNamespace getVariable ("bluforUnitsList" + _taskName));
	if (_despawned == (count (missionNamespace getVariable ("bluforUnitsList" + _taskName)))) then {
		missionNamespace setVariable ["taskState" + _taskName, "Succeeded"];
	}
};


//Delete task from lzTasks
_tempArray = missionNamespace getVariable "lzTasks";
_tempArray deleteAt (_tempArray find _dialogArray);
missionNamespace setVariable ["lzTasks", _tempArray, true];
switch (missionNamespace getVariable ("taskState" + _taskName)) do {
	case "Canceled" : {
		//Delete blufor & opfor units & vehicles
		{deleteVehicle _x;}forEach (missionNamespace getVariable ('bluforUnitsList' + _taskName));
		{deleteVehicle (vehicle _x); deleteVehicle _x;}forEach (missionNamespace getVariable ('opforUnitsList' + _taskName));

		//Delete task & marker
		[_taskName, "Canceled", true] call BIS_fnc_taskSetState;
	};
	case "Succeeded" : {
		//Delete opfor units & vehicles
		{deleteVehicle _x;}forEach (missionNamespace getVariable ('opforUnitsList' + _taskName));

		//Delete task & marker
		[_taskName, "Succeeded", true] call BIS_fnc_taskSetState;
	};
	case "TimeOut" : {
		//Delete blufor & opfor units & vehicles
		{deleteVehicle _x;}forEach (missionNamespace getVariable ('bluforUnitsList' + _taskName));
		{deleteVehicle (vehicle _x); deleteVehicle _x;}forEach (missionNamespace getVariable ('opforUnitsList' + _taskName));

		//Delete task & marker
		[_taskName, "Failed", true] call BIS_fnc_taskSetState;
	};
};

deleteMarker (_dialogArray select 2);

//Delete associated mNs vars
missionNamespace setVariable ['opforUnitsList' + _taskName, nil];
missionNamespace setVariable ['bluforUnitsList' + _taskName, nil];
missionNamespace setVariable ['taskState' + _taskName, nil];
missionNamespace setVariable ['pickupList' + _taskName, nil];

uisleep 10;
[_taskName] call BIS_fnc_deleteTask;