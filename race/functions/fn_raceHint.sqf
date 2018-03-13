/* 
* @Author:  DnA
* @Profile: http://steamcommunity.com/id/dna_uk
* @Date:    2014-05-30 19:38:53
* @Last Modified by:   DnA
* @Last Modified time: 2014-06-13 07:37:27
*/

_message = [ _this, 0, "", [""]] call BIS_fnc_param;
_size = [ _this, 1, 1, [0] ] call BIS_fnc_param;
_hide = [ _this, 2, 0, [0] ] call BIS_fnc_param;

//--- Show the hint
hintSilent parseText format [ "<t align='center' color='" + DNA_race_colorHTML + "' shadow='0' size='1.2'>RACE</t><br /><t size='%1' shadow='0'>%2</t>", _size, _message ];

//--- Play hint sound
playSound [ "FD_Timer_F", true ];

//--- Hide after X seconds
if ( _hide > 0 ) then {

	_hide spawn {

		sleep _this;
		hint "";

	};

};

true