//Locality Change
//Runs on server when an object's locality changes (must have previously been on the nimitz)

params ["_object"];

_object removeAllEventHandlers "local";
_object addEventHandler ["local", {
	if !((_this select 1)) then {
		[(_this select 0)] remoteExec ["localityChange", (_this select 0)];
	};
}];

