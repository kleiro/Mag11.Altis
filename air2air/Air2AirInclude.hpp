//Air2AirInclude
//Requires a trigger (type none) with the following activation and statements:
//triggerActivation["Any Player","Present",true], triggerStatements["timer ==1", "[thisList] call a2aRange;", "timer1=1;"]
//timer can be initialized in initServer

a2aTargets =[[],[]]; //List of objects concerning the a2a zone, arrays: Player, Enemy Aircraft for Player

a2aRange = compile preprocessFileLineNumbers "air2air\Air2AirRange.sqf";
a2aDestroyed = compile preprocessFileLineNumbers "air2air\a2aDestroyed.sqf";
a2aKilled = compile preprocessFileLineNumbers "air2air\a2aKilled.sqf";