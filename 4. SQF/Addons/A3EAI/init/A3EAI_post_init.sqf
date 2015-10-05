#include "\A3EAI\globaldefines.hpp"

/*
	A3EAI Startup
	
	Description: Handles post-initialization tasks

*/

if (A3EAI_debugLevel > 0) then {diag_log "A3EAI Debug: A3EAI Startup is running required script files..."};

call compile preprocessFileLineNumbers format ["%1\init\variables.sqf",A3EAI_directory];
call compile preprocessFileLineNumbers format ["%1\init\variables_precalculated.sqf",A3EAI_directory];

if (A3EAI_enableHC) then {
	[] call compile preprocessFileLineNumbers format ["%1\init\A3EAI_ServerHC_functions.sqf",A3EAI_directory];
	[] call compile preprocessFileLineNumbers format ["%1\init\A3EAI_ServerHC_PVEH.sqf",A3EAI_directory];
	diag_log "[A3EAI] A3EAI is now listening for headless client connection.";
};

//Create default trigger object if AI is spawned without trigger object specified (ie: for custom vehicle AI groups)
_nul = [] spawn {
	A3EAI_defaultTrigger = createTrigger [TRIGGER_OBJECT,[configFile >> "CfgWorlds" >> worldName,"centerPosition",[0,0,0]] call BIS_fnc_returnConfigEntry,false];
	A3EAI_defaultTrigger enableSimulation false;
	A3EAI_defaultTrigger setVariable ["isCleaning",true];
	A3EAI_defaultTrigger setVariable ["patrolDist",100];
	A3EAI_defaultTrigger setVariable ["unitLevel",1];
	A3EAI_defaultTrigger setVariable ["unitLevelEffective",1];
	A3EAI_defaultTrigger setVariable ["locationArray",[]];
	A3EAI_defaultTrigger setVariable ["maxUnits",[0,0]];
	A3EAI_defaultTrigger setVariable ["GroupSize",0];
	A3EAI_defaultTrigger setVariable ["initialized",true];
	A3EAI_defaultTrigger setVariable ["spawnChance",0];
	A3EAI_defaultTrigger setVariable ["spawnType",""];
	A3EAI_defaultTrigger setTriggerText "Default Trigger Object";
	if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Default trigger check result: %1",[!(isNull A3EAI_defaultTrigger),(typeOf A3EAI_defaultTrigger),(getPosASL A3EAI_defaultTrigger)]]};
};

[
	//Input variable - Gradechances array, Output variable - Gradeindices array
	["A3EAI_levelChancesAir","A3EAI_levelIndicesAir"],
	["A3EAI_levelChancesLand","A3EAI_levelIndicesLand"],
	["A3EAI_levelChancesUAV","A3EAI_levelIndicesUAV"],
	["A3EAI_levelChancesUGV","A3EAI_levelIndicesUGV"],
	["A3EAI_useWeaponChance0","A3EAI_weaponTypeIndices0"],
	["A3EAI_useWeaponChance1","A3EAI_weaponTypeIndices1"],
	["A3EAI_useWeaponChance2","A3EAI_weaponTypeIndices2"],
	["A3EAI_useWeaponChance3","A3EAI_weaponTypeIndices3"]
] call compile preprocessFileLineNumbers format ["%1\scripts\buildWeightedTables.sqf",A3EAI_directory];

if (A3EAI_verifyClassnames) then {
	A3EAI_tableChecklist = ["A3EAI_pistolList","A3EAI_rifleList","A3EAI_machinegunList","A3EAI_sniperList","A3EAI_headgearTypes0","A3EAI_headgearTypes1","A3EAI_headgearTypes2","A3EAI_headgearTypes3",
				"A3EAI_backpackTypes0","A3EAI_backpackTypes1","A3EAI_backpackTypes2","A3EAI_backpackTypes3","A3EAI_foodLoot","A3EAI_MiscLoot1","A3EAI_MiscLoot2","A3EAI_airReinforcementVehicles",
				"A3EAI_uniformTypes0","A3EAI_uniformTypes1","A3EAI_uniformTypes2","A3EAI_uniformTypes3","A3EAI_launcherTypes","A3EAI_vestTypes0","A3EAI_vestTypes1","A3EAI_vestTypes2","A3EAI_vestTypes3"];
};


if (A3EAI_generateDynamicUniforms) then {
	_skinlist = [] execVM format ['%1\scripts\A3EAI_buildUniformList.sqf',A3EAI_directory];
	waitUntil {uiSleep 0.05; scriptDone _skinlist};
};

//Build weapon classname tables
if (A3EAI_generateDynamicWeapons) then {
	_weaponlist = [] execVM format ['%1\scripts\A3EAI_buildWeaponList.sqf',A3EAI_directory];
	waitUntil {uiSleep 0.05; scriptDone _weaponlist};
};

//Build backpack classname tables
if (A3EAI_generateDynamicBackpacks) then {
	_backpacklist = [] execVM format ['%1\scripts\A3EAI_buildBackpackList.sqf',A3EAI_directory];
	waitUntil {uiSleep 0.05; scriptDone _backpacklist};
};

//Build vest classname tables
if (A3EAI_generateDynamicVests) then {
	_vestlist = [] execVM format ['%1\scripts\A3EAI_buildVestList.sqf',A3EAI_directory];
	waitUntil {uiSleep 0.05; scriptDone _vestlist};
};

//Build headgear classname tables
if (A3EAI_generateDynamicHeadgear) then {
	_headgearlist = [] execVM format ['%1\scripts\A3EAI_buildHeadgearList.sqf',A3EAI_directory];
	waitUntil {uiSleep 0.05; scriptDone _headgearlist};
};

//Build food classname tables (1)
if (A3EAI_generateDynamicFood) then {
	_foodlist = [] execVM format ['%1\scripts\A3EAI_buildFoodList.sqf',A3EAI_directory];
	waitUntil {uiSleep 0.05; scriptDone _foodlist};
};

//Build generic loot classname tables (1)
if (A3EAI_generateDynamicLoot) then {
	_lootlist = [] execVM format ['%1\scripts\A3EAI_buildLootList.sqf',A3EAI_directory];
	waitUntil {uiSleep 0.05; scriptDone _lootlist};
	
	_lootlist2 = [] execVM format ['%1\scripts\A3EAI_buildLootLargeList.sqf',A3EAI_directory];
	waitUntil {uiSleep 0.05; scriptDone _lootlist2};
};

if (A3EAI_generateDynamicOptics) then {
	_weaponScopes = [] execVM format ['%1\scripts\A3EAI_buildScopeList.sqf',A3EAI_directory];
	waitUntil {uiSleep 0.05; scriptDone _weaponScopes};
};

//Check classname tables if enabled
if (A3EAI_verifyClassnames) then {
	_verifyClassnames = [] execVM format ["%1\scripts\verifyClassnames.sqf",A3EAI_directory];
	waitUntil {uiSleep 0.05; scriptDone _verifyClassnames};
};

if (A3EAI_enableHC && {A3EAI_waitForHC}) then {
	diag_log "[A3EAI] Waiting for headless client to connect. A3EAI post-initialization process paused.";
	waitUntil {uiSleep 5; A3EAI_HCIsConnected};
	diag_log format ["[A3EAI] Headless client connected with owner ID %1. A3EAI post-initialization process continuing.",A3EAI_HCObjectOwnerID];
};

A3EAI_classnamesVerified = true;

//Build map location list.
_setupLocations = [] execVM format ['%1\scripts\setup_locations.sqf',A3EAI_directory];

//Set up auto-generated static spawns
if (A3EAI_enableStaticSpawns) then {
	_staticSpawns = [] execVM format ["%1\scripts\generateStaticSpawns.sqf",A3EAI_directory];
};

//Start dynamic spawn manager
if !(A3EAI_maxDynamicSpawns isEqualTo 0) then {
	_dynManagerV2 = [] execVM format ['%1\scripts\dynamicSpawn_manager.sqf',A3EAI_directory];
};

//Set up vehicle patrols
if ((A3EAI_maxAirPatrols > 0) or {(A3EAI_maxLandPatrols > 0)}) then {
	_vehicles = [] execVM format ['%1\scripts\setup_veh_patrols.sqf',A3EAI_directory];
};

//Load custom definitions file
if (A3EAI_loadCustomFile) then {
	if (isClass (configFile >> "CfgA3EAISettings")) then {
		_customLoader = [] execVM format ["%1\init\A3EAI_custom_loader.sqf",A3EAI_directory]; //0.1.8
	} else {
		diag_log "A3EAI Error: Could not load A3EAI_config.pbo. Unable to load custom definitions.";
	};
};

//Load A3EAI server monitor
_serverMonitor = [] execVM format ['%1\scripts\A3EAI_serverMonitor.sqf',A3EAI_directory];
