/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:22:11 
 * @Last Modified by: MoarRightRudder
 * @Last Modified time: 2018-03-28 20:15:33
 */
//damagedHeloPractice
//adds actions that damages helo's main rotors and tailrotors, and restores them if reselected.
if !(isServer) exitWith {};

///////////////////////////////////////////////////////////////////////////////////////////////////
fnc_addActions = {
	params["_passedVehicle"];
	
	if(_passedVehicle getVariable ["DHP", false]) then {

		//Driver Actions
		[_passedVehicle, ["Main Rotor Fail",{
			_v = _this select 3;
			if (_v getHitPointDamage "HitHRotor" > 0) then {
				[_v,["HitHRotor", 0]] remoteExec ["setHitPointDamage",_v,false];
				//_v setHitPointDamage ["HitHRotor", 0];
			} else {
				[_v,["HitHRotor", 1]] remoteExec ["setHitPointDamage",_v,false];
				//_v setHitPointDamage ["HitHRotor", 1];
			};
		},_passedVehicle,4,false,true,"","_this == driver _target"]] remoteExec ["addAction",0,true];

		[_passedVehicle, ["Tail Rotor Fail",{
			_v = _this select 3;
			if (_v getHitPointDamage "HitVRotor" > 0) then {
				[_v,["HitVRotor", 0]] remoteExec ["setHitPointDamage",_v,false];
				//_v setHitPointDamage ["HitVRotor", 0];
			} else {
				[_v,["HitVRotor", 1]] remoteExec ["setHitPointDamage",_v,false];
				//_v setHitPointDamage ["HitVRotor", 1];
			};
		},_passedVehicle,4,false,true,"","_this == driver _target"]] remoteExec ["addAction",0,true];


		//CopilotActions
		[_passedVehicle, ["Main Rotor Fail",{
			_v = _this select 3;
			if (_v getHitPointDamage "HitHRotor" > 0) then {
				[_v,["HitHRotor", 0]] remoteExec ["setHitPointDamage",_v,false];
				//_v setHitPointDamage ["HitHRotor", 0];
			} else {
				[_v,["HitHRotor", 1]] remoteExec ["setHitPointDamage",_v,false];
				//_v setHitPointDamage ["HitHRotor", 1];
			};
		},_passedVehicle,4,false,true,"","(_target turretUnit [0]) == _this"]] remoteExec ["addAction",0,true];

		[_passedVehicle, ["Tail Rotor Fail",{
			_v = _this select 3;
			if (_v getHitPointDamage "HitVRotor" > 0) then {
				[_v,["HitVRotor", 0]] remoteExec ["setHitPointDamage",_v,false];
				//_v setHitPointDamage ["HitVRotor", 0];
			} else {
				[_v,["HitVRotor", 1]] remoteExec ["setHitPointDamage",_v,false];
				//_v setHitPointDamage ["HitVRotor", 1];
			};
		},_passedVehicle,4,false,true,"","(_target turretUnit [0]) == _this"]] remoteExec ["addAction",0,true];
	};
};
///////////////////////////////////////////////////////////////////////////////////////////////////

if !(missionNamespace getVariable ["DHPInit", false]) then {
	
	//DHP init adds actions to all editor placed helos that have DHP set to true in their init
	{
		[_x] spawn fnc_addActions;
	}forEach vehicles;
	missionNamespace setVariable ["DHPInit", true];

} else {

	//This section executes when a vehicle respawns and it was a dhp vehicle
	params["_passedVehicle"];

	_passedVehicle setVariable ["DHP", true];
	[_passedVehicle] spawn fnc_addActions;
};
