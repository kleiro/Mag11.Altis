//lzTimer
params["_taskName","_startTime","_deadLine"];


waitUntil{daytime > _deadline || missionNamespace getVariable ("taskState" + _taskName) != "Created"};

if (missionNamespace getVariable ("taskState" + _taskName) != "Created") then {
} else {
	missionNamespace setVariable ["taskState" + _taskName, "TimeOut"];
};