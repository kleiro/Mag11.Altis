//HeloMon.sqf
//Moniters helicopter's altitude and adds waypoints to passed groups if the helo has landed
//WP's are deleted if the helo takes off again


//---MAIN BODY
params ["_helo","_lzPracticeNum","_lzPos","_delPos"];

diag_log format ["***HeloMon OUTPUT: %1", _helo];

while {missionNamespace getVariable ("notComplete" + (str _lzPracticeNum))} do {

	//Check if helo is near the lz, landed, and not moving and has cargo space
	if ((_helo distance _lzPos) <= 125 && ((getPosATL _helo) select 2) < .6 && (speed _helo) < 1 && (_helo emptyPositions "Cargo") > 0) then {

		//Get units that need a ride from currentPickups and assign them as cargo
		_currentPickups = (missionNamespace getVariable ("pickUpList" + (str _lzPracticeNum)));
		_getInUnits = _currentPickups select [0, _helo emptyPositions "Cargo"];
		_currentPickups deleteRange [0, _helo emptyPositions "Cargo"];
		missionNamespace setVariable [("pickUpList" + (str _lzPracticeNum)), _currentPickups];
		{_x assignAsCargo _helo}forEach _getInUnits;


		//Hold script while helo is at the LZ and order the units to get in
		while{((_helo distance _lzPos) <= 125 && ((getPosATL _helo) select 2) < .6 && (speed _helo) < 1 && (_helo emptyPositions "Cargo") > 0)}  do {
			_getInUnits orderGetIn true;
		};

		//If units have gotten in the helicopter, then don't let them out and add them back to pickUpList
		_currentPickups = (missionNamespace getVariable ("pickUpList" + (str _lzPracticeNum)));
		{
			if ((_helo getCargoIndex _x) < 0) then {
				[_x] orderGetIn false;
				unassignVehicle _x;
				_currentPickups pushBack _x;
			};
		}forEach _getInUnits;
		missionNamespace setVariable [("pickUpList" + (str _lzPracticeNum)), _currentPickups];

	};

	if ((_helo distance _delPos) <= 125 && ((getPosATL _helo) select 2) < .6 && (speed _helo) < 1 && (_helo emptyPositions "Cargo") != 0) then {
		_unitsInHelo = fullCrew[_helo,"Cargo",false];
		_i = 0;
		while{((_helo distance _delPos) <= 125 && ((getPosATL _helo) select 2) < .6 && (speed _helo) < 1 && (_helo emptyPositions "Cargo") != 0 && _i < (count _unitsInHelo))} do {
			_man = (_unitsInHelo select _i) select 0;
			if !(isPlayer _man) then {
				[_man] orderGetIn false;
				unassignVehicle _man;
				_man join GrpNull;
				_man doMove _delPos;
				//_wp = (group _man) addWaypoint [_delPos, 0];
				//_wp setWaypointType "Move";
				//_man allowDamage false;
			};

			_i = _i + 1;
		};
	};
};
