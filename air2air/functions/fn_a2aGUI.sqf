//a2aGUI

createDialog "a2aGUI";

for "_i" from 0 to 8 do {
	lbAdd[2100, str(_i)];
};
lbSetCurSel [2100,1];

{
	lbAdd[1500, (getText(configFile >> "CfgVehicles" >> _x >> "displayName"))];
}forEach (missionNamespace getVariable "EACSpawnTable");

buttonSetAction [2400, "
	missionNamespace setVariable ['a2aDiff', (lbCurSel 2100)];
	_eacSet = [];
	{
		_eacSet pushBack ((missionNamespace getVariable 'EACSpawnTable') select _x);
	}forEach (lbSelection ((findDisplay 1430) displayCtrl 1500));
	missionNamespace setVariable ['EACSet',_eacSet];
	closeDialog 1;
"];