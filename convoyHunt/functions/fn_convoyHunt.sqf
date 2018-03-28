/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:21:31 
 * @Last Modified by:   MoarRightRudder 
 * @Last Modified time: 2018-03-13 14:21:31 
 */
//convoyHunt

diag_log format["*** CVH OUTPUT: Starting cvh"];

while{true} do {
	if(missionNamespace getVariable ["convoyHuntEnabled", false]) then {
		//Activates when convoyhunt is enabled and there is no active convoy hunt

		_spawnPos = selectRandom (missionNamespace getVariable "convoySpawnLocations");
		_startLoc = (nearestLocations [_spawnPos select 0, ["NameCity", "NameCityCapital","NameMarine","NameVillage","NameLocal"],2500,_spawnPos select 0]) select 0;

		_endLoc = _startLoc;
		while{_endLoc == _startLoc || (_endLoc distance (_spawnPos select 0)) < 4000} do {
			_endLoc = selectRandom (missionNamespace getVariable "locationList");
		};

		//Create task
		[west, "convoyHunt", [format["An enemy convoy is leaving %1 for %2. Destroy all vehicles before they reach their destination.", text _startLoc, text _endLoc], "Destroy the Convoy", "Convoy Destination"], position _endLoc, false, 0, true, "Destroy", false] call BIS_fnc_taskCreate;
		["convoyHunt", "Created"] call BIS_fnc_taskSetState;

		_convoySpawnList = ((missionNamespace getVariable "convoySpawnList") select (missionNamespace getVariable "convoyAA"));
		missionNamespace setVariable ["convoyUnitsAlive", (count _convoySpawnList)];

		_convoyVehicles = [];
		_convoyUnits = [];

		//Spawn the composition
		for "_i" from 0 to ((ceil((count _convoySpawnList) / 2)) - 1) do {
			_spawnedObjects = [_spawnPos select 0, _spawnPos select 1, (_convoySpawnList select [_i * 2, 2])] call bis_fnc_objectsMapper;
			{
				createVehicleCrew _x;

				_x setVariable["Crew", crew _x];
				_x setVariable["alive", true];

				{_convoyUnits pushBack _x;}forEach (crew _x);
				_convoyVehicles pushBack _x;

				_x addEventHandler["dammaged", {
						if(!(canMove (_this select 0)) && ((_this select 0) getVariable "alive")) then {
							(_this select 0) setVariable ["alive", false];
							_tArr = missionNamespace getVariable "convoyUnitsAlive";
							_tArr = _tArr - 1;
							missionNamespace setVariable ["convoyUnitsAlive", _tArr];
						};
					} //dont add a semicolon here
				];

				_x addEventHandler["GetOut", {
						if((_this select 0) getVariable "alive") then {
							(_this select 0) setVariable ["alive", false];
							_tArr = missionNamespace getVariable "convoyUnitsAlive";
							_tArr = _tArr - 1;
							missionNamespace setVariable ["convoyUnitsAlive", _tArr];
						};
					} //no semicolon here either
				];

			_group = group _x;
			{deleteWaypoint _x}forEach (waypoints _group);
			_wp = _group addWaypoint [getPos _endLoc, 0, 0];
			_wp setWaypointType "Move";
			_wp setWaypointBehaviour "Careless";
			_wp setWaypointForceBehaviour true;
			_x limitSpeed 60;
			_group setCombatMode "Yellow";
			_group setCurrentWaypoint _wp;
			uisleep .8;

			[_x, _wp] spawn psq_fnc_isGlitched;
			[_x] spawn psq_fnc_bridgeCheck;
			}forEach _spawnedObjects;

			waitUntil {(count ((_spawnPos select 0) nearEntities ["LandVehicle", 50])) == 0};
		};

		missionNamespace setVariable ["convoyUnits", _convoyUnits];


		//Wait until convoy has reached its destination OR convoyUnitsAlive == 0
		while{missionNamespace getVariable "convoyUnitsAlive" != 0 && (missionNamespace getVariable ["convoyArrived", false]) isEqualTo false} do {
			{
				if(_x in _convoyVehicles) then {
					missionNamespace setVariable ["convoyArrived",true];
				};
			}forEach ((getPos _endLoc) nearEntities ["landVehicle", 150]);
		};
		if(missionNamespace getVariable "convoyArrived" isEqualTo true) then {uisleep 120;};

		switch (true) do {
			case (missionNamespace getVariable "convoyUnitsAlive" == 0) : {
				["convoyHunt", "Succeeded"] call BIS_fnc_taskSetState;
				{deleteVehicle _x;}forEach _convoyUnits;
				{deleteVehicle _x;}forEach _convoyVehicles;
			};
			case(missionNamespace getVariable "convoyArrived" isEqualTo true) : {
				["convoyHunt", "Failed"] call BIS_fnc_taskSetState;
				{deleteVehicle _x;}forEach _convoyUnits;
				{deleteVehicle _x;}forEach _convoyVehicles;
			};
			case (missionNamespace getVariable "convoyArrived" isEqualTo "canceled") : {
				{deleteVehicle _x;}forEach _convoyUnits;
				{deleteVehicle _x;}forEach _convoyVehicles;
			};
		};

		uisleep 10;
		["convoyHunt"] call BIS_fnc_deleteTask;

		missionNamespace setVariable ["convoyHuntEnabled", false];
		missionNamespace setVariable ["convoyArrived", false];
	};
};
