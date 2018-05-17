if !(isServer) exitWith {};
params ["_spawnPos", "_distance", "_mode"];
_pos = getPosWorld _spawnPos;
_dir = (getDir _spawnpos);
_counter = 0;
_woundcount = 0;

_group = createGroup [civilian, true];
_victim =  _group createUnit ["b_survivor_f", _spawnpos, [], 0, "none"];
_victim setDir _dir;
_victim setPosWorld _pos;
[_victim, _spawnpos, _distance, _mode] call psq_fnc_tibCheck;