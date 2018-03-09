//HeloMon

params ["_helo","_taskName","_bluPos"];

while {missionNamespace getVariable ("taskState" + _taskName) == "Created" && (_helo getVariable "isAlive")} do {
	_crewDead = true;
	{if(isPlayer _x && alive _x) then {_crewDead = false;};}forEach (crew _helo);
	//If helo is not alive or disabled, move units back to the bluforSpawn
	if((damage _helo) == 1 || (_helo getHitPointDamage "HitHRotor") >= .9 || (_helo getHitPointDamage "HitEngine") >= .9 || (fuel _helo) == 0 || _crewDead) then {
		diag_log "Helo's dead dude";
		_helo setVariable ["isAlive", false];
		_currentPickups = (missionNamespace getVariable ("pickUpList" + _taskName));
		{
			_man = _x select 0;
			_man setPos _bluPos;
			[_man] orderGetIn false;
			unassignVehicle _man;
			_currentPickups pushBack _man;
		}forEach (fullCrew[_helo,"Cargo",false]);
		missionNamespace setVariable [("pickUpList" + _taskName), _currentPickups];
	};

};