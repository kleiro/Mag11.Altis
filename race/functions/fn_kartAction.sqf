//kartAction
//adds an action to the player if within the boundaries of the starting area & there isn't a race going on


player addAction ["Start Race", {
	[] remoteExec ["dna_fnc_raceManager", 2, false];
}, "", 6, false, true, "", "(vehicle _target) isKindOf 'kart_01_base_f' && (vehicle _target) inArea kartStartTrigger && (speed (vehicle _target)) < .5 && !(missionNamespace getVariable ['activeRace', false])"];

