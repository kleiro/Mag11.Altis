/*
* @Author:  DnA
* @Profile: http://steamcommunity.com/id/dna_uk
* @Date:    2014-04-24 09:20:06
* @Last Modified by:   DnA
* @Last Modified time: 2014-06-14 07:42:39
*/

enableSaving [ false, false ];

//--- Singleplayer
if ( !isMultiplayer ) then {

	//--- Delete other switchable
	{ if ( !isPlayer _x ) then { deleteVehicle _x } } forEach switchableUnits;

};

#include "nimitzSafeZone\nimitzSafeZoneInclude.hpp"
#include "Air2Air\Air2AirInclude.hpp"
#include "lzPractice\lzPracticeInclude.hpp"

timer = 1;
timer1 = 1;

[] spawn psq_fnc_respawnNimVeh;

diag_log "***InitServer Complete";