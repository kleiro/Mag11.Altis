/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-28 17:37:30 
 * @Last Modified by: MoarRightRudder
 * @Last Modified time: 2018-05-17 15:46:23
 */

//Vehicle Respawn
//Gathers all editor placed vehicles at the beginning of a mission and respawns them if they are destroyed


if !(isServer) exitWith {};

params["_mkORobj"];

if ((typeName _mkORobj) == "STRING") then {
	
	//initialization section (only runs once at the beginning of the mission)
	//gathers information on all editor-placed vehicles within the marker
	diag_log format["VEHRESP OUTPUT: Running for:::::::: %1", _mkORobj];
	_marker = _mkORobj;
	_unitList = [_marker] call psq_fnc_unitsInArea;

	{
		if (_x isKindOf "Air" || _x isKindOf "LandVehicle" || _x isKindOf "ReammoBox_F") then {
			//Add vehicle name, type, posWorld, and dir to vehicle data arrays
			_vehs = +(missionNamespace getVariable ["VehName",[]]);
			_vehs pushBack (str _x);
			missionNamespace setVariable ["VehName", _vehs];
			_x setVariable ["name", (str _x)];

			_types = +(missionNamespace getVariable ["VehType", []]);
			_types pushBack (typeOf _x);
			missionNamespace setVariable ["VehType", _types];

			_pos = +(missionNamespace getVariable ["VehPos", []]);
			_pos pushBack (getPosWorld _x);
			missionNamespace setVariable ["VehPos", _pos];

			_dirs = +(missionNamespace getVariable ["VehDir", []]);
			_dirs pushBack (getDir _x);
			missionNamespace setVariable ["VehDir", _dirs];

			_dhp = +(missionNamespace getVariable ["VehDHP", []]);
			_dhp pushBack (_x getVariable ["DHP", false]);
			missionNamespace setVariable ["VehDHP", _dhp];

			_mkrs = +(missionNamespace getVariable ["VehMarker", []]);
			_mkrs pushBack _marker;
			missionNamespace setVariable ["VehMarker", _mkrs];
			
			//Add mpKilled event handler that will execute this script again after firing
			_x addMPEventHandler ["MPKilled", {
				[_this select 0] spawn psq_fnc_vehicleRespawn; 
				diag_log format ["*** killed object: %1", _this select 0];
			}];
		};
	}forEach _unitList;

	diag_log (format ["***Placed vehicles: %1", missionNamespace getVariable ["VehName",[]]]);
	diag_log (format ["***Placed vehicle types: %1", missionNamespace getVariable ["VehType",[]]]);

} else {
	if((typeName _mkORobj) == "OBJECT") then {
		//Section that's run when the mpKilled event handler fires
		//This creates a new vehicle in the original starting position of the old one

		_object = _mkORobj;
		_objectName = (_object getVariable "name");

		uisleep 28;
		_index = (missionNamespace getVariable "VehName") find _objectName;

		_type = (missionNamespace getVariable "VehType") select _index;
		_pos = (missionNamespace getVariable "VehPos") select _index;
		_dir = (missionNamespace getVariable "VehDir") select _index;
		_dhp = (missionNamespace getVariable "VehDHP") select _index;
		_mkr = (missionNamespace getVariable "VehMarker") select _index;

		_newobj = createVehicle [_type, [0,0,1000], [], 0, "NONE"];

		//clean the area before moving the vehicle to its position
		{
			if ((_x distance _pos) < 20 && damage _x == 1) then {
				deleteVehicle _x;
			};
		} forEach ([_mkr] call psq_fnc_unitsInArea);
		uisleep 2;
		
		_newobj setDir _dir;
		_newobj setPosWorld _pos;

		_newobj setVariable ["name", _objectName];
		_newobj removeAllMPEventHandlers "MPKilled";
		_newobj addMPEventHandler ["MPKilled", {[_this select 0] spawn psq_fnc_vehicleRespawn;}];

		if(_dhp) then {[_newobj] spawn psq_fnc_damagedHeloPractice;};
	};	
};