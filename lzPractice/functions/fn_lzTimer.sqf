/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:22:50 
 * @Last Modified by:   MoarRightRudder 
 * @Last Modified time: 2018-03-13 14:22:50 
 */
//lzTimer
params["_taskName","_startTime","_deadLine"];


waitUntil{daytime > _deadline || missionNamespace getVariable ("taskState" + _taskName) != "Created"};

if (missionNamespace getVariable ("taskState" + _taskName) != "Created") then {
} else {
	missionNamespace setVariable ["taskState" + _taskName, "TimeOut"];
};