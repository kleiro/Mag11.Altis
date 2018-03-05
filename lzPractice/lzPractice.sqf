//lzPractice

//Generates an extraction scenario randomly on the map. Friendly and enemy units will be placed first and made to engage each other. A suitable lz will be determined using bis_fnc_findsafepos. The helo will have to complete the mission within a given timeframe. The mission will start via a menu available on the nimitz. The player can select the type and number of helicopters being flown to the LZ, and how hot the LZ should be.

#include "functions.sqf"

//---MAIN BODY
params["_hueys","_stals","_diff","_caller"];

diag_log format ["*** LZPractice OUTPUT: %1, %2, %3, %4", _hueys, _stals, _diff, _caller];

if !(isServer) exitWith {};

if(count (missionNamespace getVariable "lzTasks") > 1) exitWith {["lzWarning"] remoteExec ["createDialog",_caller,false];};
if(_hueys == 0 && _stals == 0) exitwith{};

_taskName = str(taskIndex);
taskIndex = taskIndex + 1;
_opforSpawnTable = (missionNamespace getVariable "_opfSpawnTable") select _diff;
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
	_opfPos = (_bluPos) getPos [(random 450)+300, _dir];
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
_bluforUnitsList = [];

for "_i" from 1 to _count do {
	_bluforGroup = [_bluPos, WEST, ["B_Soldier_SL_F","B_Soldier_F","B_Soldier_LAT_F","B_Medic_F","B_Soldier_A_F","B_Soldier_AR_F"]] call BIS_fnc_spawnGroup;
	_bluforGroup deleteGroupWhenEmpty true;
	{
		_bluforUnitsList pushBack _x;
		_x allowDamage false;
	}forEach (units _bluforGroup);

};

//Create opfor groups based on the difficulty setting
_opforUnitsList = [];
{
	for "_i" from 1 to (_x select 1) do {
		_opforGroup = [_opfPos, EAST,_x select 0] call BIS_fnc_spawnGroup;
		_opforGroup deleteGroupWhenEmpty true;
		_wp = _opforGroup addWaypoint [_bluPos, 50];
		_wp setWaypointType "Sentry";
		{
			_opforUnitsList pushBack _x;
			_veh = assignedVehicle _x;
			if (!(isNull _veh) && !(_veh in _opforUnitsList)) then {
				_opforUnitsList pushBack _veh;
			};
		}forEach (units _opforGroup);

	};
}forEach _opforSpawnTable;

missionNamespace setVariable ["bluforUnitsList" + _taskName, + _bluforUnitsList]; //Used to compare against for mission completion
missionNamespace setVariable ["opforUnitsList" + _taskName, + _opforUnitsList];
missionNamespace setVariable ["pickupList" + _taskName, + _bluforUnitsList]; //Used by helos to know which units to pickup
missionNamespace setVariable ["taskState" + _taskName, "Created"];

_helosInUse = [];
[_taskName, _dialogArray] spawn fnc_lzEnd;
[_taskName, _helosInUse, _lzPos, _bluPos] spawn fnc_heloCheck;
[_taskName, _lzPos] spawn fnc_smoke;