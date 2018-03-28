/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:22:46 
 * @Last Modified by:   MoarRightRudder 
 * @Last Modified time: 2018-03-13 14:22:46 
 */
//lzPractice

//Generates an extraction scenario randomly on the map. Friendly and enemy units will be placed first and made to engage each other. A suitable lz will be determined using bis_fnc_findsafepos. The helo will have to complete the mission within a given timeframe. The mission will start via a menu available on the nimitz. The player can select the type and number of helicopters being flown to the LZ, and how hot the LZ should be.


//---MAIN BODY
params["_hueys","_stals","_diff","_caller"];

diag_log format ["*** LZPractice OUTPUT: %1, %2, %3, %4", _hueys, _stals, _diff, _caller];

if !(isServer) exitWith {};

if(count (missionNamespace getVariable "lzTasks") > 1) exitWith {["lzWarning"] remoteExec ["createDialog",_caller,false];};
if(_hueys == 0 && _stals == 0) exitwith{};

_taskName = str(taskIndex);
taskIndex = taskIndex + 1;
_opforSpawnTable = (missionNamespace getVariable "opforSpawnTable") select _diff;
_location = selectRandom (missionNamespace getVariable "locationList");
_lzPos = [];
_lzSearchPos = [];
_bluPos = [];
_opfPos = [];

//Find locations for the lz, blufor, and opfor spawns
while {(count _lzPos) == 0} do {
	_lzSearchPos = (locationPosition _location) getPos [random 2500, random 359];
	_lzPos = [_lzSearchPos, 0, 125, 9, 0, .45, 0, [], []] call bis_fnc_findsafepos;
};

while {_bluPos isEqualTo [] && _opfPos isEqualTo []} do {
	_dir = random 359;
	_bluPos = (_lzPos) getPos [(random 150)+50, _dir];
	_opfPos = (_bluPos) getPos [(random 450)+450, _dir];
	if ((surfaceIsWater _bluPos) || (surfaceIsWater _opfPos)) then {
		_bluPos = [];
		_opfPos = [];
	};
};


_lzText = (selectRandom (missionNamespace getVariable "lzpNames"));



//Create the Marker and Task

_startTime = daytime;
_timeAddition = (((.016 * (_caller distance _lzPos)) + 32.869) + ((.016 * (_lzPos distance (missionNamespace getVariable "lzpDropOff"))) + 32.869) + 150) * .0033;

_deadline = _startTime + _timeAddition;
_deadlineSTR = [_deadline, "HH:MM:SS"] call BIS_fnc_timeToString;
[_taskName, _startTime, _deadline] spawn psq_fnc_lzTimer;

[west,_taskName,[format ["Extract the units from LZ %2 near %1 by %3", text _location, _lzText, _deadlineSTR], format ["LZ %2 near %1", text _location, _lzText], "Delivery Point"],(missionNamespace getVariable "lzpDropOff"),false,1,true] call BIS_fnc_taskCreate;
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
missionNamespace setVariable ["lzTasks", _tempArray, true];

//Create blufor groups based on the information passed by the gui
_count = _hueys + (_stals * 3);
_bluforUnitsList = [];

for "_i" from 1 to _count do {
	_bluforGroup = [_bluPos, WEST, (missionNamespace getVariable "bluforSpawnTable")] call BIS_fnc_spawnGroup;
	_bluforGroup deleteGroupWhenEmpty true;
	{
		_bluforUnitsList pushBack _x;
		_x allowDamage false;
		_x setSkill ["SpotDistance", 1];
		_x setSKill ["SpotTime", .95];
		_x disableAI "All";
	}forEach (units _bluforGroup);

};

//Spawn opfor units
_opforUnitsList = [];
{
	switch (typeName (_x select 0)) do {
		case ("CONFIG") : {
			for "_i" from 1 to (_x select 1) do {
				_opforGroup = [_opfPos, EAST,(_x select 0)] call BIS_fnc_spawnGroup;
				_opforGroup deleteGroupWhenEmpty true;
				_wp = _opforGroup addWaypoint [_bluPos, 50];
				{
					_opforUnitsList pushBack _x;
					_x setSkill ["SpotDistance", 1];
					_x setSkill ["SpotTime", 1];
					_x disableAI "all";
				}forEach (units _opforGroup);
			};
		};

		case ("ARRAY") : {
			{
				_veh = createVehicle [_x, _opfPos, [], 20, "NONE"];
				createVehicleCrew _veh;
				(group(driver _veh)) deleteGroupWhenEmpty true;
				_opforUnitsList append (crew _veh);
				{_x disableAI "all";}forEach (crew _veh);
				_dir = _bluPos getDir _opfPos;

				switch (true) do {
					case (_veh isKindof "Car") : {
						_wp = (group (driver _veh)) addWaypoint [(_bluPos getPos [(random 75) + 75, (random 30) + (_dir - 15)]), 10];
						_wp setWaypointType "move";
						_wp setWaypointSpeed "Limited";
					};

					case (_veh isKindof "APC_Tracked_02_base_f") : {
						_wp = (group (driver _veh)) addWaypoint [(_bluPos getPos [(random 100) + 200, (random 60) + (_dir - 30)]), 10];
						_wp setWaypointType "move";
						_wp setWaypointSpeed "Limited";
					};
				};
			}forEach (_x select 0);
		};
	};

}forEach _opforSpawnTable;

missionNamespace setVariable ["opforUnitsList" + _taskName, + _opforUnitsList];
missionNamespace setVariable ["bluforUnitsList" + _taskName, + _bluforUnitsList]; //Used to compare against for mission completion
missionNamespace setVariable ["pickupList" + _taskName, + _bluforUnitsList]; //Used by helos to know which units to pickup
missionNamespace setVariable ["taskState" + _taskName, "Created"];


[_taskName, _dialogArray] spawn psq_fnc_lzEnd;
[_taskName, _lzPos, _bluPos, _opforSpawnTable] spawn psq_fnc_heloCheck;
[_taskName, _lzPos] spawn psq_fnc_smoke;