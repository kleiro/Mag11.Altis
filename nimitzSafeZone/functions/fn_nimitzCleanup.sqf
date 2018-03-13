//nimitzCleanup

params["_nimitz"];

while {true} do {
	{
		if(damage _x == 1) then {deleteVehicle _x};
	}forEach ([_nimitz] call psq_fnc_unitsOnNimitz);
	uisleep 20;
};