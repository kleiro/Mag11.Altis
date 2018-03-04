//lzPracticeCancel
//Cancels lz practice and its related scripts

params ["_index"];

if(count (missionNamespace getVariable 'lzTasks') > 0) then {
		_array = ((missionNamespace getVariable 'lzTasks') select _index);
		_task = _array select 1;

		//Delete the task in mNs var 'lzTasks'
		_lzTasks = (missionNamespace getVariable 'lzTasks');
		_lzTasks deleteAt (_lzTasks find _array);
		missionNamespace setVariable ['lzTasks', _lzTasks];

		//End all lzPractice scripts
		missionNamespace setVariable ['notComplete' + _task, false];

		//Delete all blufor units associated with the task
		{deleteVehicle _x;}forEach (missionNamespace getVariable ('masterUnitsList' + _task));

		//Delete the marker and set the task to canceled
		deleteMarker (_array select 2);
		[_task, 'Canceled', true] call BIS_fnc_taskSetState;

		//Delete associated vars
		missionNamespace setVariable ['masterUnitsList' + _task, nil];
		missionNamespace setVariable ['notComplete' + _task, nil];
		missionNamespace setVariable ['pickupList' + _task, nil];

		//Delete the task after 5 seconds
		uisleep 5;
		[_task] call BIS_fnc_deleteTask;
};