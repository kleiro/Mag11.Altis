/*
 * @Author: MoarRightRudder 
 * @Date: 2018-03-13 14:21:58 
 * @Last Modified by:   MoarRightRudder 
 * @Last Modified time: 2018-03-13 14:21:58 
 */
//convoyHuntInclude

missionNameSpace setVariable ["convoyUnitsAlive", 0];
missionNameSpace setVariable ["convoyUnits", []];
missionNameSpace setVariable ["convoyArrived", false, true];


//SpawnList for convoys. 1st list is without AA, 2nd list is with AA
//*****Don't include ifrits. Their driver AI is abnormally terrible
missionNameSpace setVariable ["convoySpawnList", [
[
/*
Grab data:
Mission: tempMissionSP
World: VR
Anchor position: [6295.63, 1680.78]
Area size: 25d
Using orientation of objects: yes
*/


	["O_APC_Tracked_02_cannon_F",[0.145508,-3.39404,-0.0682325],359.999,1,0,[0.76956,-0.040126],"","",true,false],
	["O_APC_Wheeled_02_rcws_F",[-0.03125,-17.0513,0.00554752],360,1,0,[0.188207,-0.0346626],"","",true,false],

	["O_APC_Tracked_02_cannon_F",[0.145508,-3.39404,-0.0682325],359.999,1,0,[0.76956,-0.040126],"","",true,false],
	["O_APC_Wheeled_02_rcws_F",[-0.03125,-17.0513,0.00554752],360,1,0,[0.188207,-0.0346626],"","",true,false],

	["O_APC_Wheeled_02_rcws_F",[-0.285645,-3.31445,0.00368881],360,1,0,[0.185467,-0.029427],"","",true,false],
	["O_Truck_03_covered_F",[-0.214844,-16.8739,0.00176239],0.000384765,1,0,[-0.386379,0.0127832],"","",true,false],

	["O_Truck_03_covered_F",[-0.316406,-5.0957,-0.00169897],0.000391674,1,0,[-0.393813,0.0146719],"","",true,false],
	["O_APC_Tracked_02_cannon_F",[0.202148,-19.9468,-0.0682817],359.998,1,0,[0.767653,-0.0401155],"","",true,false],

	["O_APC_Tracked_02_cannon_F",[-0.225098,-3.74622,-0.0682888],359.998,1,0,[0.767401,-0.0401188],"","",true,false],
	["O_MBT_02_cannon_F",[0.0410156,-19.5756,-0.0932693],3.41913e-005,1,0,[0.491718,0.0205847],"","",true,false],

	["O_Truck_03_covered_F",[-0.316406,-5.0957,-0.00169897],0.000391674,1,0,[-0.393813,0.0146719],"","",true,false],
	["O_APC_Tracked_02_cannon_F",[0.202148,-19.9468,-0.0682817],359.998,1,0,[0.767653,-0.0401155],"","",true,false]

],[
/*
Grab data:
Mission: NMDMag36
World: Altis
Anchor position: [23796.2, 18506.3]
Area size: 25
Using orientation of objects: yes
*/

	["O_APC_Tracked_02_cannon_F",[0.145508,-3.39404,-0.0682325],359.999,1,0,[0.76956,-0.040126],"","",true,false],
	["O_APC_Wheeled_02_rcws_F",[-0.03125,-17.0513,0.00554752],360,1,0,[0.188207,-0.0346626],"","",true,false],

	["O_APC_Tracked_02_AA_F",[0.213379,-3.76428,-0.0687532],359.999,1,0,[0.818665,-0.0379887],"","",true,false],
	["O_APC_Wheeled_02_rcws_F",[-0.528809,-17.2555,0.00554466],360,1,0,[0.18804,-0.0344307],"","",true,false],

	["O_APC_Wheeled_02_rcws_F",[-0.285645,-3.31445,0.00368881],360,1,0,[0.185467,-0.029427],"","",true,false],
	["O_Truck_03_covered_F",[-0.214844,-16.8739,0.00176239],0.000384765,1,0,[-0.386379,0.0127832],"","",true,false],

	["O_Truck_03_covered_F",[-0.316406,-5.0957,-0.00169897],0.000391674,1,0,[-0.393813,0.0146719],"","",true,false],
	["O_APC_Tracked_02_cannon_F",[0.202148,-19.9468,-0.0682817],359.998,1,0,[0.767653,-0.0401155],"","",true,false],

	["O_APC_Tracked_02_AA_F",[0.213379,-3.76416,-0.0688744],359.998,1,0,[0.813754,-0.0378756],"","",true,false],
	["O_MBT_02_cannon_F",[0.0893555,-20.5083,-0.0932698],0.000203794,1,0,[0.491678,0.0205805],"","",true,false],

	["O_Truck_03_covered_F",[-0.345703,-5.33398,-0.000637531],6.49647e-005,1,0,[-0.393746,0.0150718],"","",true,false],
	["O_APC_Tracked_02_AA_F",[0.15332,-21.0526,-0.0688949],359.999,1,0,[0.812934,-0.0378804],"","",true,false]

]], true];

missionNameSpace setVariable ["convoySpawnLocations",[
[[11666.6,9640.57,0.00171852],55.6628],
[[26836.5,24445.1,0.00135803],128.947],
[[20939.3,7200.1,0.00135803],9.64611],
[[22183.1,20997.3,0.00138474],227.833],
[[3841.39,12694,0.00139999],206.317],
[[3839.65,17509.5,0.00137043],216.798],
[[17067.1,12612.8,0.0014143],398.656],
[[16578.5,9838.39,0.00144768],427.107],
[[7158.92,16781.5,0.00134277],183.225],
[[16671.1,20567.3,0.00150251],510.666],
[[9506.54,22105.1,0.00159788],458.227],
[[8752.35,11916.4,0.00143814],373.197],
[[23991.8,20250.6,0.00150108],320.039],
[[3272.71,21416,0.00141144],532.77],
[[18136.6,14882.6,0.00145721],287.229]
], true];

/*^^^To get convoy spawn locations^^^, teleport with zeus and face the area that the convoy should be spawned in, then run this code in debugging:
copyToClipboard format["[%1,%2],", getPos Player, getDir player];
*/

[] spawn psq_fnc_ConvoyHunt;