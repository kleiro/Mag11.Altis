/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:22:42 
 * @Last Modified by:   MoarRightRudder 
 * @Last Modified time: 2018-03-13 14:22:42 
 */
//lzMon

params["_helo","_lzPos","_taskName"];
_getInUnits = [];

while{missionNamespace getVariable ("taskState" + _taskName) == "Created" && (_helo getVariable "isAlive")} do {
	//Check if helo is near the lz, landed, and not moving and has cargo space and has not ordered units in already
	if ((_helo distance _lzPos) <= 150 && ((getPosATL _helo) select 2) < .6 && (speed _helo) < 1 && (_helo emptyPositions "Cargo") > 0) then {
		diag_log "running lzMon pickup active";
		{["Units Boarding -- HOLD"] remoteExec ["hint",_x,false];}forEach (crew _helo);

		//Get units that need a ride from currentPickups and assign them as cargo
		_currentPickups = (missionNamespace getVariable ("pickUpList" + _taskName));
		_getInUnits = _currentPickups select [0, _helo emptyPositions "Cargo"];
		_currentPickups deleteRange [0, _helo emptyPositions "Cargo"];
		missionNamespace setVariable [("pickUpList" + _taskName), _currentPickups];
		{_x assignAsCargo _helo; [_x] orderGetIn true;}forEach _getInUnits;

		_dust = 0;
		if(count _getInUnits == 0) then {_dust = 1;} else {
			{
				["Units Boarding -- HOLD"] remoteExec ["hint",_x,false];
			}forEach (crew _helo);
		};

		while{(_helo distance _lzPos) <= 150 && ((getPosATL _helo) select 2) < .6 && (speed _helo) < 1 && _dust == 0 && (_helo getVariable "isAlive")} do {

			_allIn = true;
			{
				if ((_helo getCargoIndex _x) < 0) then {_allIn = false;};
			}forEach _getInUnits;

			if(_allIn || (_helo emptyPositions "Cargo") == 0) then {
				_dust = 1;
				if(_helo getVariable "isAlive") then {
					{["All In! -- DUST DUST DUST!"] remoteExec ["hint",_x,false];}forEach (crew _helo);
				};

			};
		};
		//wait until helo has moved away from the lz

		diag_log "running lzMon pickup end";
		_currentPickups = (missionNamespace getVariable ("pickUpList" + _taskName));
		{
			//If any units did not get in the helo, then tell them to remain at the lz
			if ((_helo getCargoIndex _x) < 0) then {
				[_x] orderGetIn false;
				unassignVehicle _x;
				_currentPickups pushBack _x;
			} else {
				//Have the unit start monitoring if they've reached the delivery position
				if (!(isPlayer _x) &&  (_x getVariable ["moveOutUnit", 0]) == 0)then {
					[_x,_helo] spawn psq_fnc_moveUnit;
				};
			};
		}forEach _getInUnits;
		_getInUnits = [];
		missionNamespace setVariable [("pickUpList" + _taskName), _currentPickups];
	};
};