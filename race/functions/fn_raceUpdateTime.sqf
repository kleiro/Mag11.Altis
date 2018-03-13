/* 
* @Author:  DnA
* @Profile: http://steamcommunity.com/id/dna_uk
* @Date:    2014-06-09 01:35:46
* @Last Modified by:   DnA
* @Last Modified time: 2014-06-09 07:21:40
*/

private [ "_time", "_color", "_negative" ];
_time = [ _this, 0, 0, [0] ] call BIS_fnc_param;
_color = [ _this, 1, "#ffffff", [""] ] call BIS_fnc_param;

//--- Set current stage text
private "_text";
_time =  [ _time, "MM:SS.MS", true ] call BIS_fnc_secondsToString;
_time = format [ "<t color='%4'>%1:%2:%3</t> ", _time select 0, _time select 1, _time select 2, _color ];

_text = "<img image='A3\Modules_F_Beta\data\FiringDrills\timer_ca' /> " + _time;

RscFiringDrillTime_current = parseText _text;

true