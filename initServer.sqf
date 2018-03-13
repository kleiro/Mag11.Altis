/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:25:37 
 * @Last Modified by:   MoarRightRudder 
 * @Last Modified time: 2018-03-13 14:25:37 
 */
enableSaving [ false, false ];

//--- Singleplayer
if ( !isMultiplayer ) then {

	//--- Delete other switchable
	{ if ( !isPlayer _x ) then { deleteVehicle _x } } forEach switchableUnits;

};

#include "psqBase\psqInclude.hpp"
#include "nimitzSafeZone\nimitzSafeZoneInclude.hpp"
#include "Air2Air\Air2AirInclude.hpp"
#include "lzPractice\lzPracticeInclude.hpp"
#include "convoyHunt\convoyHuntInclude.hpp"

diag_log "***InitServer Complete";