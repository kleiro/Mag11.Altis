//Nimitz Safe Zone
//Adds and removes objects to invulnerability list
//_thisList is passed from trigger
//If a vehicle and it's crew are inside the safe zone for 5 iterations (~5 seconds, damage will be disabled)

if !(isServer) exitWith {};

params ["_nimitz"];

_oldList = [];
_newIterList = [[],[]];

while {true} do {
	_oldList sort true;
	_newList = [_nimitz] call psq_fnc_unitsOnNimitz;

	if !(_oldList isEqualTo _newList) then {

		//Check for objects that have left the safe zone (_newList) compared to the last check (_oldList) and enable damage on them (must be enabled locally hence remoteExec)
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

				[_x, true] remoteExec ["allowDamage", _x];
				_oldListRemoval pushBack _x;
				_x setVariable ["enableDamage", true];
			};


		}forEach _oldList;

		//Delete objects that have left the safe zone from _oldList
		{
			_oldList deleteAt (_oldList find _x);
		}forEach _oldListRemoval;


		//Check for objects that have ENTERED the safe zone (_newList) compared to what is currently inside (_oldList) and disable damage on them after 5 iterations
		//If the object is a man, then damage must be disabled immediately
		_oldIterList = +_newIterList;
		_newIterList = [[],[]];
		{
			_object = _x;
			if !(_object in _oldList) then {
				if (_object isKindOf "Man") then {

					[_x, false] remoteExec ["allowDamage", _x];
					_oldList pushBackUnique _x;
					_x setVariable ["enableDamage", false];

				} else {

					if !(_object in (_oldIterList select 0)) then {
						(_newIterList select 0) pushBack _object;
						(_newIterList select 1) pushBack 1;

					} else {

						_index = (_oldIterList select 0) find _object;

						if (((_oldIterList select 1) select _index) < 5) then {

							_iteration = ((_oldIterList select 1) select _index) + 1;

							if (_iteration > 4) then {

								_x setVariable ["enableDamage", false];
								_crew = fullCrew _object;
								{
									_man = _x select 0;
									[_man, false] remoteExec ["allowDamage", _man];
									_oldList pushBackUnique _man;
									_man setVariable ["enableDamage", false];
								}forEach _crew;

								[_x, false] remoteExec ["allowDamage", _x];
								_oldList pushBackUnique _x;
								_x removeAllEventHandlers "Local";
								_x addEventHandler ["local", {
									if (!(_this select 1) && !(isNull (_this select 0))) then {
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