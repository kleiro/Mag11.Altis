/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:24:31 
 * @Last Modified by:   MoarRightRudder 
 * @Last Modified time: 2018-03-13 14:24:31 
 */
//Nimitz Safe Zone
//Adds and removes objects to invulnerability list
//_thisList is passed from trigger
//If a vehicle and it's crew are inside the safe zone for 5 iterations (~5 seconds, damage will be disabled)

if !(isServer) exitWith {};

///////////////////////////////////////////////////////////////////////////////////////////////////
fnc_entered = {
	params["_object","_nimitz"];
	_i = 0;

	if(_object getVariable ["szQueue", false]) exitWith {};
	_object setVariable ["szQueue", true];

	//Disable damage on player units immediately if they're not in a vehicle
	if (_object isKindOf "Man") then {
		[_object, false] remoteExec ["allowDamage", _object];
		_object setVariable ["enableDamage", false, true];
	};

	//Enable damage on a vehicle and it's crew if it stays in the safezone for more than 7 seconds
	while {_i<7} do {
		if(_object in ([_nimitz] call psq_fnc_unitsOnNimitz)) then {
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
	waitUntil {!(_object in ([_nimitz] call psq_fnc_unitsOnNimitz))};

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
params["_nimitz"];

{
	[player, ["getInMan", {
		player allowDamage (player getVariable ["enableDamage", true]);
	}]] remoteExec ["addEventHandler", 0, true];

}forEach allPlayers;

while {true} do {
	{
		[_x,_nimitz] spawn fnc_entered;
	}forEach ([_nimitz] call psq_fnc_unitsOnNimitz);

	uisleep 1;
};