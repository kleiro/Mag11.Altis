//damagedHeloPractice
//adds actions that damages helo's main rotors and tailrotors, and restores them if reselected.
if !(isServer) exitWith {};

params["_passedVehicle"];

diag_log format["***DHP OUTPUT: %1", _passedVehicle];

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