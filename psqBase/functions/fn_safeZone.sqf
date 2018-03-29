/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-28 17:05:07 
 * @Last Modified by: MoarRightRudder
 * @Last Modified time: 2018-03-28 19:41:18
 */

//SafeZone
//Creates a safe zone for players and vehicles within rectangular markers labeled safeZone_x

if !(isServer) exitWith {};

params["_marker"];

_oldList = [];
_newIterList = [[],[]];
{
	[player, ["getInMan", {
		player allowDamage (player getVariable ["enableDamage", true]);
	}]] remoteExec ["addEventHandler", 0, true];

}forEach allPlayers;

while {true} do {

    _oldList sort true;
	_newList = [_marker] call psq_fnc_unitsInArea;

	if(!(_oldList isEqualTo _newList)) then {
		
		//First check for objects that have left the safe zone and enable damage on them
		_oldListRemoval = [];
		{
			_object = _x;
			if !(_object in _newList) then {
				_crew = fullCrew _object;
				{
					_man = _x select 0;
					[_man, true] remoteExec ["allowDamage", _man];
					_oldListRemoval pushBack _man;
					_man setVariable ["enableDamage", true];
				}forEach _crew;

				[_object, true] remoteExec ["allowDamage", _object];
				_oldListRemoval pushBack _object;
				_object setVariable ["EnableDamage", true, true];
			};
		}forEach _oldList;

		//Delete objects that have left the safe zone from _oldList
		{
			_oldList deleteAt (_oldList find _x);
		}forEach _oldListRemoval;

		//Check for objects that have entered the safe zone
		_oldIterList = +_newIterList;
		_newIterList = [[],[]];
		{
			_object = _x;
			if !(_object in _oldList) then {
				if (_object isKindOf "Man") then {

					[_object, false] remoteExec ["allowDamage", _object];
					_oldList pushBackUnique _object;
					_object setVariable ["enableDamage", false, true];

				} else {

					if !(_object in (_oldIterList select 0)) then {
						(_newIterList select 0) pushBack _object;
						(_newIterList select 1) pushBack 1;

					} else {

						_index = (_oldIterList select 0) find _object;

						if (((_oldIterList select 1) select _index) < 5) then {

							_iteration = ((_oldIterList select 1) select _index) + 1;

							if (_iteration > 4) then {

								_object setVariable ["enableDamage", false, true];
								_crew = fullCrew _object;
								{
									_man = _x select 0;
									[_man, false] remoteExec ["allowDamage", _man];
									_oldList pushBackUnique _man;
									_man setVariable ["enableDamage", false, true];
								}forEach _crew;

								[_object, false] remoteExec ["allowDamage", _object];
								_oldList pushBackUnique _object;
								_object removeAllEventHandlers "Local";
								_object addEventHandler ["local", {
									if (!(_this select 1) && !(isNull (_this select 0))) then {
										[(_this select 0), ((_this select 0) getVariable "enableDamage")] remoteExec ["allowDamage", (_this select 0)];
										[(_this select 0)] remoteExec ["localityChange", (_this select 0)];
									};
								}];
							} else {
								(_newIterList select 0) pushBack _object;
								(_newIterList select 1) pushBack _iteration;
							};
						};
					};
				};
			};
		}forEach _newList; 
	};
	uisleep 1;
};