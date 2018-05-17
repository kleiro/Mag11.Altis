/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:24:37 
 * @Last Modified by: MoarRightRudder
 * @Last Modified time: 2018-05-17 14:39:17
 */
//unitsOnNimitz

params["_nimitz"];
if(typeName _nimitz == "String") exitWith {};

_units = vehicles inAreaArray [getPos _nimitz, 40.648, 169.803, getDir _nimitz, true, 40];

_units