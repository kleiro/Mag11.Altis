//lzPractice

//Generates an extraction scenario randomly on the map. Friendly and enemy units will be placed first and made to engage each other. A suitable lz will be determined using bis_fnc_findsafepos. The helo will have to complete the mission within a given timeframe. The mission will start via a menu available on the nimitz. The player can select the type and number of helicopters being flown to the LZ, and how hot the LZ should be.

//The extraction location will be chosen randomly based on arma 3 locations. A global variable must be made in init that retrieves all locations:
//nearestLocations [[0,0,0], ["NameVillage","NameCity","NameCityCapital"], 25000];

/*
1. Random location is selected and then a random position around it is determined for a landing site
2. Another random position is selected some meters away for spawning blufor units
3. Another position in the same direction even further away is selected for spawning opfor units
*/
params["_case","_hueys","_stals","_diff","_bluUnits"];
diag_log format ["*** LZPractice OUTPUT: %1, %2, %3, %4, %5", _case, _hueys, _stals, _diff, _bluUnits];
switch (_case) do{

	case 0 : {
		//spawns when a practice lz is initially being generated
		if((lzPracticeList select 0) > 1) exitWith {["Maximum of 2 LZ scenarios at a time"] remoteExec ["hint",0,false];};

		_location = selectRandom locationList;
		_lzPos = [];
		_lzSearchPos = [];
		_bluPos = [];
		_opfPos = [];


		while {(count _lzPos) == 0} do {
			_lzSearchPos = (locationPosition _location) getPos [random 1000, random 359];
			_lzPos = [_lzSearchPos, 0, 100, 8, 0, .45, 0, [], []] call bis_fnc_findsafepos;
		};

		_dir = random 359;
		_bluPos = (_lzPos) getPos [random 500, _dir];
		_opfPos = (_bluPos) getPos [(random 700)+200, _dir];


		//Define blufor compositions here based upon helicopters being used
		_bSpawnHuey = ["B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F"];
		_bSpawnStal = ["B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F"];

		//Spawn groups and set their parameters and commands
		_bluSpawn = [];

		//instead of using global variables, just have the dialog pass the variables to this script when pressing the "create" button or whatever
		for "_i" from 1 to (_hueys) do {_bluSpawn append _bSpawnHuey;};
		for "_i" from 1 to (_stals) do {_bluSpawn append _bSpawnStal;};

		_bluGroup = [_bluPos, WEST, _bluSpawn] call BIS_fnc_spawnGroup;
		_bluGroup deleteGroupWhenEmpty true;

		//Huey unit "clusters"
		_i = 0;
		_n = 0;
		while {_i < _hueys} do {
			_bluUnits = [];
			for "_o" from _n to (_n + ((count _bSpawnHuey)-1)) do {
				_man = ((units _bluGroup) select _o);
				_man allowDamage false;
				_bluUnits pushBack _man;
				_n = _n + 1;
			};
			[1,_hueys,_stals,_diff,_bluUnits] spawn lzPractice;
			_i = _i + 1;
		};

		//Stallion unit "clusters"
		_i = 0;
		while {_i < _stals} do {
			_bluUnits = [];
			for "_o" from _n to (_n + ((count _bSpawnStal)-1)) do {
				_man = ((units _bluGroup) select _n);
				_man allowDamage false;
				_bluUnits pushBack _man;
				_n = _n + 1;
			};
			[1,_hueys,_stals,_diff,_bluUnits] spawn lzPractice;
			_i = _i + 1;
		};

		//Define opfor compositions here based upon difficulty settings
		_locName = format ["Extract the units from the LZ near %1", text _location];
		[west,"lzTask1",[_locName,("LZ Practice at " + (text _location)), ""],_lzPos,false,1,true] call BIS_fnc_taskCreate;

	};

	case 1 : {
		//spawns for each individual "cluster" of blufor units waiting for a helicopter
		_case = count _bluUnits;

		switch (_case) do
		{
			case 6: {
				//UH1Y

			};

			case 24 : {
				//CH53

			};
		};
	};
};


while {bluRemaining > 0} do {

};