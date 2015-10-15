#include "\A3EAI\globaldefines.hpp"

private["_verified","_errorFound","_startTime"];

_startTime = diag_tickTime;

_verified = [];

{
	_array = missionNamespace getVariable [_x,[]];
	_errorFound = false;
	{
		if !(_x in _verified) then {
			call {
				if ((isNil {_x}) or {!((typeName _x) isEqualTo "STRING")}) exitWith {
					diag_log format ["A3EAI] Removing non-string item %1 from classname table.",_x];
					_array set [_forEachIndex,""];
					if (!_errorFound) then {_errorFound = true};
				};
				if (isClass (configFile >> "CfgWeapons" >> _x)) exitWith {
					if (((configName (inheritsFrom (configFile >> "CfgWeapons" >> _x))) isEqualTo "FakeWeapon") or {(getNumber (configFile >> "CfgWeapons" >> _x >> "scope")) isEqualTo 0}) then {
						diag_log format ["[A3EAI] Removing invalid classname: %1.",_x];
						_array set [_forEachIndex,""];
						if (!_errorFound) then {_errorFound = true};
					} else {
						_verified pushBack _x;
					};
				};
				if (isClass (configFile >> "CfgMagazines" >> _x)) exitWith {
					if (((configName (inheritsFrom (configFile >> "CfgMagazines" >> _x))) isEqualTo "FakeMagazine") or {(getNumber (configFile >> "CfgMagazines" >> _x >> "scope")) isEqualTo 0}) then {
						diag_log format ["[A3EAI] Removing invalid classname: %1.",_x];
						_array set [_forEachIndex,""];
						if (!_errorFound) then {_errorFound = true};
					} else {
						_verified pushBack _x;
					};
				};
				if (isClass (configFile >> "CfgVehicles" >> _x)) exitWith {
					if (((configName (inheritsFrom (configFile >> "CfgVehicles" >> _x))) isEqualTo "Banned") or {(getNumber (configFile >> "CfgVehicles" >> _x >> "scope")) isEqualTo 0}) then {
						diag_log format ["[A3EAI] Removing invalid classname: %1.",_x];
						_array set [_forEachIndex,""];
						if (!_errorFound) then {_errorFound = true};
					} else {
						_verified pushBack _x;
					};
				};
				diag_log format ["[A3EAI] Removing invalid classname: %1.",_x];	//Default case - if classname doesn't exist at all
				_array set [_forEachIndex,""];
				if (!_errorFound) then {_errorFound = true};
			};
		};
	} forEach _array;
	if (_errorFound) then {
		_array = _array - [""];
		missionNamespace setVariable [_x,_array];
		diag_log format ["[A3EAI] Contents of %1 failed verification. Invalid entries removed.",_x];
		//diag_log format ["DEBUG :: Corrected contents of %1: %2.",_x,_array];
		//diag_log format ["DEBUG :: Comparison check of %1: %2.",_x,missionNamespace getVariable [_x,[]]];
	};
} forEach A3EAI_tableChecklist;

if (A3EAI_maxAirPatrols > 0) then {
	{
		try {
			if ((typeName _x) != "ARRAY") then {
				throw format ["[A3EAI] Removing non-array type element from A3EAI_airVehicleList array: %1.",_x];
			};
			if ((count _x) < 2) then {
				throw format ["[A3EAI] Array in A3EAI_airVehicleList has only one element: %1. 2 expected: {Classname, Amount}.",_x];
			};
			if (!((_x select 0) isKindOf "Air")) then {
				throw format ["[A3EAI] Removing non-Air type vehicle from A3EAI_airVehicleList array: %1.",(_x select 0)];
			};
		} catch {
			diag_log _exception;
			A3EAI_airVehicleList deleteAt _forEachIndex;
		};
	} forEach A3EAI_airVehicleList;
};

if (A3EAI_maxLandPatrols > 0) then {
	{
		try {
			if ((typeName _x) != "ARRAY") then {
				throw format ["[A3EAI] Removing non-array type element from A3EAI_landVehicleList array: %1.",_x];
			};
			if ((count _x) < 2) then {
				throw format ["[A3EAI] Array in A3EAI_landVehicleList has only one element: %1. 2 expected: {Classname, Amount}.",_x];
			};
			if (!((_x select 0) isKindOf "LandVehicle")) then {
				throw format ["[A3EAI] Removing non-LandVehicle type vehicle from A3EAI_landVehicleList array: %1.",(_x select 0)];
			};
			if (((_x select 0) isKindOf "StaticWeapon")) then {
				throw format ["[A3EAI] Removing StaticWeapon type vehicle from A3EAI_landVehicleList array: %1.",(_x select 0)];
			};
		} catch {
			diag_log _exception;
			A3EAI_landVehicleList deleteAt _forEachIndex;
		};
	} forEach A3EAI_landVehicleList;
};

if (A3EAI_maxAirReinforcements > 0) then {
	{
		try {
			if (!(_x isKindOf "Air")) then {
				throw format ["[A3EAI] Removing non-Air type vehicle from A3EAI_airReinforcementVehicles array: %1.",_x];
			};
		} catch {
			diag_log _exception;
			A3EAI_airReinforcementVehicles deleteAt _forEachIndex;
		};
	} forEach A3EAI_airReinforcementVehicles;
};

if (A3EAI_maxUAVPatrols > 0) then {
	{
		try {
			if ((typeName _x) != "ARRAY") then {
				throw format ["[A3EAI] Removing non-array type element from A3EAI_UAVList array: %1.",_x];
			};
			if ((count _x) < 2) then {
				throw format ["[A3EAI] Array in A3EAI_UAVList has only one element: %1. 2 expected: {Classname, Amount}.",_x];
			};
			if (!((_x select 0) isKindOf "Air")) then {
				throw format ["[A3EAI] Removing non-Air type vehicle from A3EAI_UAVList array: %1.",(_x select 0)];
			};
		} catch {
			diag_log _exception;
			A3EAI_UAVList deleteAt _forEachIndex;
		};
	} forEach A3EAI_UAVList;
};

if (A3EAI_maxUGVPatrols > 0) then {
	{
		try {
			if ((typeName _x) != "ARRAY") then {
				throw format ["[A3EAI] Removing non-array type element from A3EAI_UGVList array: %1.",_x];
			};
			if ((count _x) < 2) then {
				throw format ["[A3EAI] Array in A3EAI_UGVList has only one element: %1. 2 expected: {Classname, Amount}.",_x];
			};
			if (!((_x select 0) isKindOf "LandVehicle")) then {
				throw format ["[A3EAI] Removing non-LandVehicle type vehicle from A3EAI_UGVList array: %1.",(_x select 0)];
			};
			if (((_x select 0) isKindOf "StaticWeapon")) then {
				throw format ["[A3EAI] Removing StaticWeapon type vehicle from A3EAI_UGVList array: %1.",(_x select 0)];
			};
		} catch {
			diag_log _exception;
			A3EAI_UGVList deleteAt _forEachIndex;
		};
	} forEach A3EAI_UGVList;
};

{
	if (([configFile >> "CfgWeapons" >> _x >> "ItemInfo","uniformClass",""] call BIS_fnc_returnConfigEntry) isEqualTo "") then {
		diag_log format ["[A3EAI] Removing invalid uniform classname from A3EAI_uniformTypes0 array: %1.",_x];
		A3EAI_uniformTypes0 set [_forEachIndex,""];
	};
} forEach A3EAI_uniformTypes0;
if ("" in A3EAI_uniformTypes0) then {A3EAI_uniformTypes0 = A3EAI_uniformTypes0 - [""];};

{
	if (([configFile >> "CfgWeapons" >> _x >> "ItemInfo","uniformClass",""] call BIS_fnc_returnConfigEntry) isEqualTo "") then {
		diag_log format ["[A3EAI] Removing invalid uniform classname from A3EAI_uniformTypes1 array: %1.",_x];
		A3EAI_uniformTypes1 set [_forEachIndex,""];
	};
} forEach A3EAI_uniformTypes1;
if ("" in A3EAI_uniformTypes1) then {A3EAI_uniformTypes1 = A3EAI_uniformTypes1 - [""];};

{
	if (([configFile >> "CfgWeapons" >> _x >> "ItemInfo","uniformClass",""] call BIS_fnc_returnConfigEntry) isEqualTo "") then {
		diag_log format ["[A3EAI] Removing invalid uniform classname from A3EAI_uniformTypes2 array: %1.",_x];
		A3EAI_uniformTypes2 set [_forEachIndex,""];
	};
} forEach A3EAI_uniformTypes2;
if ("" in A3EAI_uniformTypes2) then {A3EAI_uniformTypes2 = A3EAI_uniformTypes2 - [""];};

{
	if (([configFile >> "CfgWeapons" >> _x >> "ItemInfo","uniformClass",""] call BIS_fnc_returnConfigEntry) isEqualTo "") then {
		diag_log format ["[A3EAI] Removing invalid uniform classname from A3EAI_uniformTypes3 array: %1.",_x];
		A3EAI_uniformTypes3 set [_forEachIndex,""];
	};
} forEach A3EAI_uniformTypes3;
if ("" in A3EAI_uniformTypes3) then {A3EAI_uniformTypes3 = A3EAI_uniformTypes3 - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x,"type",-1] call BIS_fnc_returnConfigEntry) isEqualTo 2) then {
		diag_log format ["[A3EAI] Removing invalid pistol classname from A3EAI_pistolList array: %1.",_x];
		A3EAI_pistolList set [_forEachIndex,""];
	};
} forEach A3EAI_pistolList;
if ("" in A3EAI_pistolList) then {A3EAI_pistolList = A3EAI_pistolList - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x,"type",-1] call BIS_fnc_returnConfigEntry) isEqualTo 1) then {
		diag_log format ["[A3EAI] Removing invalid rifle classname from A3EAI_rifleList array: %1.",_x];
		A3EAI_rifleList set [_forEachIndex,""];
	};
} forEach A3EAI_rifleList;
if ("" in A3EAI_rifleList) then {A3EAI_rifleList = A3EAI_rifleList - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x,"type",-1] call BIS_fnc_returnConfigEntry) isEqualTo 1) then {
		diag_log format ["[A3EAI] Removing invalid machine gun classname from A3EAI_machinegunList array: %1.",_x];
		A3EAI_machinegunList set [_forEachIndex,""];
	};
} forEach A3EAI_machinegunList;
if ("" in A3EAI_machinegunList) then {A3EAI_machinegunList = A3EAI_machinegunList - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x,"type",-1] call BIS_fnc_returnConfigEntry) isEqualTo 1) then {
		diag_log format ["[A3EAI] Removing invalid sniper classname from A3EAI_sniperList array: %1.",_x];
		A3EAI_sniperList set [_forEachIndex,""];
	};
} forEach A3EAI_sniperList;
if ("" in A3EAI_sniperList) then {A3EAI_sniperList = A3EAI_sniperList - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x,"type",-1] call BIS_fnc_returnConfigEntry) isEqualTo 4) then {
		diag_log format ["[A3EAI] Removing invalid launcher classname from A3EAI_launcherTypes array: %1.",_x];
		A3EAI_launcherTypes set [_forEachIndex,""];
	};
} forEach A3EAI_launcherTypes;
if ("" in A3EAI_launcherTypes) then {A3EAI_launcherTypes = A3EAI_launcherTypes - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x >> "ItemInfo","mountAction",""] call BIS_fnc_returnConfigEntry) isEqualTo "MountOptic") then {
		diag_log format ["[A3EAI] Removing invalid optics classname from A3EAI_weaponOpticsList array: %1.",_x];
		A3EAI_weaponOpticsList set [_forEachIndex,""];
	};
} forEach A3EAI_weaponOpticsList;
if ("" in A3EAI_weaponOpticsList) then {A3EAI_weaponOpticsList = A3EAI_weaponOpticsList - [""];};

{
	if !(([configFile >> "CfgVehicles" >> _x,"vehicleClass",""] call BIS_fnc_returnConfigEntry) isEqualTo "Backpacks") then {
		diag_log format ["[A3EAI] Removing invalid backpack classname from A3EAI_backpackTypes0 array: %1.",_x];
		A3EAI_backpackTypes0 set [_forEachIndex,""];
	};
} forEach A3EAI_backpackTypes0;
if ("" in A3EAI_backpackTypes0) then {A3EAI_backpackTypes0 = A3EAI_backpackTypes0 - [""];};

{
	if !(([configFile >> "CfgVehicles" >> _x,"vehicleClass",""] call BIS_fnc_returnConfigEntry) isEqualTo "Backpacks") then {
		diag_log format ["[A3EAI] Removing invalid backpack classname from A3EAI_backpackTypes1 array: %1.",_x];
		A3EAI_backpackTypes1 set [_forEachIndex,""];
	};
} forEach A3EAI_backpackTypes1;
if ("" in A3EAI_backpackTypes1) then {A3EAI_backpackTypes1 = A3EAI_backpackTypes1 - [""];};

{
	if !(([configFile >> "CfgVehicles" >> _x,"vehicleClass",""] call BIS_fnc_returnConfigEntry) isEqualTo "Backpacks") then {
		diag_log format ["[A3EAI] Removing invalid backpack classname from A3EAI_backpackTypes2 array: %1.",_x];
		A3EAI_backpackTypes2 set [_forEachIndex,""];
	};
} forEach A3EAI_backpackTypes2;
if ("" in A3EAI_backpackTypes2) then {A3EAI_backpackTypes2 = A3EAI_backpackTypes2 - [""];};

{
	if !(([configFile >> "CfgVehicles" >> _x,"vehicleClass",""] call BIS_fnc_returnConfigEntry) isEqualTo "Backpacks") then {
		diag_log format ["[A3EAI] Removing invalid backpack classname from A3EAI_backpackTypes3 array: %1.",_x];
		A3EAI_backpackTypes3 set [_forEachIndex,""];
	};
} forEach A3EAI_backpackTypes3;
if ("" in A3EAI_backpackTypes3) then {A3EAI_backpackTypes3 = A3EAI_backpackTypes3 - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x >> "ItemInfo","hitpointName",""] call BIS_fnc_returnConfigEntry) isEqualTo "HitBody") then {
		diag_log format ["[A3EAI] Removing invalid vest classname from A3EAI_vestTypes0 array: %1.",_x];
		A3EAI_vestTypes0 set [_forEachIndex,""];
	};
} forEach A3EAI_vestTypes0;
if ("" in A3EAI_vestTypes0) then {A3EAI_vestTypes0 = A3EAI_vestTypes0 - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x >> "ItemInfo","hitpointName",""] call BIS_fnc_returnConfigEntry) isEqualTo "HitBody") then {
		diag_log format ["[A3EAI] Removing invalid vest classname from A3EAI_vestTypes1 array: %1.",_x];
		A3EAI_vestTypes1 set [_forEachIndex,""];
	};
} forEach A3EAI_vestTypes1;
if ("" in A3EAI_vestTypes1) then {A3EAI_vestTypes1 = A3EAI_vestTypes1 - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x >> "ItemInfo","hitpointName",""] call BIS_fnc_returnConfigEntry) isEqualTo "HitBody") then {
		diag_log format ["[A3EAI] Removing invalid vest classname from A3EAI_vestTypes2 array: %1.",_x];
		A3EAI_vestTypes2 set [_forEachIndex,""];
	};
} forEach A3EAI_vestTypes2;
if ("" in A3EAI_vestTypes2) then {A3EAI_vestTypes2 = A3EAI_vestTypes2 - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x >> "ItemInfo","hitpointName",""] call BIS_fnc_returnConfigEntry) isEqualTo "HitBody") then {
		diag_log format ["[A3EAI] Removing invalid vest classname from A3EAI_vestTypes3 array: %1.",_x];
		A3EAI_vestTypes3 set [_forEachIndex,""];
	};
} forEach A3EAI_vestTypes3;
if ("" in A3EAI_vestTypes3) then {A3EAI_vestTypes3 = A3EAI_vestTypes3 - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x >> "ItemInfo","hitpointName",""] call BIS_fnc_returnConfigEntry) isEqualTo "HitHead") then {
		diag_log format ["[A3EAI] Removing invalid headgear classname from A3EAI_headgearTypes0 array: %1.",_x];
		A3EAI_headgearTypes0 set [_forEachIndex,""];
	};
} forEach A3EAI_headgearTypes0;
if ("" in A3EAI_headgearTypes0) then {A3EAI_headgearTypes0 = A3EAI_headgearTypes0 - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x >> "ItemInfo","hitpointName",""] call BIS_fnc_returnConfigEntry) isEqualTo "HitHead") then {
		diag_log format ["[A3EAI] Removing invalid headgear classname from A3EAI_headgearTypes1 array: %1.",_x];
		A3EAI_headgearTypes1 set [_forEachIndex,""];
	};
} forEach A3EAI_headgearTypes1;
if ("" in A3EAI_headgearTypes1) then {A3EAI_headgearTypes1 = A3EAI_headgearTypes1 - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x >> "ItemInfo","hitpointName",""] call BIS_fnc_returnConfigEntry) isEqualTo "HitHead") then {
		diag_log format ["[CfgWeapons] Removing invalid headgear classname from A3EAI_headgearTypes2 array: %1.",_x];
		A3EAI_headgearTypes2 set [_forEachIndex,""];
	};
} forEach A3EAI_headgearTypes2;
if ("" in A3EAI_headgearTypes2) then {A3EAI_headgearTypes2 = A3EAI_headgearTypes2 - [""];};

{
	if !(([configFile >> "CfgWeapons" >> _x >> "ItemInfo","hitpointName",""] call BIS_fnc_returnConfigEntry) isEqualTo "HitHead") then {
		diag_log format ["[A3EAI] Removing invalid headgear classname from A3EAI_headgearTypes3 array: %1.",_x];
		A3EAI_headgearTypes3 set [_forEachIndex,""];
	};
} forEach A3EAI_headgearTypes3;
if ("" in A3EAI_headgearTypes3) then {A3EAI_headgearTypes3 = A3EAI_headgearTypes3 - [""];};

{
	if !(([configFile >> "CfgMagazines" >> _x,"interactText",""] call BIS_fnc_returnConfigEntry) in ["EAT","DRINK","CONSUME"]) then {
		diag_log format ["[A3EAI] Removing invalid food classname from A3EAI_foodLoot array: %1.",_x];
		A3EAI_foodLoot set [_forEachIndex,""];
	};
} forEach A3EAI_foodLoot;
if ("" in A3EAI_foodLoot) then {A3EAI_foodLoot = A3EAI_foodLoot - [""];};


//Anticipate cases where all elements of an array are invalid
if (A3EAI_pistolList isEqualTo []) then {A3EAI_pistolList = ["hgun_Pistol_heavy_01_F","hgun_P07_F","hgun_Rook40_F","hgun_Pistol_heavy_02_F","1911_pistol_epoch","hgun_ACPC2_F","ruger_pistol_epoch"]};
if (A3EAI_rifleList isEqualTo []) then {A3EAI_rifleList = ["AKM_EPOCH","sr25_epoch","arifle_Katiba_GL_F","arifle_Katiba_C_F","arifle_Katiba_F","arifle_MX_GL_F","arifle_MX_GL_Black_F","arifle_MXM_Black_F","arifle_MXC_Black_F","arifle_MX_Black_F","arifle_MXM_F","arifle_MXC_F","arifle_MX_F","l85a2_epoch","l85a2_pink_epoch","l85a2_ugl_epoch","m4a3_EPOCH","m16_EPOCH","m16Red_EPOCH","arifle_Mk20_GL_F","arifle_Mk20_GL_plain_F","arifle_Mk20C_F","arifle_Mk20C_plain_F","arifle_Mk20_F","arifle_Mk20_plain_F","arifle_TRG21_GL_F","arifle_TRG21_F","arifle_TRG20_F","arifle_SDAR_F","Rollins_F","SMG_01_F","SMG_02_F","hgun_PDW2000_F"]};
if (A3EAI_machinegunList isEqualTo []) then {A3EAI_machinegunList = ["LMG_Zafir_F","arifle_MX_SW_F","arifle_MX_SW_Black_F","LMG_Mk200_F","m249_EPOCH","m249Tan_EPOCH","MMG_01_hex_F","MMG_01_tan_F","MMG_02_camo_F","MMG_02_black_F","MMG_02_sand_F"]};
if (A3EAI_sniperList isEqualTo []) then {A3EAI_sniperList = ["m107_EPOCH","m107Tan_EPOCH","srifle_DMR_02_F","srifle_DMR_02_camo_F","srifle_DMR_02_sniper_F","srifle_DMR_03_F","srifle_DMR_03_khaki_F","srifle_DMR_03_tan_F","srifle_DMR_03_multicam_F","srifle_DMR_03_woodland_F","srifle_DMR_03_spotter_F","srifle_DMR_04_F","srifle_DMR_04_Tan_F","srifle_DMR_05_blk_F","srifle_DMR_05_hex_F","srifle_DMR_05_tan_f","srifle_DMR_06_camo_F","srifle_DMR_06_olive_F","srifle_LRR_F","srifle_GM6_F","srifle_DMR_01_F","M14_EPOCH","M14Grn_EPOCH","srifle_EBR_F"]};
if (A3EAI_foodLoot isEqualTo []) then {A3EAI_foodLootCount = 0};
if (A3EAI_MiscLoot1 isEqualTo []) then {A3EAI_miscLootCount1 = 0};
if (A3EAI_MiscLoot2 isEqualTo []) then {A3EAI_miscLootCount2 = 0};
if (A3EAI_airReinforcementVehicles isEqualTo []) then {A3EAI_maxAirReinforcements = 0; A3EAI_airReinforcementSpawnChance1 = 0; A3EAI_airReinforcementSpawnChance2 = 0; A3EAI_airReinforcementSpawnChance3 = 0;};

diag_log format ["[A3EAI] Verified %1 unique classnames in %2 seconds.",(count _verified),(diag_tickTime - _startTime)];
