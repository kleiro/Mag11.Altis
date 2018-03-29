/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:24:34 
 * @Last Modified by:   MoarRightRudder 
 * @Last Modified time: 2018-03-13 14:24:34 
 */
//Respawn Nimitz

if !(isServer) exitWith {};

params["_nimitz"];

_unitList = [_nimitz] call psq_fnc_unitsOnNimitz;

if !(missionNamespace getVariable ["nimitzRespawnInit", false]) then {

	//initialization section (only runs once at the beginning of the mission)
	//gathers information on all editor-placed vehicles on the nimitz

	{
		if (_x isKindOf "Air" || _x isKindOf "LandVehicle" || _x isKindOf "ReammoBox_F") then {
			//Add vehicle name, type, posWorld, and dir to nimitzVehicles arrays
			_vehs = +(missionNamespace getVariable ["nimitzVehNames",[]]);
			_vehs pushBack (str _x);
			missionNamespace setVariable ["nimitzVehNames", _vehs];
			_x setVariable ["name", (str _x)];

			_types = +(missionNamespace getVariable ["nimitzVehTypes", []]);
			_types pushBack (typeOf _x);
			missionNamespace setVariable ["nimitzVehTypes", _types];

			_pos = +(missionNamespace getVariable ["nimitzVehPos", []]);
			_pos pushBack (getPosWorld _x);
			missionNamespace setVariable ["nimitzVehPos", _pos];

			_dirs = +(missionNamespace getVariable ["nimitzVehDir", []]);
			_dirs pushBack (getDir _x);
			missionNamespace setVariable ["nimitzVehDir", _dirs];

			//Add mpKilled event handler that will execute this script again after firing
			_x addMPEventHandler ["MPKilled", {[_this select 0] spawn psq_fnc_respawnNimitz; diag_log format ["*** killed object: %1", _this select 0];}];

			//Check if type is Viper or huey and add an unpack action
			if (_x isKindOf "RHS_AH1Z_base" or _x isKindOf "RHS_UH1Y_base") then {
				[_x, ["Unpack",{
					_v = _this select 3;
					switch (_v isKindOf "RHS_AH1Z_base") do {
						case true: {
							_v setFuel 1;
							_v animate ["mainrotor_folded",0];
							_v animate ["mainrotor_unfolded",0];
							_v animate ["rotorshaft_unfolded",0];
						};
						case false: {
							_v setFuel 1;
							{
								_v animate [_x,0,true];
							}foreach ["mainrotor_folded","mainrotor_unfolded","rotorshaft_unfolded"];
						};
					};
				},_x,4,false,true]] remoteExec ["addAction",0,true];
			};

		};
	}forEach _unitList;

	diag_log (format ["*** Nimitz placed vehicles: %1", missionNamespace getVariable ["nimitzVehNames",[]]]);
	diag_log (format ["*** Placed vehicle types: %1", missionNamespace getVariable ["nimitzVehTypes",[]]]);

	missionNamespace setVariable ["vehTypeList",[
		["CUP_B_MV22_USMC",
		"CUP_B_MV22_USMC_RAMPGUN",
		"CUP_B_MV22_VIV_USMC"],
		["JS_JC_FA18F",
		"JS_JC_FA18E"],
		["B_Plane_Fighter_01_F",
		"B_Plane_Fighter_01_Stealth_F"],
		["rhsusf_CH53E_USMC"],
		["RHS_AH1Z_base"],
		["RHS_UH1Y_base"],
		["FLAN_EA18G_Base"]
	]];
	missionNamespace setVariable ["nimitzRespawnInit", true];

} else {
	//Section that's run when the mpKilled event handler fires
	//This creates a new vehicle in the original starting position of the old one

	params ["_object"];
	_objectName = _object getVariable "name";

	uisleep 30;
	_index = (missionNamespace getVariable "nimitzVehNames") find _objectName;

	_type = (missionNamespace getVariable "nimitzVehTypes") select _index;
	_pos = (missionNamespace getVariable "nimitzVehPos") select _index;
	_dir = (missionNamespace getVariable "nimitzVehDir") select _index;

	_newobj = createVehicle [_type, [0,0,500], [], 0, "NONE"];


	//Fold wings/rotors before placing on carrier
	_typeSelect = -1;
	{
		_index = _forEachIndex;
		{
			if (_type isKindOf _x) then {
				_typeSelect = _index;
			};
		}forEach _x;
	}forEach (missionNamespace getVariable "vehTypeList");

	switch (_typeSelect) do {
		//MV22
		case 0: {
			_newobj setFuel 0;

			_newobj animate ["engine_prop_1_1_turn", 1, true];
			_newobj animate ["engine_prop_1_2_turn", 1, true];
			_newobj animate ["engine_prop_1_3_turn", 1, true];
			_newobj animate ["engine_prop_2_1_turn", 1, true];
			_newobj animate ["engine_prop_2_2_turn", 1, true];
			_newobj animate ["engine_prop_2_3_turn", 1, true];
			_newobj animate ["engine_prop_1_1_close", 1, true];
			_newobj animate ["engine_prop_1_3_close", 1, true];
			_newobj animate ["engine_prop_2_1_close", 1, true];
			_newobj animate ["engine_prop_2_2_close", 1, true];
			_newobj animate ["pack_engine_1", 1, true];
			_newobj animate ["pack_engine_2", 1, true];
			_newobj animate ["turn_wing", 1, true];
		};
		//F18
		case 1: {
			_newobj animate ["r_wingfold",1,true];
			_newobj animate ["l_wingfold",1,true];

			_newobj setVehicleReportOwnPosition true;
			_newobj setVehicleReportRemoteTargets true;
			_newobj setVehicleReceiveRemoteTargets true;
		};
		//F181
		case 2: {
			_newobj animate ["wing_fold_r",1,true];
			_newobj animate ["wing_fold_l",1,true];

			_newobj setVehicleReportOwnPosition true;
			_newobj setVehicleReportRemoteTargets true;
			_newobj setVehicleReceiveRemoteTargets true;
		};
		//CH53
		case 3: {
			_newobj setFuel 0;
			_newobj animateDoor ['mainRotor_folded',1,true];
		};
		//AH1Z
		case 4: {
			_newobj animate ["mainrotor_folded",1,true];
			_newobj animate ["mainrotor_unfolded",1,true];
			_newobj animate ["rotorshaft_unfolded",1,true];

			//Add action for viper
			[_newobj, ["Unpack",{

					_v = _this select 3;
					_v setFuel 1;
					_v animate ["mainrotor_folded",0];
					_v animate ["mainrotor_unfolded",0];
					_v animate ["rotorshaft_unfolded",0];

			},_newobj,4,false,true]] remoteExec ["addAction",0,true];
		};
		//UH1Y
		case 5: {
			_newobj setFuel 0;
			{
				_newobj animate [_x,1,true];
			}foreach ["mainrotor_folded","mainrotor_unfolded","rotorshaft_unfolded"];

			//Add action for huey
			[_newobj, ["Unpack",{

				_v = _this select 3;
				_v setFuel 1;
				{
					_v animate [_x,0];
				}foreach ["mainrotor_folded","mainrotor_unfolded","rotorshaft_unfolded"];

			},_newobj,4,false,true]] remoteExec ["addAction",0,true];
		};
		//EA18G
		case 6: {
			_newobj animate ["leftwing",1, true];
			_newobj animate ["rightwing",1, true];

			_newobj setVehicleReportOwnPosition true;
			_newobj setVehicleReportRemoteTargets true;
			_newobj setVehicleReceiveRemoteTargets true;
		};
	};

	_newobj setDir _dir;
	_newobj setPosWorld _pos;

	_newobj setVariable ["name", _objectName];
	_newobj removeAllMPEventHandlers "MPKilled";
	_newobj addMPEventHandler ["MPKilled", {[_this select 0] spawn psq_fnc_respawnNimitz;}];

};

/*hornet:
JS_JC_FA18F
JS_JC_FA18E

_v animate ["r_wingfold",1,true];
_v animate ["l_wingfold",1,true];
*/

/* osprey:
CUP_B_MV22_USMC
CUP_B_MV22_USMC_RAMPGUN
CUP_B_MV22_VIV_USMC

_v setFuel 0;

_v animate ["engine_prop_1_1_turn", 1, true];
_v animate ["engine_prop_1_2_turn", 1, true];
_v animate ["engine_prop_1_3_turn", 1, true];
_v animate ["engine_prop_2_1_turn", 1, true];
_v animate ["engine_prop_2_2_turn", 1, true];
_v animate ["engine_prop_2_3_turn", 1, true];
_v animate ["engine_prop_1_1_close", 1, true];
_v animate ["engine_prop_1_3_close", 1, true];
_v animate ["engine_prop_2_1_close", 1, true];
_v animate ["engine_prop_2_2_close", 1, true];
_v animate ["pack_engine_1", 1, true];
_v animate ["pack_engine_2", 1, true];
_v animate ["turn_wing", 1, true];
*/

/*wasp:
B_Plane_Fighter_01_Stealth_F
B_Plane_Fighter_01_F

_v animate ["wing_fold_r",1,true];
_v animate ["wing_fold_l",1,true];
*/

/*stallion:
rhsusf_CH53E_USMC

_v setFuel 0;
_v animateDoor ['mainRotor_folded',1,true];
*/

/*viper:
RHS_AH1Z_base

_v animate ["mainrotor_folded",0];
_v animate ["mainrotor_unfolded",1];
_v animate ["rotorshaft_unfolded",1];
*/

/*huey:
RHS_UH1Y_base

_v setFuel 0;
{
	_v animate [_x,1,true];
}foreach ["mainrotor_folded","mainrotor_unfolded","rotorshaft_unfolded"];
*/

/* EA18G
FLAN_EA18G_Base
_v animate ["leftwing",1, true];
_v animate ["rightwing",1, true];
*/


