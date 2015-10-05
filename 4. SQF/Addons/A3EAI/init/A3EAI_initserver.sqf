#include "\A3EAI\globaldefines.hpp"

/*
	A3EAI Server Initialization File
	
	Description: Handles startup process for A3EAI. Does not contain any values intended for modification.
*/

if (hasInterface || !isDedicated ||!isNil "A3EAI_isActive") exitWith {};

_startTime = diag_tickTime;

A3EAI_isActive = true;

private ["_startTime","_worldname","_allUnits","_configCheck","_functionsCheck","_readOverrideFile","_reportDirectoryName","_configVersion","_coreVersion","_compatibleVersions"];

A3EAI_directory = "A3EAI"; //PREFIX

_coreVersion = [configFile >> "CfgPatches" >> "A3EAI","A3EAIVersion","<not found>"] call BIS_fnc_returnConfigEntry;
_configVersion = [configFile >> "CfgPatches" >> "A3EAI_config","A3EAIVersion","<not found>"] call BIS_fnc_returnConfigEntry;
_compatibleVersions = [configFile >> "CfgPatches" >> "A3EAI","compatibleConfigVersions",[]] call BIS_fnc_returnConfigEntry;
_serverDir = [missionConfigFile >> "CfgDeveloperOptions","serverDir","@A3EAI"] call BIS_fnc_returnConfigEntry;
_readOverrideFile = (([missionConfigFile >> "CfgDeveloperOptions","readOverrideFile",0] call BIS_fnc_returnConfigEntry) isEqualTo 1);
_reportDirectoryName = (([missionConfigFile >> "CfgDeveloperOptions","reportDirectoryName",0] call BIS_fnc_returnConfigEntry) isEqualTo 1);
A3EAI_enableDebugMarkers = (([missionConfigFile >> "CfgDeveloperOptions","enableDebugMarkers",0] call BIS_fnc_returnConfigEntry) isEqualTo 1);

if (_reportDirectoryName) then {
	diag_log format ["Debug: File is [%1]",__FILE__];
};

if !(_configVersion in _compatibleVersions) exitWith {
	diag_log format ["A3EAI Error: Incompatible A3EAI core and config pbo versions. Core: %1. Config: %2. Please update both A3EAI.pbo and A3EAI_config.pbo.",_coreVersion,_configVersion];
};

//Report A3EAI version to RPT log
diag_log format ["[A3EAI] Initializing A3EAI version %1 using base path %2.",[configFile >> "CfgPatches" >> "A3EAI","A3EAIVersion","error - unknown version"] call BIS_fnc_returnConfigEntry,A3EAI_directory];

//Load A3EAI functions
_functionsCheck = call compile preprocessFileLineNumbers format ["%1\init\A3EAI_functions.sqf",A3EAI_directory];
if (isNil "_functionsCheck") exitWith {diag_log "A3EAI Critical Error: Functions not successfully loaded. Stopping startup procedure.";};

//Load A3EAI settings
_configCheck = call compile preprocessFileLineNumbers format ["%1\init\loadSettings.sqf",A3EAI_directory];
if (isNil "_configCheck") exitWith {diag_log "A3EAI Critical Error: Configuration file not successfully loaded. Stopping startup procedure.";};

//Load custom A3EAI settings file.
if ((_readOverrideFile) && {isFilePatchingEnabled}) then {call compile preprocessFileLineNumbers format ["%1\A3EAI_settings_override.sqf",_serverDir];};

//Create reference marker to act as boundary for spawning AI air/land vehicles.
_worldname = (toLower worldName);
_markerInfo = call {
	{
		if (_worldname isEqualTo (_x select 0)) exitWith {
			[_x select 1,_x select 2]
		};
	} forEach [
		//worldName, center position, landmass radius
		["altis",[15834.2,15787.8,0],12000],
		["australia",[21966.2,22728.5,0],15000],
		["bootcamp_acr",[1938.24,1884.16,0],1800],
		["caribou",[3938.9722, 4195.7417],3500],
		["chernarus",[7652.9634, 7870.8076],5500],
		["chernarus_summer",[6669.88,9251.68,0],6000],
		["desert_e",[1034.26,1022.18,0],1000],
		["esseker",[6206.94,5920.05,0],5700],
		["fallujah",[5139.8008, 4092.6797],4000],
		["fdf_isle1_a",[10771.362, 8389.2568],2750],
		["intro",[2914.44,2771.61,0],900],
		["isladuala",[4945.3438, 4919.6616],4000],
		["lingor",[5166.5581, 5108.8301],4500],
		["mbg_celle2",[6163.52, 6220.3984],6000],
		["mountains_acr",[3223.09,3242.13,0],3100],
		["namalsk",[5880.1313, 8889.1045],3000],
		["napf",[10725.096, 9339.918],8500],
		["oring",[5191.1069, 5409.1938],4750],
		["panthera2",[5343.6953, 4366.2534],3500],
		["porto",[2641.45,2479.77,0],800],
		["sara",[12693.104, 11544.386],6250],
		["saralite",[5357.5,5000.67,0],3000],
		["sara_dbe1",[11995.3,11717.9,0],7000],
		["sauerland",[12270.443, 13632.132],17500],
		["smd_sahrani_a2",[12693.104, 11544.386],6250],
		["stratis",[3937.6,4774.51,0],3000],
		["takistan",[6368.2764, 6624.2744],6000],
		["tavi",[10887.825, 11084.657],8500],
		["trinity",[7183.8403, 7067.4727],5300],
		["utes",[3519.8037, 3703.0649],1000],
		["woodland_acr",[3884.41,3896.44,0],3700],
		["zargabad",[3917.6201, 3800.0376],2000],
		[_worldname,getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition"),worldSize/2]
	];
};
_centerMarker = createMarkerLocal ["A3EAI_centerMarker",_markerInfo select 0];
_centerMarker setMarkerSizeLocal [_markerInfo select 1,_markerInfo select 1];

//Set side relations only if needed
_allUnits = +allUnits;
if (({if ((side _x) isEqualTo PLAYER_GROUP_SIDE2) exitWith {1}} count _allUnits) isEqualTo 0) then {createCenter PLAYER_GROUP_SIDE2};
if (({if ((side _x) isEqualTo PLAYER_GROUP_SIDE1) exitWith {1}} count _allUnits) isEqualTo 0) then {createCenter PLAYER_GROUP_SIDE1};
if (({if ((side _x) isEqualTo AI_GROUP_SIDE) exitWith {1}} count _allUnits) isEqualTo 0) then {createCenter AI_GROUP_SIDE};
if ((AI_GROUP_SIDE getFriend PLAYER_GROUP_SIDE1) > 0) then {AI_GROUP_SIDE setFriend [PLAYER_GROUP_SIDE1, 0]};
if ((AI_GROUP_SIDE getFriend PLAYER_GROUP_SIDE2) > 0) then {AI_GROUP_SIDE setFriend [PLAYER_GROUP_SIDE2, 0]};
if ((PLAYER_GROUP_SIDE2 getFriend AI_GROUP_SIDE) > 0) then {PLAYER_GROUP_SIDE2 setFriend [AI_GROUP_SIDE, 0]};
if ((PLAYER_GROUP_SIDE1 getFriend AI_GROUP_SIDE) > 0) then {PLAYER_GROUP_SIDE1 setFriend [AI_GROUP_SIDE, 0]};

//Continue loading required A3EAI script files
[] execVM format ['%1\init\A3EAI_post_init.sqf',A3EAI_directory];

//Report A3EAI startup settings to RPT log
diag_log format ["[A3EAI] A3EAI settings: Debug Level: %1. WorldName: %2. VerifyClassnames: %3. VerifySettings: %4.",A3EAI_debugLevel,_worldname,A3EAI_verifyClassnames,A3EAI_verifySettings];
diag_log format ["[A3EAI] AI spawn settings: Static: %1. Dynamic: %2. Random: %3. Air: %4. Land: %5. UAV: %6. UGV: %7.",A3EAI_enableStaticSpawns,!(A3EAI_maxDynamicSpawns isEqualTo 0),!(A3EAI_maxRandomSpawns isEqualTo 0),!(A3EAI_maxAirPatrols isEqualTo 0),!(A3EAI_maxLandPatrols isEqualTo 0),!(A3EAI_maxUAVPatrols isEqualTo 0),!(A3EAI_maxUGVPatrols isEqualTo 0)];
diag_log format ["[A3EAI] A3EAI loading completed in %1 seconds.",(diag_tickTime - _startTime)];
