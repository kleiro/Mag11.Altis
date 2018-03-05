//functions

/////////////////////////////////////////////////
//Functions
/////////////////////////////////////////////////

//---fnc_lzEnd checks for units within 20 meters of the delivery point and deletes them & ends the practice scenario
fnc_lzEnd = {

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
	};
	//End associated functions with taskname
	if (missionNameSpace getVariable ("taskState" + _taskName) != "Canceled") then {
		missionNamespace setVariable ["taskState" + _taskName, "Succeeded"];
	};

	//Delete task from lzTasks
	_tempArray = missionNamespace getVariable "lzTasks";
	_tempArray deleteAt (_tempArray find _dialogArray);
	missionNamespace setVariable ["lzTasks", _tempArray];
	switch (missionNamespace getVariable ("taskState" + _taskName)) do {
		case "Canceled" : {
			//Delete blufor & opfor units & vehicles
			{deleteVehicle _x;}forEach (missionNamespace getVariable ('bluforUnitsList' + _task));
			{deleteVehicle _x;}forEach (missionNamespace getVariable ('opforUnitsList' + _task));

			//Delete task & marker
			[_taskName, "Canceled", true] call BIS_fnc_taskSetState;
		};
		case "Succeeded" : {
			//Delete opfor units & vehicles
			{deleteVehicle _x;}forEach (missionNamespace getVariable ('opforUnitsList' + _task));

			//Delete task & marker
			[_taskName, "Canceled", true] call BIS_fnc_taskSetState;
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
};

//---fnc_heloCheck -Checks for helos in the area around the lz and starts heloMon for  them
fnc_heloCheck = {
	params["_taskName", "_helosInUse", "_lzPos","_bluPos"];

	while {missionNamespace getVariable ("taskState" + _taskName) == "Created"} do {
		{
			if !(_x in _helosInUse) then {
				_helosInUse pushBack _x;
				_x allowCrewInImmobile true;
				[_x,_taskName,_lzPos,_bluPos] spawn heloMon;
			};
		}forEach (_lzPos nearEntities ["Helicopter", 400]);
	};
};

//---fnc_Smoke -Spawns a green smoke every 65 seconds on the lz
fnc_smoke = {
	params ["_taskName","_lzPos"];

	while {missionNamespace getVariable ("taskState" + _taskName) == "Created"} do {
		"SmokeShellGreen" createVehicle _lzPos;
		uisleep 65;
	};
};

//--fnc_moveUnit -Makes units move to the delivery position for deletion once out of the helo
fnc_moveUnit = {
	params["_man","_helo","_delPos"];
	_man setVariable["moveOutUnit", 1];
	_script = _thisScript;
	while {!(isNull objectParent _man) || !(_man getVariable ["arrived",false])} do {if(isNull _man) then {terminate _thisScript;};};

	[_man] join grpNull;
	(group _man) move _delPos;
};


/////////////////////////////////////////////////////////////////////////////////////////////