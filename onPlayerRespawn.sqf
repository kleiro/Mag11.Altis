//onPlayerRespawn
//Executes locally when a player respawns

//Finds if the player respawns close to the nimitz and then moves them to the correct location
//Solves the issue of having a trigger to move players
_unit = _this select 0;
_time = time + 5;
#include "race\racePlayerLocalInclude.hpp"

while{(_time > time)} do {
	if (((getPosWorld _unit) select 2) < 6) then {
		_unit setDir 90;
		_unit setPosWorld [2486.136,14129.804,6.8];
	};
};