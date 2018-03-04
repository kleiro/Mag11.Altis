//HeloMon.sqf
//Moniters helicopter's altitude and adds waypoints to passed groups if the helo has landed
//WP's are deleted if the helo takes off again

/////////////////////////////////////////////////
//Functions
/////////////////////////////////////////////////

//--fnc_moveOutUnit -Makes units move to the delivery position for deletion once out of the helo
fnc_moveOutUnit = {
	params["_man","_helo","_delPos"];
	_man setVariable["moveOutUnit", 1];
	//_case = 0;
	waitUntil {isNull objectParent _man};

	[_man] join grpNull;
	(group _man) move _delPos;
	_man allowDamage false;
};

/////////////////////////////////////////////////


//---MAIN BODY
params ["_helo","_lzPracticeNum","_lzPos","_delPos"];

diag_log format ["***HeloMon OUTPUT: %1", _helo];
_case = 0;

while {missionNamespace getVariable ("notComplete" + (str _lzPracticeNum)) && _case == 0} do {

	//Check if helo is near the lz, landed, and not moving and has cargo space
	if ((_helo distance _lzPos) <= 150 && ((getPosATL _helo) select 2) < .6 && (speed _helo) < 1 && (_helo emptyPositions "Cargo") > 0) then {

		//Get units that need a ride from currentPickups and assign them as cargo
		_currentPickups = (missionNamespace getVariable ("pickUpList" + (str _lzPracticeNum)));
		_getInUnits = _currentPickups select [0, _helo emptyPositions "Cargo"];
		_currentPickups deleteRange [0, _helo emptyPositions "Cargo"];
		missionNamespace setVariable [("pickUpList" + (str _lzPracticeNum)), _currentPickups];
		{_x assignAsCargo _helo}forEach _getInUnits;


		//Hold script while helo is at the LZ and order the units to get in
		while{((_helo distance _lzPos) <= 150 && ((getPosATL _helo) select 2) < .6 && (speed _helo) < 1 && (_helo emptyPositions "Cargo") > 0)}  do {
			_getInUnits orderGetIn true;
		};

		//If units have gotten in the helicopter, then don't let them out and add them back to pickUpList
		_currentPickups = (missionNamespace getVariable ("pickUpList" + (str _lzPracticeNum)));
		{
			if ((_helo getCargoIndex _x) < 0) then {

				[_x] orderGetIn false;
				unassignVehicle _x;
				_currentPickups pushBack _x;

			} else {

				if (!(isPlayer _x) &&  (_x getVariable ["moveOutUnit", 0]) == 0)then {
					[_x,_helo,_delPos] spawn fnc_moveOutUnit;
					_x allowDamage true;
				};

			};
		}forEach _getInUnits;

		missionNamespace setVariable [("pickUpList" + (str _lzPracticeNum)), _currentPickups];\
	};

	//Check if the helo is near the drop point and drop off units if so
	if ((_helo distance _delPos) <= 200 && ((getPosATL _helo) select 2) < .6 && (speed _helo) < 1) then {

		_unitsInHelo = fullCrew[_helo,"Cargo",false];
		_i = 0;

		while{((_helo distance _delPos) <= 200 && ((getPosATL _helo) select 2) < .6 && (speed _helo) < 1 && _i < (count _unitsInHelo))} do {

			_man = (_unitsInHelo select _i) select 0;

			if !(isPlayer _man) then {
				_man allowDamage false;
				_man action ["getOut",_helo];
				[_man] allowGetIn false;
				[_man] orderGetIn false;
				uisleep .75;
			};

			_i = _i + 1;
		};
	};

	//If helo is not alive or disabled, remove the units inside from the lzp master list & delete them
	if(!(alive _helo) || (_helo getHitPointDamage "HitHRotor") >= .9 || (_helo getHitPointDamage "HitEngine") >= .9) then {
		_case = 1;
		{
			_man = _x select 0;
			_masterList = (missionNamespace getVariable ("masterUnitsList" + (str _lzPracticeNum)));
			_masterList deleteAt (_masterList find _man);
			missionNamespace setVariable [("masterUnitsList" + (str _lzPracticeNum)), _masterList];
			deleteVehicle _man;
		}forEach (fullCrew[_helo,"Cargo",false]);
	};

};