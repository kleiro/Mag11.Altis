/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-28 17:05:07 
 * @Last Modified by: MoarRightRudder
 * @Last Modified time: 2018-03-28 19:41:18
 */

//SafeZone
//Creates a safe zone for players and vehicles within rectangular markers labeled safeZone_x

if !(isServer) exitWith {};

///////////////////////////////////////////////////////////////////////////////////////////////////
fnc_entered = {
	params["_object","_marker"];
	_i = 0;

	if(_object getVariable ["szQueue", false]) exitWith {};
	_object setVariable ["szQueue", true];

	//Disable damage on player units immediately if they're not in a vehicle
	if (_object isKindOf "Man") then {
		[_object, false] remoteExec ["allowDamage", _object];
		_object setVariable ["enableDamage", false, true];
	};

	//Enable damage on a vehicle and it's crew if it stays in the safezone for more than 7 seconds and it's velocity is less than 3
	while {_i<7} do {
		_vel = (((velocity _object) select 0) + ((velocity _object) select 1) + ((velocity _object) select 2));
		if(_object in ([_marker] call psq_fnc_unitsInArea) && _vel < 3) then {
			_i = _i + 1;
			uisleep 1;
		} else {
			_object setVariable ["szQueue", false];
			terminate _thisScript;
		};
	};

	//Disable damage on the object
	_object setVariable ["enableDamage", false, true];
	[_object, false] remoteExec ["allowDamage", _object];

	//Disable damage on the crew
	_crew = fullCrew _object;
	{
		_man = _x select 0;
		[_man, false] remoteExec ["allowDamage", _man];
		_man setVariable ["enableDamage", false, true];
	}forEach _crew;

	//Add an eventhandler for locality changes to prevent damage
	_object removeAllEventHandlers "Local";
	_object addEventHandler ["local", {
		if (!(_this select 1) && !(isNull (_this select 0))) then {
			[(_this select 0), ((_this select 0) getVariable ["enableDamage",true])] remoteExec ["allowDamage", (_this select 0)];
			[(_this select 0)] remoteExec ["localityChange", (_this select 0)];
		};
	}];

	//Wait for the vehicle to leave the safezone to reenable damage	
	waitUntil {!(_object in ([_marker] call psq_fnc_unitsInArea))};

	//Enable damage on crew members
	_crew = fullCrew _object;
	{
		_man = _x select 0;
		[_man, true] remoteExec ["allowDamage", _man];
		_man setVariable ["enableDamage", true,true];
	}forEach _crew;

	//Enable damage on object
	[_object, true] remoteExec ["allowDamage", _object];
	_object setVariable ["EnableDamage", true, true];
	_object setVariable ["szQueue", false];
};

///////////////////////////////////////////////////////////////////////////////////////////////////
params["_marker"];

{
	[player, ["getInMan", {
		player allowDamage (player getVariable ["enableDamage", true]);
	}]] remoteExec ["addEventHandler", 0, true];

}forEach allPlayers;

while {true} do {
	{
		[_x,_marker] spawn fnc_entered;
	}forEach ([_marker] call psq_fnc_unitsInArea);

	uisleep 1;
};