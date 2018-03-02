//lzPractice

//Generates an extraction scenario randomly on the map. Friendly and enemy units will be placed first and made to engage each other. A suitable lz will be determined using bis_fnc_findsafepos. The helo will have to complete the mission within a given timeframe. The mission will start via a menu available on the nimitz. The player can select the type and number of helicopters being flown to the LZ, and how hot the LZ should be.

//The extraction location will be chosen randomly based on arma 3 locations. A global variable must be made in init that retrieves all locations:
//nearestLocations [[0,0,0], ["NameVillage","NameCity","NameCityCapital"], 25000];

/*
1. Random location is selected and then a random position around it is determined for a landing site
2. Another random position is selected some meters away for spawning blufor units
3. Another position in the same direction even further away is selected for spawning opfor units
*/

_location = selectRandom locationList;
_lzPos = [];
_lzSearchPos = [];
_bluPos = [];
_opfPos = [];


while {_lzPos == []} do {
	_lzSearchPos = (locationPosition _location) getPos [random 1000, random 359];
	_lzPos = [_lzSearchPos, 0, 100, 8, 0, .45, 0, [], []] call bis_fnc_findsafepos;
};

_dir = random 359;
_bluPos = (_lzPos) getPos [random 500, _dir];
_opfPos = (_bluPos) getPos [(random 700)+200, _dir];

//Define opfor compositions here based upon difficulty settings

//Define blufor compositions here based upon helicopters being used

