//heloCheck
//Checks for helos in the area around the lz and starts heloMon for them

params["_taskName","_lzPos","_bluPos"];

_helosInUse = [];
while {missionNamespace getVariable ("taskState" + _taskName) == "Created"} do {

	//When air units enter within 3500m of the lz, the ai will be activated
	if !(missionNamespace getVariable ["heloInArea", false]) then {

		_playerPresent = false;
		{
			{if(isPlayer _x) then {_playerPresent = true;};}forEach (crew _x);

			if(_playerPresent) then {
				{_x enableAI "all";}forEach (missionNamespace getVariable ("bluforUnitsList" + _taskName));
				{_x enableAI "all";}forEach (missionNamespace getVariable ("opforUnitsList" + _taskName));
				missionNamespace setVariable ["heloInArea", true];
			};

		}forEach (_lzPos nearEntities ["Air", 3500]);
	};

	//Each new helo that enters within 400m of the lz will have functions started to monitor their location for unit pickup/dropoff
	{
		if !(_x in _helosInUse) then {
			_helosInUse pushBack _x;
			_x allowCrewInImmobile true;

			_x setVariable ["isAlive", true];
			[_x,_taskName, _bluPos] spawn psq_fnc_heloMon;
			[_x, _lzPos, _taskName] spawn psq_fnc_lzMon;
			[_x,_taskName] spawn psq_fnc_delMon;
		};
	}forEach (_lzPos nearEntities ["Helicopter", 400]);
};