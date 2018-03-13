/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:20:34 
 * @Last Modified by:   MoarRightRudder 
 * @Last Modified time: 2018-03-13 14:20:34 
 */
//Air to air range
//Spawns enemy aircraft when an aircraft is inside the a2a zone

if !(isServer) exitWith {};

params["_marker","_altitude"];
_markerPos = (getMarkerPos _marker);
_markerPos set [2, _altitude];

while {true} do {
	_unitsList = (allPlayers - entities "headlesClient_f") inAreaArray [_markerPos, (getMarkerSize _marker) select 0, (getMarkerSize _marker) select 1, 0, false, 500];

	{
		if(side _x == west && !(_x in (a2aTargets select 0))) then {
			//Add the new participant to an array and add eventhandlers then spawn aircraft for them
			_player = _x;
			_index = (a2aTargets select 0) pushBack _player;

			_ehHandle = _player addEventHandler ["Killed", {[_this] spawn psq_fnc_a2aKilled;}];
			_player setVariable ["A2AEH", _ehHandle];

			_enemyAircraft = [];
			["Spawning Enemy Aircraft"] remoteExec ["Hint",_player];

			for "_i" from 1 to (missionNamespace getVariable ["A2ADiff", 1]) do {
				//Select an random aircraft from EACSet and select random location to spawn the aircraft
				_unitType = selectrandom (missionNamespace getVariable "EACSet");
				_dir = random 359;
				_rPos = _markerPos getPos [(random 7000) + 3000, _dir];
				_rPos set [2, (random 4800) + 200];
				//Spawn the aircraft
				_newUnit = createVehicle [_unitType,[0,0,0], [], 0, "FLY"];
				_newUnit setDir (_dir + 180);
				_newUnit setPos _rPos;
				//Create crew for the aircraft and delete their existing waypoints
				createVehicleCrew _newUnit;
				(crew _newUnit) joinSilent (createGroup [east, true]);
				[_newUnit] joinSilent (createGroup [east, true]);
				{deleteWaypoint _x;}forEach (waypoints (group (driver _newUnit)));
				//Set a loiter waypoint and reveal/target the player
				_wp = (group (driver _newUnit)) addWaypoint [_markerPos, 250];
				_wp setWaypointType "Loiter";
				{_x reveal (vehicle _player);_x doTarget (vehicle _player);_x setSkill 1;}forEach crew _newUnit;
				//Doesn't seem like these do much
				_newUnit allowCrewInImmobile true;
				_newUnit lock true;
				//Add aircraft to array of enemy aircraft for the player and add an eventhandler to the enemy aircraft
				_enemyAircraft pushBack _newUnit;
				_newUnit addEventHandler ["Killed", {[_this] spawn psq_fnc_a2aDestroyed;}];
			};
			//Add the enemy aircraft array to the main a2a array for tracking
			(a2aTargets select 1) pushBack _enemyAircraft;

		};

	}forEach _unitsList;
};