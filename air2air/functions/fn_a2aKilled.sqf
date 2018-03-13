/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:20:30 
 * @Last Modified by:   MoarRightRudder 
 * @Last Modified time: 2018-03-13 14:20:30 
 */
//a2aKilled
//Runs when a player with enemy aircraft targeting them dies. If there are other players with aircraft engaging them, then the dead player's enemy aircraft are reassigned and told to target other players. If there are no other players, the enemy aircraft are deleted.

params ["_passed"];

_deadPlayer = _passed select 0;

_index = (a2aTargets select 0) find _deadPlayer;

_enemyAircraft = +((a2aTargets select 1) select _index);


(a2aTargets select 0) deleteAt _index;
(a2aTargets select 1) deleteAt _index;

if ((count (a2aTargets select 0)) != 0) then {
	_newAssignment = floor random (count (a2aTargets select 0));
	_player = (a2aTargets select 0) select _newAssignment;

	{
		((a2aTargets select 1) select _newAssignment) pushBack _x;
		{
			_x reveal (vehicle _player);
			_x doTarget (vehicle _player);

		}forEach crew _x;

	}forEach _enemyAircraft;
} else {
	{
		_veh = _x;
		{_veh deleteVehicleCrew _x}forEach (crew _veh);
		deleteVehicle _veh;
	}forEach _enemyAircraft;
};
_deadPlayer removeEventHandler ["Killed", (_deadPlayer getVariable "A2AEH")];

