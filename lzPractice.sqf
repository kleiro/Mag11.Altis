//lzPractice

//Generates an extraction scenario randomly on the map. Friendly and enemy units will be placed first and made to engage each other. A suitable lz will be determined using bis_fnc_findsafepos. The helo will have to complete the mission within a given timeframe. The mission will start via a menu available on the nimitz. The player can select the type and number of helicopters being flown to the LZ, and how hot the LZ should be.

/////////////////////////////////////////////////
//Functions
/////////////////////////////////////////////////

//---fnc_unitDespawn checks for units within 20 meters of the delivery point and deletes them
fnc_unitDespawn = {

	params ["_taskName","_dialogArray"];
	_despawned = 0;

	while {_despawned < (count (missionNamespace getVariable ("masterUnitsList" + _taskName)))} do {
		uisleep 5;
		mkfDelete = [];
		{
			if ((_x distance (missionNamespace getVariable "lzpDropOff")) < 30 && (isNull objectParent _x)) then {
				mkfDelete pushBack _x;
				deleteVehicle _x;
				_despawned = _despawned + 1;
			};
		}forEach (missionNamespace getVariable ("masterUnitsList" + _taskName));
	};
	missionNamespace setVariable ["notComplete" + _taskName, false];
	_tempArray = missionNamespace getVariable "lzTasks";
	_tempArray deleteAt (_tempArray find _dialogArray);
	missionNamespace setVariable ["lzTasks", _tempArray];
	missionNamespace setVariable ['masterUnitsList' + _taskName, nil];
	missionNamespace setVariable ['notComplete' + _taskName, nil];
	missionNamespace setVariable ['pickupList' + _taskName, nil];

	[_taskName, "Succeeded", true] call BIS_fnc_taskSetState;
	deleteMarker (_dialogArray select 2);

	uisleep 10;
	[_taskName] call BIS_fnc_deleteTask;
};

//---fnc_heloCheck -Checks for helos in the area around the lz and starts heloMon for  them
fnc_heloCheck = {
	params["_taskName", "_helosInUse", "_lzPos","_bluPos"];

	while {missionNamespace getVariable ("notComplete" + _taskName)} do {
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

	while {missionNamespace getVariable ("notComplete" + _taskName)} do {
		"SmokeShellGreen" createVehicle _lzPos;
		uisleep 65;
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////


//---MAIN BODY
params["_hueys","_stals","_diff","_caller"];

diag_log format ["*** LZPractice OUTPUT: %1, %2, %3, %4", _hueys, _stals, _diff, _caller];

if !(isServer) exitWith {};

if(count (missionNamespace getVariable "lzTasks") > 1) exitWith {["lzWarning"] remoteExec ["createDialog",_caller,false];};
if(_hueys == 0 && _stals == 0) exitwith{};

_taskName = str(taskIndex);
taskIndex = taskIndex + 1;
_location = selectRandom locationList;
_lzPos = [];
_lzSearchPos = [];
_bluPos = [];
_opfPos = [];

//Find locations for the lz, blufor, and opfor spawns
while {(count _lzPos) == 0} do {
	_lzSearchPos = (locationPosition _location) getPos [random 1000, random 359];
	_lzPos = [_lzSearchPos, 0, 125, 9, 0, .45, 0, [], []] call bis_fnc_findsafepos;
};

while {_bluPos isEqualTo [] && _opfPos isEqualTo []} do {
	_dir = random 359;
	_bluPos = (_lzPos) getPos [(random 150)+50, _dir];
	_opfPos = (_bluPos) getPos [(random 700)+200, _dir];
	if ((surfaceIsWater _bluPos) || (surfaceIsWater _opfPos)) then {
		_bluPos = [];
		_opfPos = [];
	};
};


_lzText = (selectRandom (missionNamespace getVariable "lzpNames"));



//Create the Marker and Task


[west,_taskName,[format ["Extract the units from LZ %2 near %1", text _location, _lzText], format ["LZ %2 near %1", text _location, _lzText], "Delivery Point"],(missionNamespace getVariable "lzpDropOff"),false,1,true] call BIS_fnc_taskCreate;
[_taskName, "Created"] call BIS_fnc_taskSetState;
[_taskName, false] call BIS_fnc_taskSetAlwaysVisible;

_lzMarker = createMarker [_taskName, _lzPos];
_lzMarker setMarkerType "hd_pickup";
_lzMarker setMarkerColor "ColorGreen";
_lzMarker setMarkerText _lzText;

//For listbox in dialog and cancellation
_dialogArray = [(_lzText + " @ " + (text _location)), _taskName, _lzMarker];
_tempArray = missionNamespace getVariable "lzTasks";
_tempArray pushBack _dialogArray;
missionNamespace setVariable ["lzTasks", _tempArray];

//Create blufor groups based on the information passed by the gui
_count = _hueys + (_stals * 3);
_masterUnitsList = [];

for "_i" from 1 to _count do {
	_bluGroup = [_bluPos, WEST, ["B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_F"]] call BIS_fnc_spawnGroup;
	_bluGroup deleteGroupWhenEmpty true;
	{
		_masterUnitsList pushBack _x;
		_x allowDamage false;
	}forEach (units _bluGroup);

};

missionNamespace setVariable ["masterUnitsList" + _taskName, + _masterUnitsList]; //Used to compare against and delete from in case of unit death
missionNamespace setVariable ["pickupList" + _taskName, + _masterUnitsList]; //Used by helos to know which units to pickup
missionNamespace setVariable ["notComplete" + _taskName, true];

//Define opfor compositions here based upon difficulty settings


_helosInUse = [];
[_taskName, _dialogArray] spawn fnc_UnitDespawn;
[_taskName, _helosInUse, _lzPos, _bluPos] spawn fnc_heloCheck;
[_taskName, _lzPos] spawn fnc_smoke;