/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:21:36 
 * @Last Modified by:   MoarRightRudder 
 * @Last Modified time: 2018-03-13 14:21:36 
 */
//convoyHuntGUI

createDialog "convoyHuntGUI";

lbAdd[2101, "No"];
lbAdd[2101, "Yes"];
lbSetCurSel[2101, 0];

buttonSetAction[2400,"
	if((missionNamespace getVariable ['convoyArrived', false]) isEqualTo false) then {
		switch (lbCurSel 2101) do {
			case 0 : {
				missionNamespace setVariable ['ConvoyAA', 0];
			};
			case 1 : {
				missionNamespace setVariable ['ConvoyAA', 1];
			};
		};
		missionNamespace setVariable ['convoyHuntEnabled', true];
		closeDialog 1;
	} else {
		hint 'Please wait. Current convoy hunt is terminating.';
	};

"];

buttonSetAction[2401, "closeDialog 0;"];

buttonSetAction[2402, "
['convoyHunt', 'Canceled'] call BIS_fnc_taskSetState;
missionNamespace setVariable ['convoyArrived', 'canceled'];
closeDialog 1;"];