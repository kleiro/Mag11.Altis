//onPlayerRespawn
//Executes locally when a player respawns

//Finds if the player respawns close to the nimitz and then moves them to the correct location
//Solves the issue of having a trigger to move players
params ["_unit"];

if (((getPosWorld _unit) distance2D (getPosWorld nimitz)) < 200) then {
	_unit setDir 90;
	_unit setPosWorld [2486.136,14129.804,6.6];
};

//{_x setPosWorld [2486.136,14129.804,6.6]}foreach thisList;