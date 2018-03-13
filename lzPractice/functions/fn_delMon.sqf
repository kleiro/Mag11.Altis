/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:22:18 
 * @Last Modified by:   MoarRightRudder 
 * @Last Modified time: 2018-03-13 14:22:18 
 */
//delMon

params["_helo","_taskName"];

_delPos = missionNamespace getVariable "lzpDropOff";

while{missionNamespace getVariable ("taskState" + _taskName) == "Created" && (_helo getVariable "isAlive")} do {

	//Check if the helo is near the drop point and drop off units if so
	if ((_helo distance _delPos) <= 200 && ((getPosATL _helo) select 2) < .6 && (speed _helo) < 1) then {

		_unitsInHelo = fullCrew[_helo,"Cargo",false];
		_i = 0;

		while{((_helo distance _delPos) <= 200 && ((getPosATL _helo) select 2) < .6 && (speed _helo) < 1 && _i < (count _unitsInHelo)) && (_helo getVariable "isAlive")} do {

			_man = (_unitsInHelo select _i) select 0;

			if !(isPlayer _man) then {
				_man setVariable ["arrived", true];
				_man action ["getOut",_helo];
				[_man] allowGetIn false;
				[_man] orderGetIn false;
				uisleep .75;
			};

			_i = _i + 1;
		};
	};
};