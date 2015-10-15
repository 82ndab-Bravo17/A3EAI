_startTime = diag_tickTime;

A3EAI_pushedHCVariables = [];

_fnc_getConfigValue = {
	private ["_variableName", "_defaultValue", "_configValue", "_returnValue", "_type", "_string"];
	
	_variableName 	= _x select 0;
	_defaultValue 	= _x select 1;
	
	if (isClass (configFile >> "CfgA3EAISettings")) then {
		_configValue = configFile >> "CfgA3EAISettings" >> _variableName;
		_returnValue = call {
			_type = (typeName _defaultValue);
			if ((_type isEqualTo "SCALAR") && {isNumber _configValue}) exitWith {
				getNumber _configValue
			};
			if ((_type isEqualTo "BOOL") && {isNumber _configValue}) exitWith {
				(getNumber _configValue) isEqualTo 1
			};
			if ((_type isEqualTo "ARRAY") && {isArray _configValue}) exitWith {
				getArray _configValue
			};
			if ((_type isEqualTo "STRING") && {isText _configValue}) exitWith {
				getText _configValue
			};
			if ((_type isEqualTo "SIDE") && {isText _configValue}) exitWith {
				_string = getText _configValue;
				call {
					if (_string == "east") exitWith {east};
					if (_string == "west") exitWith {west};
					if (_string == "resistance") exitWith {resistance};
					if (_string == "civilian") exitWith {civilian};
					diag_log format ["[A3EAI] Error found in setting %1, resetting to default value.",_variableName];
					_defaultValue
				};
			};
			diag_log format ["[A3EAI] Error found in setting %1, resetting to default value.",_variableName];
			_defaultValue
		};
	} else {
		diag_log format ["[A3EAI] Error: Setting %1 not found in config, resetting to default value.",_variableName];
		_returnValue = _defaultValue;
	};
	_returnValue
};

{
	private ["_variableName", "_defaultValue", "_HCPushable", "_variableValue"];
	_variableName 	= _x select 0;
	_defaultValue 	= _x select 1;
	_HCPushable 	= [_x,2,false] call A3EAI_param;
	
	_variableValue = [_variableName,_defaultValue] call _fnc_getConfigValue;
	missionNamespace setVariable [format ["A3EAI_%1",_variableName],_variableValue];
	if (_HCPushable) then {
		A3EAI_pushedHCVariables pushBack [_variableName,_variableValue];
		//diag_log format ["Debug: Found HC variable %1:%2",_variableName,_variableValue];
	};
} forEach [
	["debugLevel",0,true], 			//HC Pushable
	["monitorReportRate",300,true], 	//HC Pushable
	["verifyClassnames",true],
	["verifySettings",true],
	["cleanupDelay",900],
	["loadCustomFile",true],
	["enableHC",false,true],			//HC Pushable
	["waitForHC",false],
	["generateDynamicWeapons",true],
	["dynamicWeaponBlacklist",[]],
	["generateDynamicOptics",true],
	["dynamicOpticsBlacklist",[]],
	["generateDynamicUniforms",true],
	["dynamicUniformBlacklist",[]],
	["generateDynamicBackpacks",true],
	["dynamicBackpackBlacklist",[]],
	["generateDynamicVests",true],
	["dynamicVestBlacklist",[]],
	["generateDynamicHeadgear",true],
	["dynamicHeadgearBlacklist",[]],
	["generateDynamicFood",true],
	["dynamicFoodBlacklist",[]],
	["generateDynamicLoot",true],
	["dynamicLootBlacklist",[]],
	["enableRadioMessages",false,true],	//HC Pushable
	["enableDeathMessages",false,true],	//HC Pushable
	["playerCountThreshold",10],
	["upwardsChanceScaling",true],
	["chanceScalingThreshold",0.50],
	["minAI_village",1],
	["addAI_village",1],
	["unitLevel_village",0],
	["spawnChance_village",0.40],
	["minAI_city",1],
	["addAI_city",2],
	["unitLevel_city",1],
	["spawnChance_city",0.60],
	["minAI_capitalCity",2],
	["addAI_capitalCity",1],
	["unitLevel_capitalCity",1],
	["spawnChance_capitalCity",0.70],
	["minAI_remoteArea",1],
	["addAI_remoteArea",2],
	["unitLevel_remoteArea",2],
	["spawnChance_remoteArea",0.80],
	["minAI_wilderness",1],
	["addAI_wilderness",1],
	["unitLevel_wilderness",2],
	["spawnChance_wilderness",0.50],
	["tempBlacklistTime",1200],
	["enableFindKiller",true,true],	//HC Pushable
	["enableTempNVGs",false],
	["levelRequiredGL",2,true],	//HC Pushable 
	["levelRequiredLauncher",-1,true],	//HC Pushable
	["launcherTypes",[],true],	//HC Pushable
	["launchersPerGroup",1,true],	//HC Pushable
	["enableHealing",true],
	["removeExplosiveAmmo",true],
	["noCollisionDamage",true,true],	//HC Pushable
	["roadKillPenalty",true,true],	//HC Pushable
	["enableStaticSpawns",true],
	["respawnTimeMin",300],
	["respawnTimeMax",600],
	["despawnWait",120],
	["respawnLimit_village",-1],
	["respawnLimit_city",-1],
	["respawnLimit_capitalCity",-1],
	["respawnLimit_remoteArea",-1],
	["maxDynamicSpawns",15],
	["timePerDynamicSpawn",900],
	["purgeLastDynamicSpawnTime",3600],
	["spawnHunterChance",0.60],
	["despawnDynamicSpawnTime",120],
	["maxRandomSpawns",-1],
	["despawnRandomSpawnTime",120],
	["distanceBetweenRandomSpawns",600],
	["waypointBlacklistAir",[],true],
	["waypointBlacklistLand",[],true],
	["maxAirPatrols",0],
	["levelChancesAir",[0.00,0.50,0.35,0.15]],
	["respawnAirMinTime",600],
	["respawnAirMaxTime",900],
	["airVehicleList",[
		["B_Heli_Light_01_armed_F",5],
		["B_Heli_Transport_01_F",5],
		["B_Heli_Transport_03_F",2]
	]],
	["airGunnerUnits",2],
	["airDetectChance",0.80,true],	//HC Pushable
	["paradropChance",0.50,true],	//HC Pushable
	["paradropCooldown",1800,true],	//HC Pushable
	["paradropAmount",3,true],	//HC Pushable
	["maxLandPatrols",0],
	["levelChancesLand",[0.00,0.50,0.35,0.15]],
	["respawnLandMinTime",600],
	["respawnLandMaxTime",900],
	["landVehicleList",[
		["B_MRAP_01_EPOCH",5],
		["C_Van_01_box_EPOCH",5],
		["C_Van_01_transport_EPOCH",5],
		["C_Offroad_01_EPOCH",5],
		["C_Hatchback_02_EPOCH",5],
		["C_Hatchback_01_EPOCH",5],
		["C_SUV_01_EPOCH",5],
		["B_Truck_01_transport_EPOCH",5],
		["B_Truck_01_covered_EPOCH",5],
		["B_Truck_01_mover_EPOCH",5],
		["B_Truck_01_box_EPOCH",5],
		["O_Truck_02_covered_EPOCH",5],
		["O_Truck_02_transport_EPOCH",5],
		["O_Truck_03_covered_EPOCH",5],
		["O_Truck_02_box_EPOCH",5]
	]],
	["landGunnerUnits",2],
	["landCargoUnits",3],
	["maxAirReinforcements",5],
	["airReinforcementVehicles",["B_Heli_Transport_01_F","B_Heli_Light_01_armed_F"]],
	["airReinforcementSpawnChance0",0.00],
	["airReinforcementSpawnChance1",0.10],
	["airReinforcementSpawnChance2",0.20],
	["airReinforcementSpawnChance3",0.30],
	["airReinforcementAllowedFor",["static","dynamic","random"]],
	["airReinforcementDuration0",120],
	["airReinforcementDuration1",180],
	["airReinforcementDuration2",240],
	["airReinforcementDuration3",300],
	["maxUAVPatrols",0],
	["UAVList",[
		["I_UAV_02_CAS_F",5],
		["I_UAV_02_F",5],
		["B_UAV_02_CAS_F",5],
		["B_UAV_02_F",5],
		["O_UAV_02_CAS_F",5],
		["O_UAV_02_F",5]
	]],
	["levelChancesUAV",[0.35,0.50,0.15,0.00]],
	["respawnUAVMinTime",600],
	["respawnUAVMaxTime",900],
	["detectOnlyUAVs",false,true],	//HC Pushable
	["UAVCallReinforceCooldown",1800,true],	//HC Pushable
	["UAVDetectChance",0.80,true],	//HC Pushable
	["maxUGVPatrols",0],
	["UGVList",[
		["I_UGV_01_rcws_F",5],
		["B_UGV_01_rcws_F",5],
		["O_UGV_01_rcws_F",5]
	]],
	["levelChancesUGV",[0.35,0.50,0.15,0.00]],
	["respawnUGVMinTime",600],
	["respawnUGVMaxTime",900],
	["detectOnlyUGVs",false,true],	//HC Pushable
	["UGVCallReinforceCooldown",1800,true],	//HC Pushable
	["UGVDetectChance",0.80,true],	//HC Pushable
	["skill0",[	
		["aimingAccuracy",0.10,0.15],
		["aimingShake",0.50,0.59],
		["aimingSpeed",0.50,0.59],
		["spotDistance",0.50,0.59],
		["spotTime",0.50,0.59],
		["courage",0.50,0.59],
		["reloadSpeed",0.50,0.59],
		["commanding",0.50,0.59],
		["general",0.50,0.59]
	]],
	["skill1",[	
		["aimingAccuracy",0.15,0.20],
		["aimingShake",0.60,0.69],
		["aimingSpeed",0.60,0.69],
		["spotDistance",0.60,0.69],
		["spotTime",0.60,0.69],
		["courage",0.60,0.69],
		["reloadSpeed",0.60,0.69],
		["commanding",0.60,0.69],
		["general",0.60,0.69]
	]],
	["skill2",[	
		["aimingAccuracy",0.20,0.25],
		["aimingShake",0.70,0.85],
		["aimingSpeed",0.70,0.85],
		["spotDistance",0.70,0.85],
		["spotTime",0.70,0.85],
		["courage",0.70,0.85],
		["reloadSpeed",0.70,0.85],
		["commanding",0.70,0.85],
		["general",0.70,0.85]
	]],
	["skill3",[	
		["aimingAccuracy",0.25,0.30],
		["aimingShake",0.85,0.95],
		["aimingSpeed",0.85,0.95],
		["spotDistance",0.85,0.95],
		["spotTime",0.85,0.95],
		["courage",0.85,0.95],
		["reloadSpeed",0.85,0.95],
		["commanding",0.85,0.95],
		["general",0.85,0.95]
	]],
	["addUniformChance0",0.60],
	["addUniformChance1",0.70],
	["addUniformChance2",0.80],
	["addUniformChance3",0.90],
	["addBackpackChance0",0.60],
	["addBackpackChance1",0.70],
	["addBackpackChance2",0.80],
	["addBackpackChance3",0.90],
	["addVestChance0",0.60],
	["addVestChance1",0.70],
	["addVestChance2",0.80],
	["addVestChance3",0.90],
	["addHeadgearChance0",0.60],
	["addHeadgearChance1",0.70],
	["addHeadgearChance2",0.80],
	["addHeadgearChance3",0.90],
	["useWeaponChance0",[0.20,0.80,0.00,0.00]],
	["useWeaponChance1",[0.00,0.90,0.05,0.05]],
	["useWeaponChance2",[0.00,0.80,0.10,0.10]],
	["useWeaponChance3",[0.00,0.70,0.15,0.15]],
	["opticsChance0",0.00],
	["opticsChance1",0.30],
	["opticsChance2",0.60],
	["opticsChance3",0.90],
	["pointerChance0",0.00],
	["pointerChance1",0.30],
	["pointerChance2",0.60],
	["pointerChance3",0.90],
	["muzzleChance0",0.00],
	["muzzleChance1",0.30],
	["muzzleChance2",0.60],
	["muzzleChance3",0.90],
	["underbarrelChance0",0.00],
	["underbarrelChance1",0.30],
	["underbarrelChance2",0.60],
	["underbarrelChance3",0.90],
	["kryptoAmount0",50],
	["kryptoAmount1",75],
	["kryptoAmount2",100],
	["kryptoAmount3",150],
	["kryptoPickupAssist",0],
	["foodLootCount",2],
	["miscLootCount1",2],
	["miscLootCount2",1],
	["firstAidKitChance",0.25],
	["lootPullChance0",0.20,true],	//HC Pushable
	["lootPullChance1",0.40,true],	//HC Pushable
	["lootPullChance2",0.60,true],	//HC Pushable
	["lootPullChance3",0.80,true],	//HC Pushable
	["uniformTypes0",["U_O_CombatUniform_ocamo", "U_O_GhillieSuit", "U_O_PilotCoveralls", "U_O_Wetsuit", "U_OG_Guerilla1_1", "U_OG_Guerilla2_1", "U_OG_Guerilla2_3", "U_OG_Guerilla3_1", "U_OG_Guerilla3_2", "U_OG_leader", "U_C_Poloshirt_stripped", "U_C_Poloshirt_blue", "U_C_Poloshirt_burgundy", "U_C_Poloshirt_tricolour", "U_C_Poloshirt_salmon", "U_C_Poloshirt_redwhite", "U_C_Poor_1", "U_C_WorkerCoveralls", "U_C_Journalist", "U_C_Scientist", "U_OrestesBody", "U_Wetsuit_uniform", "U_Wetsuit_White", "U_Wetsuit_Blue", "U_Wetsuit_Purp", "U_Wetsuit_Camo", "U_CamoRed_uniform", "U_CamoBrn_uniform", "U_CamoBlue_uniform", "U_Camo_uniform", "U_ghillie1_uniform", "U_ghillie2_uniform", "U_ghillie3_uniform", "U_C_Driver_1", "U_C_Driver_2", "U_C_Driver_3", "U_C_Driver_4", "U_C_Driver_1_black", "U_C_Driver_1_blue", "U_C_Driver_1_green", "U_C_Driver_1_red", "U_C_Driver_1_white", "U_C_Driver_1_yellow", "U_C_Driver_1_orange", "U_C_Driver_1_red"]],
	["uniformTypes1",["U_O_CombatUniform_ocamo", "U_O_GhillieSuit", "U_O_PilotCoveralls", "U_O_Wetsuit", "U_OG_Guerilla1_1", "U_OG_Guerilla2_1", "U_OG_Guerilla2_3", "U_OG_Guerilla3_1", "U_OG_Guerilla3_2", "U_OG_leader", "U_C_Poloshirt_stripped", "U_C_Poloshirt_blue", "U_C_Poloshirt_burgundy", "U_C_Poloshirt_tricolour", "U_C_Poloshirt_salmon", "U_C_Poloshirt_redwhite", "U_C_Poor_1", "U_C_WorkerCoveralls", "U_C_Journalist", "U_C_Scientist", "U_OrestesBody", "U_Wetsuit_uniform", "U_Wetsuit_White", "U_Wetsuit_Blue", "U_Wetsuit_Purp", "U_Wetsuit_Camo", "U_CamoRed_uniform", "U_CamoBrn_uniform", "U_CamoBlue_uniform", "U_Camo_uniform", "U_ghillie1_uniform", "U_ghillie2_uniform", "U_ghillie3_uniform", "U_C_Driver_1", "U_C_Driver_2", "U_C_Driver_3", "U_C_Driver_4", "U_C_Driver_1_black", "U_C_Driver_1_blue", "U_C_Driver_1_green", "U_C_Driver_1_red", "U_C_Driver_1_white", "U_C_Driver_1_yellow", "U_C_Driver_1_orange", "U_C_Driver_1_red"]],
	["uniformTypes2",["U_O_CombatUniform_ocamo", "U_O_GhillieSuit", "U_O_PilotCoveralls", "U_O_Wetsuit", "U_OG_Guerilla1_1", "U_OG_Guerilla2_1", "U_OG_Guerilla2_3", "U_OG_Guerilla3_1", "U_OG_Guerilla3_2", "U_OG_leader", "U_C_Poloshirt_stripped", "U_C_Poloshirt_blue", "U_C_Poloshirt_burgundy", "U_C_Poloshirt_tricolour", "U_C_Poloshirt_salmon", "U_C_Poloshirt_redwhite", "U_C_Poor_1", "U_C_WorkerCoveralls", "U_C_Journalist", "U_C_Scientist", "U_OrestesBody", "U_Wetsuit_uniform", "U_Wetsuit_White", "U_Wetsuit_Blue", "U_Wetsuit_Purp", "U_Wetsuit_Camo", "U_CamoRed_uniform", "U_CamoBrn_uniform", "U_CamoBlue_uniform", "U_Camo_uniform", "U_ghillie1_uniform", "U_ghillie2_uniform", "U_ghillie3_uniform", "U_C_Driver_1", "U_C_Driver_2", "U_C_Driver_3", "U_C_Driver_4", "U_C_Driver_1_black", "U_C_Driver_1_blue", "U_C_Driver_1_green", "U_C_Driver_1_red", "U_C_Driver_1_white", "U_C_Driver_1_yellow", "U_C_Driver_1_orange", "U_C_Driver_1_red"]],
	["uniformTypes3",["U_O_CombatUniform_ocamo", "U_O_GhillieSuit", "U_O_PilotCoveralls", "U_O_Wetsuit", "U_OG_Guerilla1_1", "U_OG_Guerilla2_1", "U_OG_Guerilla2_3", "U_OG_Guerilla3_1", "U_OG_Guerilla3_2", "U_OG_leader", "U_C_Poloshirt_stripped", "U_C_Poloshirt_blue", "U_C_Poloshirt_burgundy", "U_C_Poloshirt_tricolour", "U_C_Poloshirt_salmon", "U_C_Poloshirt_redwhite", "U_C_Poor_1", "U_C_WorkerCoveralls", "U_C_Journalist", "U_C_Scientist", "U_OrestesBody", "U_Wetsuit_uniform", "U_Wetsuit_White", "U_Wetsuit_Blue", "U_Wetsuit_Purp", "U_Wetsuit_Camo", "U_CamoRed_uniform", "U_CamoBrn_uniform", "U_CamoBlue_uniform", "U_Camo_uniform", "U_ghillie1_uniform", "U_ghillie2_uniform", "U_ghillie3_uniform", "U_C_Driver_1", "U_C_Driver_2", "U_C_Driver_3", "U_C_Driver_4", "U_C_Driver_1_black", "U_C_Driver_1_blue", "U_C_Driver_1_green", "U_C_Driver_1_red", "U_C_Driver_1_white", "U_C_Driver_1_yellow", "U_C_Driver_1_orange", "U_C_Driver_1_red"]],
	["pistolList",["hgun_Pistol_heavy_01_F","hgun_P07_F","hgun_Rook40_F","hgun_Pistol_heavy_02_F","1911_pistol_epoch","hgun_ACPC2_F","ruger_pistol_epoch"]],
	["rifleList",["AKM_EPOCH","sr25_epoch","arifle_Katiba_GL_F","arifle_Katiba_C_F","arifle_Katiba_F","arifle_MX_GL_F","arifle_MX_GL_Black_F","arifle_MXM_Black_F","arifle_MXC_Black_F","arifle_MX_Black_F","arifle_MXM_F","arifle_MXC_F","arifle_MX_F","l85a2_epoch","l85a2_pink_epoch","l85a2_ugl_epoch","m4a3_EPOCH","m16_EPOCH","m16Red_EPOCH","arifle_Mk20_GL_F","arifle_Mk20_GL_plain_F","arifle_Mk20C_F","arifle_Mk20C_plain_F","arifle_Mk20_F","arifle_Mk20_plain_F","arifle_TRG21_GL_F","arifle_TRG21_F","arifle_TRG20_F","arifle_SDAR_F","Rollins_F","SMG_01_F","SMG_02_F","hgun_PDW2000_F"]],
	["machinegunList",["LMG_Zafir_F","arifle_MX_SW_F","arifle_MX_SW_Black_F","LMG_Mk200_F","m249_EPOCH","m249Tan_EPOCH","MMG_01_hex_F","MMG_01_tan_F","MMG_02_camo_F","MMG_02_black_F","MMG_02_sand_F"]],
	["sniperList",["m107_EPOCH","m107Tan_EPOCH","srifle_DMR_02_F","srifle_DMR_02_camo_F","srifle_DMR_02_sniper_F","srifle_DMR_03_F","srifle_DMR_03_khaki_F","srifle_DMR_03_tan_F","srifle_DMR_03_multicam_F","srifle_DMR_03_woodland_F","srifle_DMR_03_spotter_F","srifle_DMR_04_F","srifle_DMR_04_Tan_F","srifle_DMR_05_blk_F","srifle_DMR_05_hex_F","srifle_DMR_05_tan_f","srifle_DMR_06_camo_F","srifle_DMR_06_olive_F","srifle_LRR_F","srifle_GM6_F","srifle_DMR_01_F","M14_EPOCH","M14Grn_EPOCH","srifle_EBR_F"]],
	["weaponOpticsList",["optic_NVS","optic_SOS","optic_LRPS","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_KHS_blk","optic_KHS_hex","optic_KHS_old","optic_KHS_tan","optic_DMS","optic_Arco","optic_Hamr","Elcan_epoch","Elcan_reflex_epoch","optic_MRCO","optic_Holosight","optic_Holosight_smg","optic_Aco","optic_ACO_grn","optic_Aco_smg","optic_ACO_grn_smg","optic_Yorris","optic_MRD"]],
	["backpackTypes0",["B_AssaultPack_cbr", "B_AssaultPack_dgtl", "B_AssaultPack_khk", "B_AssaultPack_mcamo", "B_AssaultPack_ocamo", "B_AssaultPack_rgr", "B_AssaultPack_sgg", "B_Carryall_cbr", "B_Carryall_khk", "B_Carryall_mcamo", "B_Carryall_ocamo", "B_Carryall_oli", "B_Carryall_oucamo", "B_FieldPack_blk", "B_FieldPack_cbr", "B_FieldPack_khk", "B_FieldPack_ocamo", "B_FieldPack_oli", "B_FieldPack_oucamo", "B_Kitbag_cbr", "B_Kitbag_mcamo", "B_Kitbag_rgr", "B_Kitbag_sgg", "B_Parachute", "B_TacticalPack_blk", "B_TacticalPack_mcamo", "B_TacticalPack_ocamo", "B_TacticalPack_oli", "B_TacticalPack_rgr", "smallbackpack_red_epoch", "smallbackpack_green_epoch", "smallbackpack_teal_epoch", "smallbackpack_pink_epoch"]],
	["backpackTypes1",["B_AssaultPack_cbr", "B_AssaultPack_dgtl", "B_AssaultPack_khk", "B_AssaultPack_mcamo", "B_AssaultPack_ocamo", "B_AssaultPack_rgr", "B_AssaultPack_sgg", "B_Carryall_cbr", "B_Carryall_khk", "B_Carryall_mcamo", "B_Carryall_ocamo", "B_Carryall_oli", "B_Carryall_oucamo", "B_FieldPack_blk", "B_FieldPack_cbr", "B_FieldPack_khk", "B_FieldPack_ocamo", "B_FieldPack_oli", "B_FieldPack_oucamo", "B_Kitbag_cbr", "B_Kitbag_mcamo", "B_Kitbag_rgr", "B_Kitbag_sgg", "B_Parachute", "B_TacticalPack_blk", "B_TacticalPack_mcamo", "B_TacticalPack_ocamo", "B_TacticalPack_oli", "B_TacticalPack_rgr", "smallbackpack_red_epoch", "smallbackpack_green_epoch", "smallbackpack_teal_epoch", "smallbackpack_pink_epoch"]],
	["backpackTypes2",["B_AssaultPack_cbr", "B_AssaultPack_dgtl", "B_AssaultPack_khk", "B_AssaultPack_mcamo", "B_AssaultPack_ocamo", "B_AssaultPack_rgr", "B_AssaultPack_sgg", "B_Carryall_cbr", "B_Carryall_khk", "B_Carryall_mcamo", "B_Carryall_ocamo", "B_Carryall_oli", "B_Carryall_oucamo", "B_FieldPack_blk", "B_FieldPack_cbr", "B_FieldPack_khk", "B_FieldPack_ocamo", "B_FieldPack_oli", "B_FieldPack_oucamo", "B_Kitbag_cbr", "B_Kitbag_mcamo", "B_Kitbag_rgr", "B_Kitbag_sgg", "B_Parachute", "B_TacticalPack_blk", "B_TacticalPack_mcamo", "B_TacticalPack_ocamo", "B_TacticalPack_oli", "B_TacticalPack_rgr", "smallbackpack_red_epoch", "smallbackpack_green_epoch", "smallbackpack_teal_epoch", "smallbackpack_pink_epoch"]],
	["backpackTypes3",["B_AssaultPack_cbr", "B_AssaultPack_dgtl", "B_AssaultPack_khk", "B_AssaultPack_mcamo", "B_AssaultPack_ocamo", "B_AssaultPack_rgr", "B_AssaultPack_sgg", "B_Carryall_cbr", "B_Carryall_khk", "B_Carryall_mcamo", "B_Carryall_ocamo", "B_Carryall_oli", "B_Carryall_oucamo", "B_FieldPack_blk", "B_FieldPack_cbr", "B_FieldPack_khk", "B_FieldPack_ocamo", "B_FieldPack_oli", "B_FieldPack_oucamo", "B_Kitbag_cbr", "B_Kitbag_mcamo", "B_Kitbag_rgr", "B_Kitbag_sgg", "B_Parachute", "B_TacticalPack_blk", "B_TacticalPack_mcamo", "B_TacticalPack_ocamo", "B_TacticalPack_oli", "B_TacticalPack_rgr", "smallbackpack_red_epoch", "smallbackpack_green_epoch", "smallbackpack_teal_epoch", "smallbackpack_pink_epoch"]],
	["vestTypes0",["V_1_EPOCH", "V_2_EPOCH", "V_3_EPOCH", "V_4_EPOCH", "V_5_EPOCH", "V_6_EPOCH", "V_7_EPOCH", "V_8_EPOCH", "V_9_EPOCH", "V_10_EPOCH", "V_11_EPOCH", "V_12_EPOCH", "V_13_EPOCH", "V_14_EPOCH", "V_15_EPOCH", "V_16_EPOCH", "V_17_EPOCH", "V_18_EPOCH", "V_19_EPOCH", "V_20_EPOCH", "V_21_EPOCH", "V_22_EPOCH", "V_23_EPOCH", "V_24_EPOCH", "V_25_EPOCH", "V_26_EPOCH", "V_27_EPOCH", "V_28_EPOCH", "V_29_EPOCH", "V_30_EPOCH", "V_31_EPOCH", "V_32_EPOCH", "V_33_EPOCH", "V_34_EPOCH", "V_35_EPOCH", "V_36_EPOCH", "V_37_EPOCH", "V_38_EPOCH", "V_39_EPOCH", "V_40_EPOCH"]],
	["vestTypes1",["V_1_EPOCH", "V_2_EPOCH", "V_3_EPOCH", "V_4_EPOCH", "V_5_EPOCH", "V_6_EPOCH", "V_7_EPOCH", "V_8_EPOCH", "V_9_EPOCH", "V_10_EPOCH", "V_11_EPOCH", "V_12_EPOCH", "V_13_EPOCH", "V_14_EPOCH", "V_15_EPOCH", "V_16_EPOCH", "V_17_EPOCH", "V_18_EPOCH", "V_19_EPOCH", "V_20_EPOCH", "V_21_EPOCH", "V_22_EPOCH", "V_23_EPOCH", "V_24_EPOCH", "V_25_EPOCH", "V_26_EPOCH", "V_27_EPOCH", "V_28_EPOCH", "V_29_EPOCH", "V_30_EPOCH", "V_31_EPOCH", "V_32_EPOCH", "V_33_EPOCH", "V_34_EPOCH", "V_35_EPOCH", "V_36_EPOCH", "V_37_EPOCH", "V_38_EPOCH", "V_39_EPOCH", "V_40_EPOCH"]],
	["vestTypes2",["V_1_EPOCH", "V_2_EPOCH", "V_3_EPOCH", "V_4_EPOCH", "V_5_EPOCH", "V_6_EPOCH", "V_7_EPOCH", "V_8_EPOCH", "V_9_EPOCH", "V_10_EPOCH", "V_11_EPOCH", "V_12_EPOCH", "V_13_EPOCH", "V_14_EPOCH", "V_15_EPOCH", "V_16_EPOCH", "V_17_EPOCH", "V_18_EPOCH", "V_19_EPOCH", "V_20_EPOCH", "V_21_EPOCH", "V_22_EPOCH", "V_23_EPOCH", "V_24_EPOCH", "V_25_EPOCH", "V_26_EPOCH", "V_27_EPOCH", "V_28_EPOCH", "V_29_EPOCH", "V_30_EPOCH", "V_31_EPOCH", "V_32_EPOCH", "V_33_EPOCH", "V_34_EPOCH", "V_35_EPOCH", "V_36_EPOCH", "V_37_EPOCH", "V_38_EPOCH", "V_39_EPOCH", "V_40_EPOCH"]],
	["vestTypes3",["V_1_EPOCH", "V_2_EPOCH", "V_3_EPOCH", "V_4_EPOCH", "V_5_EPOCH", "V_6_EPOCH", "V_7_EPOCH", "V_8_EPOCH", "V_9_EPOCH", "V_10_EPOCH", "V_11_EPOCH", "V_12_EPOCH", "V_13_EPOCH", "V_14_EPOCH", "V_15_EPOCH", "V_16_EPOCH", "V_17_EPOCH", "V_18_EPOCH", "V_19_EPOCH", "V_20_EPOCH", "V_21_EPOCH", "V_22_EPOCH", "V_23_EPOCH", "V_24_EPOCH", "V_25_EPOCH", "V_26_EPOCH", "V_27_EPOCH", "V_28_EPOCH", "V_29_EPOCH", "V_30_EPOCH", "V_31_EPOCH", "V_32_EPOCH", "V_33_EPOCH", "V_34_EPOCH", "V_35_EPOCH", "V_36_EPOCH", "V_37_EPOCH", "V_38_EPOCH", "V_39_EPOCH", "V_40_EPOCH"]],
	["headgearTypes0",["H_1_EPOCH","H_2_EPOCH","H_3_EPOCH","H_4_EPOCH","H_5_EPOCH","H_6_EPOCH","H_7_EPOCH","H_8_EPOCH","H_9_EPOCH","H_10_EPOCH","H_11_EPOCH","H_12_EPOCH","H_13_EPOCH","H_14_EPOCH","H_15_EPOCH","H_16_EPOCH","H_17_EPOCH","H_18_EPOCH","H_19_EPOCH","H_20_EPOCH","H_21_EPOCH","H_22_EPOCH","H_23_EPOCH","H_24_EPOCH","H_25_EPOCH","H_26_EPOCH","H_27_EPOCH","H_28_EPOCH","H_29_EPOCH","H_30_EPOCH","H_31_EPOCH","H_32_EPOCH","H_33_EPOCH","H_34_EPOCH","H_35_EPOCH","H_36_EPOCH","H_37_EPOCH","H_38_EPOCH","H_39_EPOCH","H_40_EPOCH","H_41_EPOCH","H_42_EPOCH","H_43_EPOCH","H_44_EPOCH","H_45_EPOCH","H_46_EPOCH","H_47_EPOCH","H_48_EPOCH","H_49_EPOCH","H_50_EPOCH","H_51_EPOCH","H_52_EPOCH","H_53_EPOCH","H_54_EPOCH","H_55_EPOCH","H_56_EPOCH","H_57_EPOCH","H_58_EPOCH","H_59_EPOCH","H_60_EPOCH","H_61_EPOCH","H_62_EPOCH","H_63_EPOCH","H_64_EPOCH","H_65_EPOCH","H_66_EPOCH","H_67_EPOCH","H_68_EPOCH","H_69_EPOCH","H_70_EPOCH","H_71_EPOCH","H_72_EPOCH","H_73_EPOCH","H_74_EPOCH","H_75_EPOCH","H_76_EPOCH","H_77_EPOCH","H_78_EPOCH","H_79_EPOCH","H_80_EPOCH","H_81_EPOCH","H_82_EPOCH","H_83_EPOCH","H_84_EPOCH","H_85_EPOCH","H_86_EPOCH","H_87_EPOCH","H_88_EPOCH","H_89_EPOCH","H_90_EPOCH","H_91_EPOCH","H_92_EPOCH","H_93_EPOCH","H_94_EPOCH","H_95_EPOCH","H_96_EPOCH","H_97_EPOCH","H_98_EPOCH","H_99_EPOCH","H_100_EPOCH","H_101_EPOCH","H_102_EPOCH","H_103_EPOCH","H_104_EPOCH"]],
	["headgearTypes1",["H_1_EPOCH","H_2_EPOCH","H_3_EPOCH","H_4_EPOCH","H_5_EPOCH","H_6_EPOCH","H_7_EPOCH","H_8_EPOCH","H_9_EPOCH","H_10_EPOCH","H_11_EPOCH","H_12_EPOCH","H_13_EPOCH","H_14_EPOCH","H_15_EPOCH","H_16_EPOCH","H_17_EPOCH","H_18_EPOCH","H_19_EPOCH","H_20_EPOCH","H_21_EPOCH","H_22_EPOCH","H_23_EPOCH","H_24_EPOCH","H_25_EPOCH","H_26_EPOCH","H_27_EPOCH","H_28_EPOCH","H_29_EPOCH","H_30_EPOCH","H_31_EPOCH","H_32_EPOCH","H_33_EPOCH","H_34_EPOCH","H_35_EPOCH","H_36_EPOCH","H_37_EPOCH","H_38_EPOCH","H_39_EPOCH","H_40_EPOCH","H_41_EPOCH","H_42_EPOCH","H_43_EPOCH","H_44_EPOCH","H_45_EPOCH","H_46_EPOCH","H_47_EPOCH","H_48_EPOCH","H_49_EPOCH","H_50_EPOCH","H_51_EPOCH","H_52_EPOCH","H_53_EPOCH","H_54_EPOCH","H_55_EPOCH","H_56_EPOCH","H_57_EPOCH","H_58_EPOCH","H_59_EPOCH","H_60_EPOCH","H_61_EPOCH","H_62_EPOCH","H_63_EPOCH","H_64_EPOCH","H_65_EPOCH","H_66_EPOCH","H_67_EPOCH","H_68_EPOCH","H_69_EPOCH","H_70_EPOCH","H_71_EPOCH","H_72_EPOCH","H_73_EPOCH","H_74_EPOCH","H_75_EPOCH","H_76_EPOCH","H_77_EPOCH","H_78_EPOCH","H_79_EPOCH","H_80_EPOCH","H_81_EPOCH","H_82_EPOCH","H_83_EPOCH","H_84_EPOCH","H_85_EPOCH","H_86_EPOCH","H_87_EPOCH","H_88_EPOCH","H_89_EPOCH","H_90_EPOCH","H_91_EPOCH","H_92_EPOCH","H_93_EPOCH","H_94_EPOCH","H_95_EPOCH","H_96_EPOCH","H_97_EPOCH","H_98_EPOCH","H_99_EPOCH","H_100_EPOCH","H_101_EPOCH","H_102_EPOCH","H_103_EPOCH","H_104_EPOCH"]],
	["headgearTypes2",["H_1_EPOCH","H_2_EPOCH","H_3_EPOCH","H_4_EPOCH","H_5_EPOCH","H_6_EPOCH","H_7_EPOCH","H_8_EPOCH","H_9_EPOCH","H_10_EPOCH","H_11_EPOCH","H_12_EPOCH","H_13_EPOCH","H_14_EPOCH","H_15_EPOCH","H_16_EPOCH","H_17_EPOCH","H_18_EPOCH","H_19_EPOCH","H_20_EPOCH","H_21_EPOCH","H_22_EPOCH","H_23_EPOCH","H_24_EPOCH","H_25_EPOCH","H_26_EPOCH","H_27_EPOCH","H_28_EPOCH","H_29_EPOCH","H_30_EPOCH","H_31_EPOCH","H_32_EPOCH","H_33_EPOCH","H_34_EPOCH","H_35_EPOCH","H_36_EPOCH","H_37_EPOCH","H_38_EPOCH","H_39_EPOCH","H_40_EPOCH","H_41_EPOCH","H_42_EPOCH","H_43_EPOCH","H_44_EPOCH","H_45_EPOCH","H_46_EPOCH","H_47_EPOCH","H_48_EPOCH","H_49_EPOCH","H_50_EPOCH","H_51_EPOCH","H_52_EPOCH","H_53_EPOCH","H_54_EPOCH","H_55_EPOCH","H_56_EPOCH","H_57_EPOCH","H_58_EPOCH","H_59_EPOCH","H_60_EPOCH","H_61_EPOCH","H_62_EPOCH","H_63_EPOCH","H_64_EPOCH","H_65_EPOCH","H_66_EPOCH","H_67_EPOCH","H_68_EPOCH","H_69_EPOCH","H_70_EPOCH","H_71_EPOCH","H_72_EPOCH","H_73_EPOCH","H_74_EPOCH","H_75_EPOCH","H_76_EPOCH","H_77_EPOCH","H_78_EPOCH","H_79_EPOCH","H_80_EPOCH","H_81_EPOCH","H_82_EPOCH","H_83_EPOCH","H_84_EPOCH","H_85_EPOCH","H_86_EPOCH","H_87_EPOCH","H_88_EPOCH","H_89_EPOCH","H_90_EPOCH","H_91_EPOCH","H_92_EPOCH","H_93_EPOCH","H_94_EPOCH","H_95_EPOCH","H_96_EPOCH","H_97_EPOCH","H_98_EPOCH","H_99_EPOCH","H_100_EPOCH","H_101_EPOCH","H_102_EPOCH","H_103_EPOCH","H_104_EPOCH"]],
	["headgearTypes3",["H_1_EPOCH","H_2_EPOCH","H_3_EPOCH","H_4_EPOCH","H_5_EPOCH","H_6_EPOCH","H_7_EPOCH","H_8_EPOCH","H_9_EPOCH","H_10_EPOCH","H_11_EPOCH","H_12_EPOCH","H_13_EPOCH","H_14_EPOCH","H_15_EPOCH","H_16_EPOCH","H_17_EPOCH","H_18_EPOCH","H_19_EPOCH","H_20_EPOCH","H_21_EPOCH","H_22_EPOCH","H_23_EPOCH","H_24_EPOCH","H_25_EPOCH","H_26_EPOCH","H_27_EPOCH","H_28_EPOCH","H_29_EPOCH","H_30_EPOCH","H_31_EPOCH","H_32_EPOCH","H_33_EPOCH","H_34_EPOCH","H_35_EPOCH","H_36_EPOCH","H_37_EPOCH","H_38_EPOCH","H_39_EPOCH","H_40_EPOCH","H_41_EPOCH","H_42_EPOCH","H_43_EPOCH","H_44_EPOCH","H_45_EPOCH","H_46_EPOCH","H_47_EPOCH","H_48_EPOCH","H_49_EPOCH","H_50_EPOCH","H_51_EPOCH","H_52_EPOCH","H_53_EPOCH","H_54_EPOCH","H_55_EPOCH","H_56_EPOCH","H_57_EPOCH","H_58_EPOCH","H_59_EPOCH","H_60_EPOCH","H_61_EPOCH","H_62_EPOCH","H_63_EPOCH","H_64_EPOCH","H_65_EPOCH","H_66_EPOCH","H_67_EPOCH","H_68_EPOCH","H_69_EPOCH","H_70_EPOCH","H_71_EPOCH","H_72_EPOCH","H_73_EPOCH","H_74_EPOCH","H_75_EPOCH","H_76_EPOCH","H_77_EPOCH","H_78_EPOCH","H_79_EPOCH","H_80_EPOCH","H_81_EPOCH","H_82_EPOCH","H_83_EPOCH","H_84_EPOCH","H_85_EPOCH","H_86_EPOCH","H_87_EPOCH","H_88_EPOCH","H_89_EPOCH","H_90_EPOCH","H_91_EPOCH","H_92_EPOCH","H_93_EPOCH","H_94_EPOCH","H_95_EPOCH","H_96_EPOCH","H_97_EPOCH","H_98_EPOCH","H_99_EPOCH","H_100_EPOCH","H_101_EPOCH","H_102_EPOCH","H_103_EPOCH","H_104_EPOCH"]],
	["foodLoot",["FoodSnooter","FoodWalkNSons","FoodBioMeat","ItemSodaOrangeSherbet","ItemSodaPurple","ItemSodaMocha","ItemSodaBurst","ItemSodaRbull","honey_epoch","emptyjar_epoch","sardines_epoch","meatballs_epoch","scam_epoch","sweetcorn_epoch","WhiskeyNoodle","ItemCoolerE"]],
	["miscLoot1",["PaintCanClear","PaintCanBlk","PaintCanBlu","PaintCanBrn","PaintCanGrn","PaintCanOra","PaintCanPur","PaintCanRed","PaintCanTeal","PaintCanYel","ItemDocument","ItemMixOil","emptyjar_epoch","emptyjar_epoch","FoodBioMeat","ItemSodaOrangeSherbet","ItemSodaPurple","ItemSodaMocha","ItemSodaBurst","ItemSodaRbull","sardines_epoch","meatballs_epoch","scam_epoch","sweetcorn_epoch","Towelette","Towelette","Towelette","Towelette","Towelette","HeatPack","HeatPack","HeatPack","ColdPack","ColdPack","VehicleRepair","CircuitParts","ItemCoolerE","ItemScraps","ItemScraps"]],
	["miscLoot2",["MortarBucket","MortarBucket","ItemCorrugated","CinderBlocks","jerrycan_epoch","jerrycan_epoch","VehicleRepair","VehicleRepair","CircuitParts"]],
	["toolsList0",[["ItemWatch",0.70],["ItemCompass",0.50],["ItemMap",0.50],["ItemGPS",0.05],["EpochRadio0",0.05]]],
	["toolsList1",[["ItemWatch",0.80],["ItemCompass",0.60],["ItemMap",0.60],["ItemGPS",0.10],["EpochRadio0",0.10]]],
	["toolsList2",[["ItemWatch",0.80],["ItemCompass",0.70],["ItemMap",0.70],["ItemGPS",0.15],["EpochRadio0",0.15]]],
	["toolsList3",[["ItemWatch",0.80],["ItemCompass",0.80],["ItemMap",0.80],["ItemGPS",0.20],["EpochRadio0",0.20]]],
	["gadgetsList0",[["binocular",0.40],["NVG_EPOCH",0.05]]],
	["gadgetsList1",[["binocular",0.50],["NVG_EPOCH",0.10]]],
	["gadgetsList2",[["binocular",0.60],["NVG_EPOCH",0.15]]],
	["gadgetsList3",[["binocular",0.70],["NVG_EPOCH",0.20]]]
];

if (A3EAI_verifySettings) then {
	if !(A3EAI_unitLevel_capitalCity in [0,1,2,3]) then {diag_log format ["[A3EAI] Error found in variable A3EAI_unitLevel_capitalCity, resetting to default value."]; A3EAI_unitLevel_capitalCity = 1};
	if !(A3EAI_unitLevel_city in [0,1,2,3]) then {diag_log format ["[A3EAI] Error found in variable A3EAI_unitLevel_city, resetting to default value."]; A3EAI_unitLevel_city = 1};
	if !(A3EAI_unitLevel_village in [0,1,2,3]) then {diag_log format ["[A3EAI] Error found in variable A3EAI_unitLevel_village, resetting to default value."]; A3EAI_unitLevel_village = 0};
	if !(A3EAI_unitLevel_remoteArea in [0,1,2,3]) then {diag_log format ["[A3EAI] Error found in variable A3EAI_unitLevel_remoteArea, resetting to default value."]; A3EAI_unitLevel_remoteArea = 2};
	if !(A3EAI_unitLevel_wilderness in [0,1,2,3]) then {diag_log format ["[A3EAI] Error found in variable A3EAI_unitLevel_remoteArea, resetting to default value."]; A3EAI_unitLevel_wilderness = 2};
	if !((count A3EAI_levelChancesAir) isEqualTo 4) then {diag_log format ["[A3EAI] Error found in variable A3EAI_levelChancesAir, resetting to default value."]; A3EAI_levelChancesAir = [0.00,0.50,0.35,0.15]};
	if !((count A3EAI_levelChancesLand) isEqualTo 4) then {diag_log format ["[A3EAI] Error found in variable A3EAI_levelChancesLand, resetting to default value."]; A3EAI_levelChancesAir = [0.00,0.50,0.35,0.15]};
	if !((count A3EAI_useWeaponChance0) isEqualTo 4) then {diag_log format ["[A3EAI] Error found in variable A3EAI_useWeaponChance0, resetting to default value."]; A3EAI_useWeaponChance0 = [0.20,0.80,0.00,0.00]};
	if !((count A3EAI_useWeaponChance1) isEqualTo 4) then {diag_log format ["[A3EAI] Error found in variable A3EAI_useWeaponChance1, resetting to default value."]; A3EAI_useWeaponChance1 = [0.00,0.90,0.05,0.05]};
	if !((count A3EAI_useWeaponChance2) isEqualTo 4) then {diag_log format ["[A3EAI] Error found in variable A3EAI_useWeaponChance2, resetting to default value."]; A3EAI_useWeaponChance2 = [0.00,0.80,0.10,0.10]};
	if !((count A3EAI_useWeaponChance3) isEqualTo 4) then {diag_log format ["[A3EAI] Error found in variable A3EAI_useWeaponChance3, resetting to default value."]; A3EAI_useWeaponChance3 = [0.00,0.70,0.15,0.15]};
	if ("air_reinforce" in A3EAI_airReinforcementAllowedFor) then {A3EAI_airReinforcementAllowedFor = A3EAI_airReinforcementAllowedFor - ["air_reinforce"]};
	if ("uav" in A3EAI_airReinforcementAllowedFor) then {A3EAI_airReinforcementAllowedFor = A3EAI_airReinforcementAllowedFor - ["uav"]};
	if ("ugv" in A3EAI_airReinforcementAllowedFor) then {A3EAI_airReinforcementAllowedFor = A3EAI_airReinforcementAllowedFor - ["ugv"]};
};

diag_log format ["[A3EAI] Loaded all A3EAI settings in %1 seconds.",(diag_tickTime - _startTime)];

true
