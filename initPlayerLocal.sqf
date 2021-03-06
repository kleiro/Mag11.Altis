/*
* @Author:  DnA
* @Profile: http://steamcommunity.com/id/dna_uk
* @Date:    2014-04-24 09:20:06
 * @Last Modified by: MoarRightRudder
 * @Last Modified time: 2018-05-17 17:12:52
*/

private [ "_player", "_jip" ];
_player = _this select 0;
_jip = _this select 1;

//--- Params
NMD_ParamFriendlyFire = ( [ "FriendlyFire", 1 ] call BIS_fnc_getParamValue );
NMD_ParamFatigue = ( [ "Fatigue", 1 ] call BIS_fnc_getParamValue );
NMD_ParamRespawnLoadout = ( [ "RespawnLoadout", 1 ] call BIS_fnc_getParamValue );

//--- Briefing
#include "initBriefing.hpp"

//--- Player init function
NMD_playerInit = {

	player addAction [ "<img image='\A3\Ui_f\data\IGUI\Cfg\Actions\eject_ca.paa' /> <t color='#E6731A'>NMD Menu</t>", { createDialog "NMD_RscDisplayMenu" }, nil, -1, false, true ];
	diag_log "^^^^^^Running NMD Init";

};

waitUntil { !isNull player };

//--- Add player action menu
call NMD_playerInit;
#include "race\racePlayerLocalInclude.hpp"

//--- Intro hint
//[ [ "Sandbox", "AccessMenu" ], nil, nil, nil, nil, true, true ] call BIS_fnc_advHint;

//--- Respawn handler
player addEventHandler [ "Respawn", {

	private [ "_unit", "_corpse" ];
	_unit = player;
	_corpse = _this select 1;

	//--- Respawn with same gear parameter
	if ( NMD_ParamRespawnLoadout > 0 && { !isNil "NMD_respawnLoadout" } ) then {

		[ _unit, NMD_respawnLoadout ] call NMD_fnc_loadInventory;
		NMD_respawnLoadout = nil;

	};

	//--- Cleanup corpse
	[ _corpse, 0 ] call NMD_fnc_cleanupUnit;

	//--- Add player action menu
	//call NMD_playerInit;

	//--- Fatigue parameter
	if ( NMD_ParamFatigue < 1 ) then {

		player enableFatigue false;

	};

	//--- Reset respawn time
	setPlayerRespawnTime getNumber( missionConfigFile >> "respawnDelay" );

} ];

//--- Killed EH
player addEventHandler [ "Killed", {

	private [ "_unit", "_killer" ];
	_unit = _this select 0;
	_killer = _this select 1;

	//--- Respawn with same gear parameter
	if ( NMD_ParamRespawnLoadout > 0 ) then {

		NMD_respawnLoadout = player call NMD_fnc_saveInventory;

	};

	//--- Punish friendly fire parameter
	if ( NMD_ParamFriendlyFire > 0 ) then {

		if ( isPlayer _killer && { _killer != player && side group _killer == side group player } ) then {

			[ 60, "NMD_fnc_setPlayerRespawnTime", _killer ] spawn BIS_fnc_MP;
			[ [ "Friendly Fire", format[ "You have been executed and a respawn penalty of 60 seconds has been applied for killing:<br />%1", name player ] ], "NMD_fnc_titleHint", _killer ] spawn BIS_fnc_MP;
			_killer setDamage 1;

		};

	};

} ];

//--- Fix for admin curator
/*
[] spawn {

	waitUntil { !isNull findDisplay 46 };

	( findDisplay 46 ) displayAddEventHandler [ "KeyDown", {

		private [ "_key", "_curatorKeys", "_handled" ];
		_key = _this select 1;
		_curatorKeys = actionKeys "CuratorInterface";
		_handled = false;

		if ( _key in _curatorKeys && { !isMultiplayer || serverCommandAvailable "#kick" } ) then {

			if ( isNull getAssignedCuratorUnit NMD_curator ) then {

				player assignCurator NMD_curator;
				openCuratorInterface;
				_handled = true;

			};

		};

		_handled

	} ];

};
*/
if (isServer) then {player assignCurator ZeusHost};


_player createDiaryRecord ["Diary", ["Karting", "Karts are availabe at the Kart Track. Races can be initiated by lining up on the start line and using the scroll wheel action."]];
_player createDiaryRecord ["Diary", ["LZ Practice", "Use the MAG Laptops to select the difficulty and which types/how many helicopters will be used in the scenario. A maximum of 2 scenarios may be active at a time."]];
_player createDiaryRecord ["Diary", ["Autorotation Practice", "Four UH-1Y's at Almyra Airfield in the salt flats contain autorotation and rock-out scripts for practicing with a damaged helicopter."]];
_player createDiaryRecord ["Diary", ["Medical Training Center", "The MTC is located at the Helo Ramp. Inside are 4 stations with laptops that you can use to spawn medical dummies with varying degrees of injuries. You may also delete dummies with the same laptops after spawning them. Due to the unpredictability of ACE, some dummies may immediately die upon spawning."]];
_player createDiaryRecord ["Diary", ["Convoy Hunts", "Enemy convoys can be spawned and despawned using the MAG laptops. A total of 12 vehicles will be spawned."]];
_player createDiaryRecord ["Diary", ["Air to Air Range", "Use the MAG Laptops to select how many and what types of aircraft will spawn when a player enters the air to air range. Multiple enemy aircraft types can be selected by holding 'CTRL' and clicking. The default ratio is 1 enemy per friendly."]];
_player createDiaryRecord ["Diary", ["Time Acceleration", "A time acceleration factor of 12x is active to provide both night and day practice in a short period of time. Each hour on the server is 5 minutes in real time. A full day is 2 hours in real time."]];