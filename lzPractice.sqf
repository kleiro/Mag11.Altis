//lzPractice

//Generates an extraction scenario randomly on the map. Friendly and enemy units will be placed first and made to engage each other. A suitable lz will be determined using bis_fnc_findsafepos. The helo will have to complete the mission within a given timeframe. The mission will start via a menu available on the nimitz. The player can select the type and number of helicopters being flown to the LZ, and how hot the LZ should be.

//The extraction location will be chosen randomly based on arma 3 locations. A global variable must be made in init that retrieves all locations:
//nearestLocations [[0,0,0], ["NameVillage","NameCity","NameCityCapital"], 25000];

/*
1. Random location is selected and then a random position around it is determined for a landing site
2. Another random position is selected some meters away for spawning blufor units
3. Another position in the same direction even further away is selected for spawning opfor units
*/
params["_case","_hueys","_stals","_diff"];
diag_log format ["*** LZPractice OUTPUT: %1, %2, %3, %4", _case, _hueys, _stals, _diff];

if !(isServer) exitWith {};

if((lzPracticeList select 0) > 1) exitWith {["Maximum of 2 LZ scenarios at a time"] remoteExec ["hint",0,false];};
lzPracticeList set [0, (lzPracticeList select 0) + 1];
_lzPracticeNumber = lzPracticeList select 0;
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
_bluPos = (_lzPos) getPos [random 150, _dir];
_opfPos = (_bluPos) getPos [(random 700)+200, _dir];


//Create blufor groups based on the information passed by the gui
_count = _hueys + (_stals * 3);
lzPracticeList set [_lzPracticeNumber, 6 * _count];
_unassignedUnits = [];

//Probably more convenient now to add all units into one large array and then assign them as vehicle cargo as helo's show up
for "_i" from 1 to _count do {
	_bluGroup = [_bluPos, WEST, ["B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F"]] call BIS_fnc_spawnGroup;
	_bluGroup deleteGroupWhenEmpty true;
	{
		_unassignedUnits pushBack _x;
	}forEach (units _bluGroup);



	switch (_lzPracticeNumber) do
	{
		case 1: {
			{
				_x addEventHandler ["GetInMan", {
					lzPracticeList set [1, ((lzPracticeList select 1)-1)];
					{deleteWaypoint _x}forEach (waypoints (_this select 0));
					(_this select 0) allowDamage true;
				}];
			}forEach (units _bluGroup);
		};

		case 2: {
			{
				_x addEventHandler ["GetInMan", {
					lzPracticeList set [2, ((lzPracticeList select 2)-1)];
					{deleteWaypoint _x}forEach (waypoints (_this select 0));
					(_this select 0) allowDamage true;
				}];
			}forEach (units _bluGroup);
		};
	};
};

//Define opfor compositions here based upon difficulty settings

//Create the Task and notification
_locName = format ["Extract the units from the LZ near %1", text _location];
_taskName = "lzTask" + (str _lzPracticeNumber);
[west,_taskName,[_locName,("LZ Practice at " + (text _location)), ""],_lzPos,false,1,true] call BIS_fnc_taskCreate;
[_taskName, false] call BIS_fnc_taskSetAlwaysVisible;

//Create Triggers here for delivery of troops

//Get units into the helicopters once they arrive
_helosOld = [];
while {(lzPracticeList select _lzPracticeNumber) > 0} do {

	_helosNew = [];

	//Find helos within 100 meters

	_helosTemp = _lzPos nearEntities ["Helicopter", 100];
	{
		if !(_x in _helosOld) then { _helosNew pushBack _x};
	}forEach _helosTemp;


	//Remove waypoints if helos have left the area
	_markForDelete = [];
	{
		if !(_x in _helosTemp) then {
			diag_log format ["***LZP OUTPUT: Deleting %1", _x];
			_unassignedUnits append (_x getVariable "Units");
			_x setVariable ["HeloMonHandle", false];
			_markForDelete pushBack _x;
		};
	}forEach _helosOld;

	{_helosOld deleteAt (_helosOld find _x);}forEach _markForDelete;


	//Start helMon to monitor helo's altitude and add waypoints if below .6 ATL
	{
		_helo = _x;
		if (_helo emptyPositions "CARGO" > 0) then {

			diag_log format["***LZP OUTPUT: Starting heloMon for %1", _helo];

			_helo setVariable ["Units", (_unassignedUnits select [0, _helo emptyPositions "Cargo"])];
			_unassignedUnits deleteRange [0, _helo emptyPositions "Cargo"];

			_helo setVariable ["HeloMonHandle", true];
			_handle = [_helo, _lzPos] spawn heloMon;



			_helosOld pushBack _x;
		};
	}forEach _helosNew;
};
