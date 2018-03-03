//HeloMon.sqf
//Moniters helicopter's altitude and adds waypoints to passed groups if the helo has landed
//WP's are deleted if the helo takes off again

params ["_helo","_lzPos"];

_unitArray = _helo getVariable "Units";
diag_log format ["***HeloMon OUTPUT: %1, %2", _helo, _unitArray];
_case = 0;
{
	_x assignAsCargo _helo;
}forEach _unitArray;

while {(_helo getVariable "HeloMonHandle")} do {
	switch (true) do {

		case (_case == 0 && (((getPosATL _helo) select 2) < .6)) : {
			_unitArray orderGetIn true;
			_case = 1;
		};

		case (_case == 1 && (((getPosATL _helo) select 2) >= .6)) : {
			{
				if ((_helo getCargoIndex _x) < 0) then {
					_x orderGetIn false;
				};
			}forEach _unitArray;
			_case = 0;
		};
	};


	//Check if all units have boarded helo
	_helo setVariable ["HeloMonHandle", false];
	scopeName "main";

	{
		if ((_helo getCargoIndex _x) < 0) then {
			_helo setVariable ["HeloMonHandle", true];
			breakTo "main";
		};
	}forEach _unitArray;

};

diag_log "***HeloMon OUTPUT: Stopping Now";