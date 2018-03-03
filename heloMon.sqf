//HeloMon.sqf
//Moniters helicopter's altitude and adds waypoints to passed groups if the helo has landed
//WP's are deleted if the helo takes off again

params ["_helo","_lzPos"];

_groupArray = _helo getVariable "Groups";
diag_log format ["***HeloMon OUTPUT: %1, %2", _helo, _groupArray];
_case = 0;
{
	{_x assignAsCargo _helo;}forEach (units _x);
}forEach _groupArray;

while {(_helo getVariable "HeloMonHandle")} do {
	switch (true) do {
		case (_case == 0 && (((getPosATL _helo) select 2) < .6)) : {

			{(units _x) orderGetIn true;}forEach _groupArray;

			_case = 1;
		};
		case (_case == 1 && (((getPosATL _helo) select 2) >= .6)) : {
			{
				{
					if ((_helo getCargoIndex _x) < 0) then {
						_x orderGetIn false;
						_x doFollow (leader _x);
					};
				}forEach (units _x);
			}forEach _groupArray;

			_case = 0;
		};
	};
	//Check if all units have boarded helo
	_helo setVariable ["HeloMonHandle", false];
	scopeName "main";
	{
		{
			if ((_helo getCargoIndex _x) < 0) then {
				_helo setVariable ["HeloMonHandle", true];
				breakTo "main";
			};
		}forEach (units _x);
	}forEach _groupArray;
};

diag_log "***HeloMon OUTPUT: Stopping Now";