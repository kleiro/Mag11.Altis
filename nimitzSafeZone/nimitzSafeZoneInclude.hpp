//nimitzSafeZoneInclude.hpp
//Requires a trigger (type none) with the following activation and statements:
//triggerActivation["Any Player","Present",true], triggerStatements["timer ==1", "[thisList] call psq_fnc_nimitzSafeZone;", "timer1=1;"]
//timer can be initialized in initServer
//After the timer line in 'initServer', {[]spawn psq_fnc_respawnNimVeh;} must be placed

/*Game logic must be placed with the following code:

[] spawn {
    while {true} do {
        {if (damage _x == 1 && ([nimSafeZoneT, _x] call BIS_fnc_inTrigger)) then { deleteVehicle _x};} forEach vehicles;
    sleep 20;
    };
};
*/

/*Each object that is to be protected/respawned on the nimitz must have this in its init:
this setVariable ["respawnOnNimitz", true];
*/

nimObj = [[],[],[],[]];//nimObj nested array: [[objname1,objname2],[objtype1,objtype2],[objpos1,objpos2],[objrot1,objrot2]] Positions are in ASL
iterList = [[],[]]; //List of objects that has been in the safe zone, but not for 5 seconds, format: Object, Iterations in, Iterations passed
safeList = []; //List of objects previously in safe zone used in nimitzSafeZone script

