if !(isServer) exitWith {};
params ["_victim", "_spawnPos", "_distance", "_mode"];

_medBayPC = (str _spawnPos)+"PC";
_medBayPC = missionNamespace getVariable [_medBayPC, objNull];
_counter = 0;
_woundcount = 0;

_victim disableai "move";
if (_mode == 1) then {_woundcount = 1 + round random 1;};
if (_mode == 2) then {_woundcount = 2 + round random 4;};
if (_mode == 3) then {_woundcount = 4 + round random 4;};

while {_counter <= _woundcount} do
{
	_bodypart = ["head", "body", "hand_l", "hand_r", "leg_l", "leg_r"] call BIS_fnc_selectRandom;
	_Size = 0.2 + random 0.5;
	//_amount = 1 + round random 4;
	_WoundType = ["bullet", "grenade", "explosive", "shell", "vehiclecrash", "backblast", "stab", "punch", "falling", "unknown"] call BIS_fnc_selectRandom;	
	[_victim, _bodyPart, 0, objNull, _woundType, 0, objNull, _size] call ace_medical_fnc_handleDamage_advanced;
	
	_counter = _counter + 1;	
};

if(_mode == 3 && (floor random 2 == 1)) then {
	[_victim] call ace_medical_fnc_setCardiacArrest;
};	

_victim disableai "all";
[_victim, _medBayPC] remoteExec ["psq_fnc_tibDelete", 0, false];

waituntil {isNull _victim || _victim distance _spawnpos > _distance || !alive _victim};
if(isNull _victim) exitWith {};
diag_log format["med OUTPUT: victim alive? %1", alive _victim];
//waituntil {(getPos _victim select 2 <= 0.3 && speed (vehicle _victim)  == 0)};

sleep 5;
deletevehicle _victim;