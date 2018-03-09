//Nimitz Safe Zone
//Adds and removes objects to invulnerability list
//_thisList is passed from trigger
//If a vehicle and it's crew are inside the safe zone for 5 iterations (~5 seconds, damage will be disabled)

if !(isServer) exitWith {};

timer = 0;

params ["_tList"];
safeList sort true;
_tList sort true;

if !(safeList isEqualTo _tList) then {

	//Check for objects that have left the safe zone (_tList) compared to the last check (safeList) and enable damage on them (must be enabled locally hence remoteExec)
	_safeListRemoval = [];
	{
		_object = _x;
		if !(_object in _tList) then {
			_crew = fullCrew _object;
			{
				_man = _x select 0;
				[_man, true] remoteExec ["allowDamage", _man];
				_safeListRemoval pushBack _man;
				_man setVariable ["enableDamage", true];
			}forEach _crew;

			[_x, true] remoteExec ["allowDamage", _x];
			_safeListRemoval pushBack _x;
			_x setVariable ["enableDamage", true];
		};


	}forEach safeList;

	//Delete objects that have left the safe zone from safeList
	{
		safeList deleteAt (safeList find _x);
	}forEach _safeListRemoval;


	//Check for objects that have ENTERED the safe zone (_tList) compared to what is currently inside (safeList) and disable damage on them after 5 iterations
	//If the object is a man, then damage must be disabled immediately
	_iterList = +iterList;
	iterList = [[],[]];
	{
		_object = _x;
		if !(_object in safeList) then {
			if (_object isKindOf "Man") then {

				[_x, false] remoteExec ["allowDamage", _x];
				safeList pushBackUnique _x;
				_x setVariable ["enableDamage", false];

			} else {

				if !(_object in (_iterList select 0)) then {
					(iterList select 0) pushBack _object;
					(iterList select 1) pushBack 1;

				} else {

					_index = (_iterList select 0) find _object;

					if (((_iterList select 1) select _index) < 5) then {

						_iteration = ((_iterList select 1) select _index) + 1;

						if (_iteration > 4) then {

							_x setVariable ["enableDamage", false];
							_crew = fullCrew _object;
							{
								_man = _x select 0;
								[_man, false] remoteExec ["allowDamage", _man];
								safeList pushBackUnique _man;
								_man setVariable ["enableDamage", false];
							}forEach _crew;

							[_x, false] remoteExec ["allowDamage", _x];
							safeList pushBackUnique _x;
							_x removeAllEventHandlers "Local";
							_x addEventHandler ["local", {
								if (!(_this select 1) && !(isNull (_this select 0))) then {
									[(_this select 0)] remoteExec ["localityChange", (_this select 0)];
								};
							}];
						} else {
							(iterList select 0) pushBack _object;
							(iterList select 1) pushBack _iteration;
						};
					};
				};
			};
		};
	}forEach _tList;

};