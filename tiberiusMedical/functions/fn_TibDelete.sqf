/*
 * @Author: MoarRightRudder 
 * @Date: 2018-05-17 12:46:15 
 * @Last Modified by: MoarRightRudder
 * @Last Modified time: 2018-05-17 14:06:24
 */

params ["_victim", "_medBayPC"];

//Add action to delete victim

_action = _medBayPC addAction ["Delete Wounded", {deleteVehicle (_this select 3);} ,_victim];

//waitUntil unit is dead or Deleted
waitUntil {isNull _victim};
//Remove action
_medBayPC removeAction _action;