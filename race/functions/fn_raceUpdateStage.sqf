/* 
* @Author:  DnA
* @Profile: http://steamcommunity.com/id/dna_uk
* @Date:    2014-06-09 01:35:36
* @Last Modified by:   DnA
* @Last Modified time: 2014-06-09 02:04:13
*/

private [ "_current", "_count" ];
_current = [ _this, 0, 0, [0] ] call BIS_fnc_param;
_count = [ _this, 1, 0, [0] ] call BIS_fnc_param;

//--- Set current stage text
private "_text";
_text = format [ "Stage - %1/%2", _current, _count ];
_text = "<t align='center' size='0.8'>" + _text + "</t>";

RscFiringDrillTime_best = parseText _text;

true