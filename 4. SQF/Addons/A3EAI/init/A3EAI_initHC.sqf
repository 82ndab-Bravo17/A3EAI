/*
	A3EAI Server Initialization File
	
	Description: Handles startup process for A3EAI. Does not contain any values intended for modification.
*/

if (hasInterface || isDedicated || !isNil "A3EAI_HC_isActive") exitWith {};

_startTime = diag_tickTime;

A3EAI_HC_isActive = true;
A3EAI_directory = "A3EAI";
A3EAI_HCPlayerLoggedIn = false;
A3EAI_HCGroupsCount = 0;
A3EAI_enableHC = true;

if (isNil "A3EAI_devOptions") then {
	A3EAI_overrideEnabled = nil;
	A3EAI_debugMarkersEnabled = false;
} else {
	if !((typeName A3EAI_devOptions) isEqualTo "ARRAY") then {A3EAI_devOptions = []};
	if ("readoverridefile" in A3EAI_devOptions) then {A3EAI_overrideEnabled = true} else {A3EAI_overrideEnabled = nil};
	if ("enabledebugmarkers" in A3EAI_devOptions) then {A3EAI_debugMarkersEnabled = true} else {A3EAI_debugMarkersEnabled = false};
	A3EAI_devOptions = nil;
};

if (isNil "A3EAI_EpochHiveDir") then {
	A3EAI_EpochHiveDir = "@epochhive";
};

//Create reference marker to act as boundary for spawning AI air/land vehicles.
_worldName = (toLower worldName);
_markerInfo = call {
	{
		if (_worldName isEqualTo (_x select 0)) exitWith {
			[_x select 1,_x select 2]
		};
	} forEach [
		//worldName, center position, landmass radius
		["altis",[15834.2,15787.8,0],12000],
		["bornholm",[9875.75,8803.6,0],8000],
		["stratis",[3937.6,4774.51,0],3000],
		["caribou",[3938.9722, 4195.7417],3500],
		["chernarus",[7652.9634, 7870.8076],5500],
		["fallujah",[5139.8008, 4092.6797],4000],
		["fdf_isle1_a",[10771.362, 8389.2568],2750],
		["isladuala",[4945.3438, 4919.6616],4000],
		["lingor",[5166.5581, 5108.8301],4500],
		["mbg_celle2",[6163.52, 6220.3984],6000],
		["namalsk",[5880.1313, 8889.1045],3000],
		["napf",[10725.096, 9339.918],8500],
		["oring",[5191.1069, 5409.1938],4750],
		["panthera2",[5343.6953, 4366.2534],3500],
		["sara",[12693.104, 11544.386],6250],
		["smd_sahrani_a2",[12693.104, 11544.386],6250],
		["sauerland",[12270.443, 13632.132],17500],
		["takistan",[6368.2764, 6624.2744],6000],
		["tavi",[10887.825, 11084.657],8500],
		["trinity",[7183.8403, 7067.4727],5300],
		["utes",[3519.8037, 3703.0649],1000],
		["zargabad",[3917.6201, 3800.0376],2000],
		[_worldName,[configFile >> "CfgWorlds" >> worldName,"centerPosition",[0,0,0]] call BIS_fnc_returnConfigEntry,([configFile >> "CfgWorlds" >> worldName,"mapSize",14000] call BIS_fnc_returnConfigEntry) * 0.5]
	];
};
_centerMarker = createMarkerLocal ["A3EAI_centerMarker",_markerInfo select 0];
_centerMarker setMarkerSizeLocal [_markerInfo select 1,_markerInfo select 1];

_nul = [] spawn {
	_versionKey = [configFile >> "CfgPatches" >> "A3EAI_HC","A3EAI_HCVersion","0"] call BIS_fnc_returnConfigEntry;
	diag_log format ["[A3EAI] Initializing A3EAI HC build %1 using base path %2.",_versionKey,A3EAI_directory];

	//Load A3EAI config file
	diag_log "[A3EAI] Loading A3EAI configuration file...";
	call compile preprocessFileLineNumbers format ["%1\A3EAI_config.sqf",A3EAI_EpochHiveDir];
	call compile preprocessFileLineNumbers format ["%1\scripts\verifySettings.sqf",A3EAI_directory];
	if ((!isNil "A3EAI_overrideEnabled") && {A3EAI_overrideEnabled}) then {call compile preprocessFileLineNumbers format ["%1\A3EAI_settings_override.sqf",A3EAI_EpochHiveDir]};
	
	//Load internal use variables
	call compile preprocessFileLineNumbers format ["%1\init\variables.sqf",A3EAI_directory];

	//Load A3EAI functions and A3EAI HC functions
	diag_log "[A3EAI] Compiling functions...";
	call compile preprocessFileLineNumbers "A3EAI\init\A3EAI_HCFunctions.sqf";
	call compile preprocessFileLineNumbers "A3EAI\init\A3EAI_functions.sqf";
	call compile preprocessFileLineNumbers "A3EAI\init\A3EAI_HC_PVEH.sqf";
	
	diag_log format ["[A3EAI] A3EAI settings: Debug Level: %1. WorldName: %2. VerifyClassnames: %3. VerifySettings: %4.",A3EAI_debugLevel,(toLower worldName),A3EAI_verifyClassnames,A3EAI_verifySettings];

	//Build location list
	_setupLocations = [] execVM format ['%1\scripts\setup_locations.sqf',A3EAI_directory];
	waitUntil {uiSleep 0.5; scriptDone _setupLocations};
	
	diag_log "[A3EAI] Waiting for HC player object setup to be completed.";
	
	waitUntil {uiSleep 2; player == player};
	if !((typeOf player) isEqualTo "HeadlessClient_F") exitWith {
		diag_log format ["A3EAI Error: Headless client assigned to wrong player slot. Player Type: %1. Expected: HeadlessClient_F",(typeOf player)];
	};
	
	A3EAI_HCObject = player;
	A3EAI_HCObjectGroup = (group player);
	A3EAI_HCObject allowDamage false;
	
	diag_log "[A3EAI] Attempting to connect to A3EAI server...";
	A3EAI_HCLogin_PVS = [A3EAI_HCObject,_versionKey]; 
	publicVariableServer "A3EAI_HCLogin_PVS";
	_loginStart = diag_tickTime;
	waitUntil {uiSleep 1; ((!isNil "A3EAI_HC_serverResponse") or {(diag_tickTime - _loginStart) > 60})};
	
	if (isNil "A3EAI_HC_serverResponse") exitWith {
		diag_log "[A3EAI] Headless client connection timed out after 60 seconds of no response from server.";
		if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: HC Object %1. Group %2",A3EAI_HCObject,A3EAI_HCObjectGroup];};
		{deleteVehicle _x} forEach (units A3EAI_HCObjectGroup);
		deleteGroup A3EAI_HCObjectGroup;
		endMission "END1";
	};
	
	if !(A3EAI_HC_serverResponse) exitWith {
		diag_log "[A3EAI] Headless client connection unsuccessful. HC authorization request rejected (incorrect HC version?).";
		{deleteVehicle _x} forEach (units A3EAI_HCObjectGroup);
		deleteGroup A3EAI_HCObjectGroup;
		endMission "END1";
	};
	
	diag_log "[A3EAI] Headless client connection successful. HC authorization request granted.";
	
	_serverMonitor = [] execVM format ['%1\compile\A3EAI_headlessclient\A3EAI_HCMonitor.sqf',A3EAI_directory];
};
