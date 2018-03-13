//findFlatEmpty
//Used to find flat & empty areas

params ["_pos"];
_newPos = [];
_range = 10;
_heading = 0;

while{(count _newPos) == 0} do {
	_newPos = _pos getPos[_range, _heading];
	_newPos = [_newPos, 0, 150, 48, 0, .45, 0] call BIS_fnc_findSafePos;
	_range = _range + 10;
	_heading = _heading + 10;
};

_newPos