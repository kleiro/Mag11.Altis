//a2aDestroyed
//Runs each time an enemy aircraft is destroyed. Checks if it is the last aircraft that was targeting a player, if it was, then begin a 20 second timer, then remove the player entry from the player a2a array and the enemy aircraft from it's array.

params ["_passed"];

_deadAircraft = _passed select 0;
_index = -1;

{
	if (_deadAircraft in _x) then {
		_index = _forEachIndex;
	};
}forEach (a2aTargets select 1);

diag_log format ["***OUTPUT: %1, %2, %3", _passed,(a2aTargets select 1), _index];

if ((count ((a2aTargets select 1) select _index)) < 2) then {
	uisleep 20;

	_pilot = (a2aTargets select 0) deleteAt _index;
	["A2A Range Ready"] remoteExec ["hint",_pilot];
	(a2aTargets select 1) deleteAt _index;
	_pilot removeEventHandler ["Killed", (_pilot getVariable "A2AEH")];

} else {
	((a2aTargets select 1) select _index) deleteAt (((a2aTargets select 1) select _index) find _deadAircraft);
};
