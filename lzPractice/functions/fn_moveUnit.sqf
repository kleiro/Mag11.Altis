/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:22:54 
 * @Last Modified by:   MoarRightRudder 
 * @Last Modified time: 2018-03-13 14:22:54 
 */
//moveUnit
//Makes units move to the delivery position for deletion once out of the helo

params["_man","_helo"];

_delPos = missionNamespace getVariable "lzpDropOff";
_man setVariable["moveOutUnit", 1];
_script = _thisScript;

while {!(isNull objectParent _man) || !(_man getVariable ["arrived",false])} do {if(isNull _man) then {terminate _thisScript;};};

[_man] join grpNull;
(group _man) move _delPos;