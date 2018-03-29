/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:23:47 
 * @Last Modified by:   MoarRightRudder 
 * @Last Modified time: 2018-03-13 14:23:47 
 */
//Locality Change
//Runs on server when an object's locality changes (must have previously been on the nimitz)

params ["_object"];

_object removeAllEventHandlers "local";

_object addEventHandler ["local", {
	if (!(_this select 1) && !(isNull (_this select 0))) then {
		[(_this select 0), ((_this select 0) getVariable "enableDamage")] remoteExec ["allowDamage", (_this select 0)];
		[(_this select 0)] remoteExec ["localityChange", (_this select 0)];
	};
}];

