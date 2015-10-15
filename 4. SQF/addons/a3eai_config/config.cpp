class CfgPatches {
	class A3EAI_config {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		A3EAIVersion = "1.0.1";
		requiredAddons[] = {};
	};
};

class CfgA3EAISettings {

	/*	A3EAI Settings
	--------------------------------------------------------------------------------------------------------------------*/	
	
	//Enable or disable event logging to the server RPT file (named arma3server_[date]_[time].rpt). Debug level setting. 0: No debug output, 1: Basic Debug output, 2: Detailed Debug output. (Default: 0)
	//Debug output may help finding additional information about A3EAI's background behavior. This output is helpful when asking for help regarding bugs or unexpected behaviors.
	debugLevel = 0;
	
	//Frequency of server monitor update to RPT log in seconds. The monitor periodically reports number of max/current AI units and dynamically spawned triggers into RPT log. (Default: 300, 0 = Disable reporting)											
	monitorReportRate = 300;
	
	//Enable or disable verification and error-correction of classname tables used by A3EAI. If invalid entries are found, they are removed and logged into the RPT log.
	//If disabled, any invalid classnames will not be removed and clients may crash if AI bodies with invalid items are looted. Only disable if a previous scan shows no invalid classnames (Default: 1).										
	verifyClassnames = 1;
	
	//Enables checking of all A3EAI config settings. (Default: 1)
	verifySettings = 1;
	
	//Minimum seconds to pass until each dead AI body or destroyed vehicle can be cleaned up by A3EAI's task scheduler. A3EAI will not clean up a body/vehicle if there is a player close by (Default: 900).									
	cleanupDelay = 900;
	
	//Enabled: A3EAI will load custom spawn/blacklist definitions file on startup (A3EAI_config.pbo >> custom_defs.sqf) (Default: 0)
	loadCustomFile = 0;
	
	
	/*	A3EAI HC Settings
	--------------------------------------------------------------------------------------------------------------------*/	
	
	//Enables A3EAI headless client support. (Default: 0)
	enableHC = 0;
	
	//If HC support enabled, A3EAI will pause during post-initialization until HC has successfully connected. (Default: 0)
	//IMPORTANT: It is highly recommended to ensure that the HC is properly setup before enabling this option, otherwise A3EAI may be stuck waiting for HC to to connect.
	waitForHC = 0;

	
	/*	Dynamic Classname Settings

		If a setting is disabled, A3EAI will use the corresponding classname table further below. See "AI clothing, weapon, loot, and equipment settings" section.
	--------------------------------------------------------------------------------------------------------------------*/	
	
	//1: Generate AI weapons from Epoch loot tables (Default)
	//0: Weapons defined by pistolList, rifleList, machinegunList, sniperList
	//dynamicWeaponBlacklist: Classnames of weapons to ignore from Epoch loot tables
	generateDynamicWeapons = 1;
	dynamicWeaponBlacklist[] = {};
	
	//1: Use Epoch loot table data as whitelist for AI-usable weapon scopes (Default)
	//0: Scopes defined by weaponOpticsList
	//dynamicOpticsBlacklist: List of optics classnames to ignore from Epoch loot tables.
	generateDynamicOptics = 1;
	dynamicOpticsBlacklist[] = {};
	
	//1: Generate AI uniform types from Epoch loot tables (Default)
	//0: Uniforms defined by uniformTypes0, uniformTypes1, uniformTypes2, uniformTypes3
	//dynamicUniformBlacklist: List of uniform classnames to ignore from Epoch loot tables.
	generateDynamicUniforms = 1;
	dynamicUniformBlacklist[] = {};
	
	//1: Generate AI backpack types from Epoch loot tables (Default)
	//0: Backpacks defined by backpackTypes0, backpackTypes1, backpackTypes2, backpackTypes3
	//dynamicBackpackBlacklist: List of backpack classnames to ignore from Epoch loot tables.
	generateDynamicBackpacks = 1;
	dynamicBackpackBlacklist[] = {};
	
	//1: Generate AI backpack types from Epoch loot tables (Default)
	//0: Vests defined by vestTypes0, vestTypes1, vestTypes2, vestTypes3
	//dynamicVestBlacklist: List of vest classnames to ignore from Epoch loot tables.
	generateDynamicVests = 1;
	dynamicVestBlacklist[] = {};
	
	//1: Generate AI headgear types from Epoch loot tables (Default)
	//0: Headgear defined by headgearTypes0, headgearTypes1, headgearTypes2, headgearTypes3
	//dynamicHeadgearBlacklist: List of headgear classnames to ignore from Epoch loot tables.
	generateDynamicHeadgear = 1;
	dynamicHeadgearBlacklist[] = {};
	
	//1: Generate AI food types from Epoch loot tables (Default)
	//0: Food defined by foodLoot
	//dynamicFoodBlacklist: List of food classnames to ignore from Epoch loot tables.
	generateDynamicFood = 1;
	dynamicFoodBlacklist[] = {};
	
	//1: Generate AI generic loot types from Epoch loot tables. (Default)
	//0: Loot defined by MiscLoot
	//dynamicLootBlacklist: List of loot classnames to ignore from Epoch loot tables.
	generateDynamicLoot = 1;
	dynamicLootBlacklist[] = {};


	/*	A3EAI Client Addon features. These features require the A3EAI client addon to be installed in order to work.
	--------------------------------------------------------------------------------------------------------------------*/	

	enableRadioMessages = 0;
	enableDeathMessages = 0;

	
	/*	Shared AI Unit Settings. These settings affect all AI spawned unless noted otherwise.
	--------------------------------------------------------------------------------------------------------------------*/	
	
	//Number of online players required for maximum (or minimum) AI spawn chance. Affects Static, Dynamic, Random AI spawns. (Default: 10)	
	playerCountThreshold = 10;
	
	//1: Spawn chance multiplier scales upwards from value defined by chanceScalingThreshold to 1.00. 0: Spawn chance multiplier scales downwards from 1.00 to chanceScalingThreshold.
	upwardsChanceScaling = 1;
	
	//If upwardsChanceScaling is 1: Initial spawn chance multiplier. If upwardsChanceScaling is 0: Final spawn chance multiplier. (Default: 0.50)
	chanceScalingThreshold = 0.50;
	
	//(Static/Dynamic/Random Spawns) minAI: Minimum number of units. addAI: maximum number of additional units. unitLevel: Unit level (0-3)
	minAI_village = 1;
	addAI_village = 1;
	unitLevel_village = 0;
	spawnChance_village = 0.40;
	
	//(Static/Dynamic/Random Spawns) minAI: Minimum number of units. addAI: maximum number of additional units. unitLevel: Unit level (0-3)
	minAI_city = 1;
	addAI_city = 2;
	unitLevel_city = 1;
	spawnChance_city = 0.60;
	
	//(Static/Dynamic/Random Spawns) minAI: Minimum number of units. addAI: maximum number of additional units. unitLevel: Unit level (0-3)
	minAI_capitalCity = 2;
	addAI_capitalCity = 1;
	unitLevel_capitalCity = 1;
	spawnChance_capitalCity = 0.70;
	
	//(Static/Dynamic/Random Spawns) minAI: Minimum number of units. addAI: maximum number of additional units. unitLevel: Unit level (0-3)
	minAI_remoteArea = 1;
	addAI_remoteArea = 2;
	unitLevel_remoteArea = 2;
	spawnChance_remoteArea = 0.80;
	
	//(Static/Dynamic/Random Spawns) minAI: Minimum number of units. addAI: maximum number of additional units. unitLevel: Unit level (0-3)
	minAI_wilderness = 1;
	addAI_wilderness = 2;
	unitLevel_wilderness = 1;
	spawnChance_wilderness = 0.50;
	
	//(For dynamic and random spawns only) Defines amount of time to wait in seconds until cleaning up temporary blacklist area after dynamic/random spawn is deactivated (Default: 1200)
	tempBlacklistTime = 1200;
	
	//If enabled, AI group will attempt to track down player responsible for killing a group member. (Default: 1)
	enableFindKiller = 1;
	
	//If normal probability check for spawning NVGs fails, then give AI temporary NVGs during night hours. Temporary NVGs are unlootable and will be removed at death (Default: 0).									
	enableTempNVGs = 0;
	
	//Minimum AI unit level requirement to use underslung grenade launchers. Set to -1 to disable completely. (Default: 1)
	levelRequiredGL = 1;
	
	//Minimum AI unit level requirement to use launcher weapons. Set to -1 to disable completely. Launchers are unlootable and will be removed at death (Default: -1)
	levelRequiredLauncher = -1;
	
	//List of launcher-type weapons that AI can use.
	launcherTypes[] = {"launch_NLAW_F","launch_RPG32_F","launch_B_Titan_F","launch_I_Titan_F","launch_O_Titan_F","launch_B_Titan_short_F","launch_I_Titan_short_F","launch_O_Titan_short_F"}; 
	
	//Maximum number of launcher weapons allowed per group (Default: 1)
	launchersPerGroup = 1;
	
	//Enable or disable AI self-healing. Level 0 AI cannot self-heal. Affects: All AI infantry units (Default: 1). 
	enableHealing = 1;
	
	//If enabled, A3EAI will remove all explosive ammo (missiles, rockets, bombs - but not HE rounds) from spawned AI air vehicles.  (Default: 1)
	//Affects: All AI air vehicle types (patrols/custom/reinforcement). Does not affect UAV/UGVs.
	removeExplosiveAmmo = 1;
	
	//if enabled, AI units suffer no damage from vehicle collisions. (Default: 1)
	noCollisionDamage = 1;
	
	//If enabled, AI killed by vehicle collisions will have their gear removed (Default: 1)
	roadKillPenalty = 1;
	
		
	/*	Static Infantry AI Spawning Settings

		A3EAI will spawn an AI group at various named locations on the map if players are nearby. 
	--------------------------------------------------------------------------------------------------------------------*/	
	
	//Enable or disable static AI spawns. If enabled, AI spawn points will be generated in cities, towns, and other named areas.
	//Enabled: A3EAI automatically generates static spawns at named locations on map. Disabled: No static spawns will be generated. (Default: 1)
	enableStaticSpawns = 1;
	
	//Set minimum and maximum wait time (seconds) to respawn an AI group after all units have been killed. Applies to both static AI and custom spawned AI (Default: Min 300, Max 600).									
	respawnTimeMin = 300;
	respawnTimeMax = 600;
	
	//Time to allow spawned AI units to exist in seconds before being despawned when no players are present in a trigger area. Applies to both static AI and custom spawned AI (Default: 120)										
	despawnWait = 120;
	
	//Respawn Limits. Set to -1 for unlimited respawns. (Default: -1 for each).
	respawnLimit_village = -1;
	respawnLimit_city = -1;
	respawnLimit_capitalCity = -1;
	respawnLimit_remoteArea = -1;

	
	/*	Dynamic Infantry AI Spawning Settings. Probabilities should add up to 1.00	

		A3EAI will create ambient threat in the area for each player by periodically spawning AI to create unexpected ambush encounters. These AI may occasionally seek out and hunt a player. 
	--------------------------------------------------------------------------------------------------------------------*/		
	
	//Upper limit of dynamic spawns on map at once. Set to 0 to disable dynamic spawns (Default: 15)
	maxDynamicSpawns = 15;
	
	//Minimum time (in seconds) that must pass between dynamic spawns for each player (Default: 900)
	timePerDynamicSpawn = 900;
	
	//Players offline for this amount of time (seconds) will have their last spawn timestamp reset (Default: 3600)
	purgeLastDynamicSpawnTime = 3600;
	
	//Probability for dynamic AI to actively hunt a targeted player. If probability check fails, dynamic AI will patrol the area instead of hunting (Default: 0.60)
	spawnHunterChance = 0.60;
	
	//Time to wait (seconds) before despawning all AI units in dynamic spawn area when no players are present. (Default: 120)
	despawnDynamicSpawnTime = 120;
	
	
	/*	Random Infantry AI Spawning Settings

		A3EAI will create spawns that are randomly placed around the map and are periodically relocated. These spawns are preferentially created in named locations, but may be also created anywhere in the world. 
	--------------------------------------------------------------------------------------------------------------------*/		

	//Maximum number of placed random spawns on map. Set to -1 for A3EAI to automatically adjust spawn limit according to map size. Set to 0 to disable random spawns. (Default: -1)
	maxRandomSpawns = -1;
	
	//Time to wait (seconds) before despawning all AI units in random spawn area when no players are present. (Default: 120)
	despawnRandomSpawnTime = 120;	
	
	//Minimum distance between a random spawn location and other random spawns. (Default: 0)
	distanceBetweenRandomSpawns = 0;	
	
	
	/*	Shared AI Vehicle Settings

		These settings affect the following AI vehicle patrol types: Air, Land, UAV, UGV
	--------------------------------------------------------------------------------------------------------------------*/
	
	//Add name of location as displayed on map prevent AI vehicle patrols from travelling to these locations. Location names are case-sensitive. Note: Vehicles may still pass through these areas
	//Example: waypointBlacklistAir[] = {"Aggelochori","Panochori","Zaros"};
	waypointBlacklistAir[] = {};	//Affects Air vehicles (including UAVs)
	waypointBlacklistLand[] = {};  	//Affects Land vehicles (including UGVs)
	
	
	/*	AI Air Vehicle patrol settings. 

		IMPORTANT: UAVs (Unmanned aerial vehicles) are not supported by this function. UAV spawns can be configured in the "UAV Patrol Settings" section further below.

		A3EAI will create AI vehicle patrols that will randomly travel between different cities and towns, and engage any players encountered.
		Helicopters with available cargo space may also occasionally deploy an AI group by parachute. 
	--------------------------------------------------------------------------------------------------------------------*/		

	//Global maximum number of active AI air vehicle patrols. Set at 0 to disable (Default: 0).							
	maxAirPatrols = 0;
	
	//Probability of spawning Level 0/1/2/3 AI air vehicle patrol spawns. Probabilities should add up to 1.00		
	levelChancesAir[] = {0.00,0.50,0.35,0.15};
	
	//Set minimum and maximum wait time in seconds to respawn an AI vehicle patrol after vehicle is destroyed or disabled. (Default: Min 600, Max 900).
	respawnAirMinTime = 600;
	respawnAirMaxTime = 900;
	
	//Classnames of air vehicle types to use, with the maximum amount of each type to spawn.
	airVehicleList[] = {
		{"B_Heli_Light_01_armed_F",5},
		{"B_Heli_Transport_01_F",5},
		{"B_Heli_Transport_03_F",2}
	};
	
	//Maximum number of gunner units per air vehicle. Limited by actual number of available gunner positions. (Default: 2)
	//Affects: All AI air vehicle patrols, including custom and reinforcement.
	airGunnerUnits = 2; 
	
	//Probability of AI helicopter sucessfully detecting player if there is line-of-sight. AI helicopters will conduct a visual sweep upon arriving at each waypoint and some distance after leaving. (Default: 0.80)
	//Affects: All AI air vehicle patrols, including custom and reinforcement.
	airDetectChance = 0.80;
	
	//Probability of AI to deploy infantry units by parachute if players are nearby when helicopter is investigating a waypoint. (Default: 0.50)
	//Affects: Air vehicle patrols.
	paradropChance = 0.50;
	
	//Cooldown time for AI paradrop deployment in seconds. (Default: 1800).
	//Affects: Air vehicle patrols.
	paradropCooldown = 1800;
	
	//Number of infantry AI to paradrop if players are nearby when helicopter is investigating a waypoint, or if helicopter is reinforcing a dynamic AI spawn. Limited by number of cargo seats available in the vehicle. (Default: 3)
	//Affects: Air vehicle patrols, air reinforcements.
	paradropAmount = 3;
	
	
	/*	AI Land Vehicle patrol settings. These AI vehicles will randomly travel between different cities and towns.

		IMPORTANT: UGVs (Unmanned ground vehicles) are not supported by this function. UGV spawns can be configured in the "UGV Patrol Settings" section further below.
		
		A3EAI will create AI vehicle patrols that will randomly travel between different cities and towns, and engage any players encountered.
	--------------------------------------------------------------------------------------------------------------------*/	

	
	//Global maximum number of active AI land vehicle patrols. Set at 0 to disable (Default: 0).	
	maxLandPatrols = 0;
	
	//Probability of spawning Level 0/1/2/3 AI land vehicle spawns. Probabilities should add up to 1.00		
	levelChancesLand[] = {0.00,0.50,0.35,0.15};
	
	//Set minimum and maximum wait time in seconds to respawn an AI vehicle patrol after vehicle is destroyed or disabled. (Default: Min 600, Max 900).
	respawnLandMinTime = 600;
	respawnLandMaxTime = 900;
	
	//Classnames of land vehicle types to use, with the maximum amount of each type to spawn.
	landVehicleList[] = {
		{"B_MRAP_01_EPOCH",5},
		{"C_Van_01_box_EPOCH",5},
		{"C_Van_01_transport_EPOCH",5},
		{"C_Offroad_01_EPOCH",5},
		{"C_Hatchback_02_EPOCH",5},
		{"C_Hatchback_01_EPOCH",5},
		{"C_SUV_01_EPOCH",5},
		{"B_Truck_01_transport_EPOCH",5},
		{"B_Truck_01_covered_EPOCH",5},
		{"B_Truck_01_mover_EPOCH",5},
		{"B_Truck_01_box_EPOCH",5},
		{"O_Truck_02_covered_EPOCH",5},
		{"O_Truck_02_transport_EPOCH",5},
		{"O_Truck_03_covered_EPOCH",5},
		{"O_Truck_02_box_EPOCH",5}
	};
	
	//Maximum number of gunner units per land vehicle. Limited by actual number of available gunner positions. (Default: 2)
	landGunnerUnits = 2;
	
	//Maximum number of cargo units per land vehicle. Limited by actual number of available cargo positions. (Default: 3)
	landCargoUnits = 3;
	
	
	/*	AI Air Reinforcement Settings

		Allowed types of AI groups (defined by airReinforcementAllowedTypes) may call for temporary air reinforcements if a player kills one of their units.
		Probability to summon reinforcements determined by airReinforcementSpawnChance<AI level>, where <AI level> is the level of the calling group.
		Once summoned, armed reinforcement vehicles will remain in the area for a duration determined by airReinforcementDuration<AI level> and engage nearby players.
		Unarmed reinforcement vehicles will deploy a paradrop group and exit the area.
		
	--------------------------------------------------------------------------------------------------------------------*/

	//Maximum allowed number of simultaneous active reinforcements (Default: 5)
	maxAirReinforcements = 5;
	
	//Air vehicles to use as reinforcement vehicles. Default: {"B_Heli_Transport_01_F","B_Heli_Light_01_armed_F"}
	//Armed air vehicles will detect and engage players within reinforcement area. Unarmed air vehicles will deploy an AI paradrop group.
	airReinforcementVehicles[] = {
		"B_Heli_Transport_01_F",
		"B_Heli_Light_01_armed_F"
	};
	
	//Probability to spawn reinforcements for each AI level.
	airReinforcementSpawnChance0 = 0.00;
	airReinforcementSpawnChance1 = 0.10;
	airReinforcementSpawnChance2 = 0.20;
	airReinforcementSpawnChance3 = 0.30;
	
	//AI types permitted to summon reinforcements. Default: airReinforcementAllowedFor[] = {"static","dynamic","random"};
	//Usable AI types: "static", "dynamic", "random", "air", "land", "staticcustom", "aircustom", "landcustom", "vehiclecrew"
	airReinforcementAllowedFor[] = {"static","dynamic","random"};
	
	//Maximum time for reinforcement for armed air vehicles in seconds. AI air vehicle will leave the area after this time if not destroyed.
	airReinforcementDuration0 = 120;
	airReinforcementDuration1 = 180;
	airReinforcementDuration2 = 240;
	airReinforcementDuration3 = 300;
	
	
	/*	UAV Patrol Settings

		IMPORTANT: UAV patrols are a feature in testing, and may undergo significant changes or possible removal in future versions.

		A3EAI can spawn UAVs that patrol between named locations, and deploy air reinforcements if players are found.
		In order for air reinforcements to be deployed, maxAirReinforcements must be greater than zero and the current limit of air reinforcements has not been exceeded.
	--------------------------------------------------------------------------------------------------------------------*/

	//Global maximum number of active UAV patrols. Set at 0 to disable (Default: 0).	
	maxUAVPatrols = 0;
	
	//Classnames of UAV types to use, with the maximum amount of each type to spawn.
	UAVList[] = {
		{"I_UAV_02_CAS_F",5},
		{"I_UAV_02_F",5},
		{"B_UAV_02_CAS_F",5},
		{"B_UAV_02_F",5},
		{"O_UAV_02_CAS_F",5},
		{"O_UAV_02_F",5}
	};
	
	//Probability of spawning Level 0/1/2/3 UAV spawns. Probabilities should add up to 1.00	
	levelChancesUAV[] = {0.35,0.50,0.15,0.00};
	
	//Set minimum and maximum wait time in seconds to respawn a UAV after vehicle is destroyed or disabled. (Default: Min 600, Max 900).
	respawnUAVMinTime = 600;
	respawnUAVMaxTime = 900;
	
	//Set to '1' to set detection-only behavior (UAV will not directly engage enemies). (Default: 0)
	detectOnlyUAVs = 0;
	
	//Cooldown required in between air reinforcement summons when detecting players. Value in seconds. (Default: 1800)
	UAVCallReinforceCooldown = 1800;
	
	//Probability to successfully detect player if there is line-of-sight. If at least one player is detected, air reinforcements will be summoned to the area. (Default: 0.50)
	UAVDetectChance = 0.80;
	
	
	/*	UGV Patrol Settings

		IMPORTANT: UGV patrols are a feature in testing, and may undergo significant changes or possible removal in future versions.

		A3EAI can spawn UGVs that patrol between named locations, and deploy air reinforcements if players are found. Damaged UGVs repair themselves over time if not engaging enemes.
		In order for air reinforcements to be deployed, maxAirReinforcements must be greater than zero and the current limit of air reinforcements has not been exceeded.
	--------------------------------------------------------------------------------------------------------------------*/

	//Global maximum number of active UGV patrols. Set at 0 to disable (Default: 0).	
	maxUGVPatrols = 0;
	
	//Classnames of UGV types to use, with the maximum amount of each type to spawn.
	UGVList[] = {
		{"I_UGV_01_rcws_F",5},
		{"B_UGV_01_rcws_F",5},
		{"O_UGV_01_rcws_F",5}
	};
	
	//Probability of spawning Level 0/1/2/3 AI UGV spawns. Probabilities should add up to 1.00	
	levelChancesUGV[] = {0.35,0.50,0.15,0.00};
	
	//Set minimum and maximum wait time in seconds to respawn a UGV patrol after vehicle is destroyed or disabled. (Default: Min 600, Max 900).
	respawnUGVMinTime = 600;
	respawnUGVMaxTime = 900;
	
	//Set to '1' to set detection-only behavior (UGV will not directly engage enemies). (Default: 0)
	detectOnlyUGVs = 0;
	
	//Cooldown required in between air reinforcement summons when detecting players. Value in seconds. (Default: 1800)
	UGVCallReinforceCooldown = 1800;
	
	//Probability to successfully detect player if there is line-of-sight. If at least one player is detected, air reinforcements will be summoned to the area. (Default: 0.50)
	UGVDetectChance = 0.80;
	
	
	/*
		AI skill settings. 
		
		These settings affect all AI units spawned by A3EAI.
		
		Skill Level: Description
		0: Low-level AI found in villages
		1: Medium-level AI found in cities and capital cities
		2: High-level AI found in remote areas such as factories and military bases
		3: Expert-level AI.
		
		Valid skill range: 0.00 - 1.00.
		Hint: For all skill types, higher number = better skill. For skill sub-type explanation, see: https://community.bistudio.com/wiki/AI_Sub-skills
	*/
	
	//AI skill settings level 0 (Skill, Minimum skill, Maximum skill). Defaults: Accuracy 0.05-0.10, Others 0.30-0.50
	skill0[] = {
		{"aimingAccuracy",0.05,0.10},
		{"aimingShake",0.30,0.50},
		{"aimingSpeed",0.30,0.50},
		{"spotDistance",0.30,0.50},
		{"spotTime",0.30,0.50},
		{"courage",0.30,0.50},
		{"reloadSpeed",0.30,0.50},
		{"commanding",0.30,0.50},
		{"general",0.30,0.50}
	};
	
	//AI skill settings level 1 (Skill, Minimum skill, Maximum skill). Defaults: Accuracy 0.10-0.15, Others 0.40-0.60
	skill1[] = {
		{"aimingAccuracy",0.10,0.15},
		{"aimingShake",0.40,0.60},
		{"aimingSpeed",0.40,0.60},
		{"spotDistance",0.40,0.60},
		{"spotTime",0.40,0.60},
		{"courage",0.40,0.60},
		{"reloadSpeed",0.40,0.60},
		{"commanding",0.40,0.60},
		{"general",0.40,0.60}	
	};
	
	//AI skill settings level 2 (Skill, Minimum skill, Maximum skill). Defaults: Accuracy 0.15-0.20, Others 0.50-0.70
	skill2[] = {
		{"aimingAccuracy",0.15,0.20},
		{"aimingShake",0.50,0.70},
		{"aimingSpeed",0.50,0.70},
		{"spotDistance",0.50,0.70},
		{"spotTime",0.50,0.70},
		{"courage",0.50,0.70},
		{"reloadSpeed",0.50,0.70},
		{"commanding",0.50,0.70},
		{"general",0.50,0.70}
	};
	
	//AI skill settings level 3 (Skill, Minimum skill, Maximum skill). Defaults: Accuracy 0.20-0.25, Others 0.60-0.80
	skill3[] = {
		{"aimingAccuracy",0.20,0.25},
		{"aimingShake",0.60,0.80},
		{"aimingSpeed",0.60,0.80},
		{"spotDistance",0.60,0.80},
		{"spotTime",0.60,0.80},
		{"courage",0.60,0.80},
		{"reloadSpeed",0.60,0.80},
		{"commanding",0.60,0.80},
		{"general",0.60,0.80}
	};
	
	
	/*	AI loadout probability settings.
	--------------------------------------------------------------------------------------------------------------------*/

	//Probabilities to equip uniform, according to AI level.
	addUniformChance0 = 0.60;
	addUniformChance1 = 0.70;
	addUniformChance2 = 0.80;
	addUniformChance3 = 0.90;
	
	//Probabilities to equip backpack, according to AI level.
	addBackpackChance0 = 0.60;
	addBackpackChance1 = 0.70;
	addBackpackChance2 = 0.80;
	addBackpackChance3 = 0.90;
	
	//Probabilities to equip vest, according to AI level.
	addVestChance0 = 0.60;
	addVestChance1 = 0.70;
	addVestChance2 = 0.80;
	addVestChance3 = 0.90;
	
	//Probabilities to equip headgear, according to AI level.
	addHeadgearChance0 = 0.60;
	addHeadgearChance1 = 0.70;
	addHeadgearChance2 = 0.80;
	addHeadgearChance3 = 0.90;
	
	//Probabilities to equip level 0-3 AI with each weapon type. Order: {pistols, rifles, machineguns, sniper rifles}. Probabilities must add up to 1.00.
	useWeaponChance0[] = {0.20,0.80,0.00,0.00};
	useWeaponChance1[] = {0.00,0.90,0.05,0.05};
	useWeaponChance2[] = {0.00,0.80,0.10,0.10};
	useWeaponChance3[] = {0.00,0.70,0.15,0.15};
	
	//Probability to select a random optics attachment (ie: scopes) for level 0-3 AI
	opticsChance0 = 0.00;
	opticsChance1 = 0.30;
	opticsChance2 = 0.60;
	opticsChance3 = 0.90;
	
	//Probability to select a random pointer attachment (ie: flashlights) for level 0-3 AI
	pointerChance0 = 0.00;
	pointerChance1 = 0.30;
	pointerChance2 = 0.60;
	pointerChance3 = 0.90;
	
	//Probability to select a random muzzle attachment (ie: suppressors) for level 0-3 AI
	muzzleChance0 = 0.00;
	muzzleChance1 = 0.30;
	muzzleChance2 = 0.60;
	muzzleChance3 = 0.90;
	
	//Probability to select a random underbarrel attachment (ie: bipods) for level 0-3 AI
	underbarrelChance0 = 0.00;
	underbarrelChance1 = 0.30;
	underbarrelChance2 = 0.60;
	underbarrelChance3 = 0.90;
	
	
	/*	AI loot quantity settings
	--------------------------------------------------------------------------------------------------------------------*/

	//Maximum amount of Krypto generated for level 0-3 AI. Actual amount will be randomized up to the specified amount.
	kryptoAmount0 = 50;
	kryptoAmount1 = 75;
	kryptoAmount2 = 100;
	kryptoAmount3 = 150;
	
	//Krypto pickup assist time window in seconds. Players must be within 2 meters of a Krypto device for 5 seconds to pick up Krypto automatically. 0: Disabled (Default: 0)
	//After this time limit, players must manually pick up any dropped Krypto.
	kryptoPickupAssist = 0;
	
	//Maximum number of food loot items found on AI. (Default: 2)								
	foodLootCount = 2;
	
	//Maximum number of items to select from A3EAI_miscLoot1 (generic loot) table. (Default: 1)											
	miscLootCount1 = 2;
	
	//Maximum number of items to select from A3EAI_miscLoot2 (large generic loot) table. (Default: 1)					
	miscLootCount2 = 1;

	
	/*	AI loot probability settings. AI loot is pre-generated into a pool for each unit and randomly pulled to units as time passes.
	--------------------------------------------------------------------------------------------------------------------*/

	//Chance to add a single First Aid Kit to group loot pool per unit (Default: 0.25)
	firstAidKitChance = 0.25;
	
	//Probability to successfully pull a random item from loot pool for level 0-3 AI. Influences the rate at which loot items are added to units.
	lootPullChance0 = 0.20;
	lootPullChance1 = 0.40;
	lootPullChance2 = 0.60;
	lootPullChance3 = 0.80;

	
	/*
		AI skin, weapon, loot, and equipment settings

		Note: Some of the below tables may not be used by A3EAI if a dynamic classname setting is enabled. Check each section below for details.
	*/
	
	//AI uniform classnames. Note: uniformTypes0-3 will not be read if generateDynamicUniforms is enabled.
	//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	uniformTypes0[] = {"U_O_CombatUniform_ocamo", "U_O_GhillieSuit", "U_O_PilotCoveralls", "U_O_Wetsuit", "U_OG_Guerilla1_1", "U_OG_Guerilla2_1", "U_OG_Guerilla2_3", "U_OG_Guerilla3_1", "U_OG_Guerilla3_2", "U_OG_leader", "U_C_Poloshirt_stripped", "U_C_Poloshirt_blue", "U_C_Poloshirt_burgundy", "U_C_Poloshirt_tricolour", "U_C_Poloshirt_salmon", "U_C_Poloshirt_redwhite", "U_C_Poor_1", "U_C_WorkerCoveralls", "U_C_Journalist", "U_C_Scientist", "U_OrestesBody", "U_Wetsuit_uniform", "U_Wetsuit_White", "U_Wetsuit_Blue", "U_Wetsuit_Purp", "U_Wetsuit_Camo", "U_CamoRed_uniform", "U_CamoBrn_uniform", "U_CamoBlue_uniform", "U_Camo_uniform", "U_ghillie1_uniform", "U_ghillie2_uniform", "U_ghillie3_uniform", "U_C_Driver_1", "U_C_Driver_2", "U_C_Driver_3", "U_C_Driver_4", "U_C_Driver_1_black", "U_C_Driver_1_blue", "U_C_Driver_1_green", "U_C_Driver_1_red", "U_C_Driver_1_white", "U_C_Driver_1_yellow", "U_C_Driver_1_orange", "U_C_Driver_1_red"};
	uniformTypes1[] = {"U_O_CombatUniform_ocamo", "U_O_GhillieSuit", "U_O_PilotCoveralls", "U_O_Wetsuit", "U_OG_Guerilla1_1", "U_OG_Guerilla2_1", "U_OG_Guerilla2_3", "U_OG_Guerilla3_1", "U_OG_Guerilla3_2", "U_OG_leader", "U_C_Poloshirt_stripped", "U_C_Poloshirt_blue", "U_C_Poloshirt_burgundy", "U_C_Poloshirt_tricolour", "U_C_Poloshirt_salmon", "U_C_Poloshirt_redwhite", "U_C_Poor_1", "U_C_WorkerCoveralls", "U_C_Journalist", "U_C_Scientist", "U_OrestesBody", "U_Wetsuit_uniform", "U_Wetsuit_White", "U_Wetsuit_Blue", "U_Wetsuit_Purp", "U_Wetsuit_Camo", "U_CamoRed_uniform", "U_CamoBrn_uniform", "U_CamoBlue_uniform", "U_Camo_uniform", "U_ghillie1_uniform", "U_ghillie2_uniform", "U_ghillie3_uniform", "U_C_Driver_1", "U_C_Driver_2", "U_C_Driver_3", "U_C_Driver_4", "U_C_Driver_1_black", "U_C_Driver_1_blue", "U_C_Driver_1_green", "U_C_Driver_1_red", "U_C_Driver_1_white", "U_C_Driver_1_yellow", "U_C_Driver_1_orange", "U_C_Driver_1_red"};
	uniformTypes2[] = {"U_O_CombatUniform_ocamo", "U_O_GhillieSuit", "U_O_PilotCoveralls", "U_O_Wetsuit", "U_OG_Guerilla1_1", "U_OG_Guerilla2_1", "U_OG_Guerilla2_3", "U_OG_Guerilla3_1", "U_OG_Guerilla3_2", "U_OG_leader", "U_C_Poloshirt_stripped", "U_C_Poloshirt_blue", "U_C_Poloshirt_burgundy", "U_C_Poloshirt_tricolour", "U_C_Poloshirt_salmon", "U_C_Poloshirt_redwhite", "U_C_Poor_1", "U_C_WorkerCoveralls", "U_C_Journalist", "U_C_Scientist", "U_OrestesBody", "U_Wetsuit_uniform", "U_Wetsuit_White", "U_Wetsuit_Blue", "U_Wetsuit_Purp", "U_Wetsuit_Camo", "U_CamoRed_uniform", "U_CamoBrn_uniform", "U_CamoBlue_uniform", "U_Camo_uniform", "U_ghillie1_uniform", "U_ghillie2_uniform", "U_ghillie3_uniform", "U_C_Driver_1", "U_C_Driver_2", "U_C_Driver_3", "U_C_Driver_4", "U_C_Driver_1_black", "U_C_Driver_1_blue", "U_C_Driver_1_green", "U_C_Driver_1_red", "U_C_Driver_1_white", "U_C_Driver_1_yellow", "U_C_Driver_1_orange", "U_C_Driver_1_red"};
	uniformTypes3[] = {"U_O_CombatUniform_ocamo", "U_O_GhillieSuit", "U_O_PilotCoveralls", "U_O_Wetsuit", "U_OG_Guerilla1_1", "U_OG_Guerilla2_1", "U_OG_Guerilla2_3", "U_OG_Guerilla3_1", "U_OG_Guerilla3_2", "U_OG_leader", "U_C_Poloshirt_stripped", "U_C_Poloshirt_blue", "U_C_Poloshirt_burgundy", "U_C_Poloshirt_tricolour", "U_C_Poloshirt_salmon", "U_C_Poloshirt_redwhite", "U_C_Poor_1", "U_C_WorkerCoveralls", "U_C_Journalist", "U_C_Scientist", "U_OrestesBody", "U_Wetsuit_uniform", "U_Wetsuit_White", "U_Wetsuit_Blue", "U_Wetsuit_Purp", "U_Wetsuit_Camo", "U_CamoRed_uniform", "U_CamoBrn_uniform", "U_CamoBlue_uniform", "U_Camo_uniform", "U_ghillie1_uniform", "U_ghillie2_uniform", "U_ghillie3_uniform", "U_C_Driver_1", "U_C_Driver_2", "U_C_Driver_3", "U_C_Driver_4", "U_C_Driver_1_black", "U_C_Driver_1_blue", "U_C_Driver_1_green", "U_C_Driver_1_red", "U_C_Driver_1_white", "U_C_Driver_1_yellow", "U_C_Driver_1_orange", "U_C_Driver_1_red"};
	
	//AI weapon classnames. Note: pistolList, rifleList, machinegunList, sniperList will not be read if generateDynamicWeapons is enabled.
	//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	pistolList[] = {"hgun_Pistol_heavy_01_F","hgun_P07_F","hgun_Rook40_F","hgun_Pistol_heavy_02_F","1911_pistol_epoch","hgun_ACPC2_F","ruger_pistol_epoch"};
	rifleList[] = {"AKM_EPOCH","sr25_epoch","arifle_Katiba_GL_F","arifle_Katiba_C_F","arifle_Katiba_F","arifle_MX_GL_F","arifle_MX_GL_Black_F","arifle_MXM_Black_F","arifle_MXC_Black_F","arifle_MX_Black_F","arifle_MXM_F","arifle_MXC_F","arifle_MX_F","l85a2_epoch","l85a2_pink_epoch","l85a2_ugl_epoch","m4a3_EPOCH","m16_EPOCH","m16Red_EPOCH","arifle_Mk20_GL_F","arifle_Mk20_GL_plain_F","arifle_Mk20C_F","arifle_Mk20C_plain_F","arifle_Mk20_F","arifle_Mk20_plain_F","arifle_TRG21_GL_F","arifle_TRG21_F","arifle_TRG20_F","arifle_SDAR_F","Rollins_F","SMG_01_F","SMG_02_F","hgun_PDW2000_F"};
	machinegunList[] = {"LMG_Zafir_F","arifle_MX_SW_F","arifle_MX_SW_Black_F","LMG_Mk200_F","m249_EPOCH","m249Tan_EPOCH","MMG_01_hex_F","MMG_01_tan_F","MMG_02_camo_F","MMG_02_black_F","MMG_02_sand_F"};
	sniperList[] = {"m107_EPOCH","m107Tan_EPOCH","srifle_DMR_02_F","srifle_DMR_02_camo_F","srifle_DMR_02_sniper_F","srifle_DMR_03_F","srifle_DMR_03_khaki_F","srifle_DMR_03_tan_F","srifle_DMR_03_multicam_F","srifle_DMR_03_woodland_F","srifle_DMR_03_spotter_F","srifle_DMR_04_F","srifle_DMR_04_Tan_F","srifle_DMR_05_blk_F","srifle_DMR_05_hex_F","srifle_DMR_05_tan_f","srifle_DMR_06_camo_F","srifle_DMR_06_olive_F","srifle_LRR_F","srifle_GM6_F","srifle_DMR_01_F","M14_EPOCH","M14Grn_EPOCH","srifle_EBR_F"};
	
	//AI weapon scope attachment settings. Note: weaponOpticsList will not be read if generateDynamicOptics is enabled.
	weaponOpticsList[] = {"optic_NVS","optic_SOS","optic_LRPS","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_KHS_blk","optic_KHS_hex","optic_KHS_old","optic_KHS_tan","optic_DMS","optic_Arco","optic_Hamr","Elcan_Exile","Elcan_reflex_Exile","optic_MRCO","optic_Holosight","optic_Holosight_smg","optic_Aco","optic_ACO_grn","optic_Aco_smg","optic_ACO_grn_smg","optic_Yorris","optic_MRD"};
	
	//AI backpack types (for AI levels 0-3). Note: backpackTypes0-3 will not be read if generateDynamicBackpacks is enabled.
	//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	backpackTypes0[] = {"B_AssaultPack_cbr", "B_AssaultPack_dgtl", "B_AssaultPack_khk", "B_AssaultPack_mcamo", "B_AssaultPack_ocamo", "B_AssaultPack_rgr", "B_AssaultPack_sgg", "B_Carryall_cbr", "B_Carryall_khk", "B_Carryall_mcamo", "B_Carryall_ocamo", "B_Carryall_oli", "B_Carryall_oucamo", "B_FieldPack_blk", "B_FieldPack_cbr", "B_FieldPack_khk", "B_FieldPack_ocamo", "B_FieldPack_oli", "B_FieldPack_oucamo", "B_Kitbag_cbr", "B_Kitbag_mcamo", "B_Kitbag_rgr", "B_Kitbag_sgg", "B_Parachute", "B_TacticalPack_blk", "B_TacticalPack_mcamo", "B_TacticalPack_ocamo", "B_TacticalPack_oli", "B_TacticalPack_rgr", "smallbackpack_red_epoch", "smallbackpack_green_epoch", "smallbackpack_teal_epoch", "smallbackpack_pink_epoch"};
	backpackTypes1[] = {"B_AssaultPack_cbr", "B_AssaultPack_dgtl", "B_AssaultPack_khk", "B_AssaultPack_mcamo", "B_AssaultPack_ocamo", "B_AssaultPack_rgr", "B_AssaultPack_sgg", "B_Carryall_cbr", "B_Carryall_khk", "B_Carryall_mcamo", "B_Carryall_ocamo", "B_Carryall_oli", "B_Carryall_oucamo", "B_FieldPack_blk", "B_FieldPack_cbr", "B_FieldPack_khk", "B_FieldPack_ocamo", "B_FieldPack_oli", "B_FieldPack_oucamo", "B_Kitbag_cbr", "B_Kitbag_mcamo", "B_Kitbag_rgr", "B_Kitbag_sgg", "B_Parachute", "B_TacticalPack_blk", "B_TacticalPack_mcamo", "B_TacticalPack_ocamo", "B_TacticalPack_oli", "B_TacticalPack_rgr", "smallbackpack_red_epoch", "smallbackpack_green_epoch", "smallbackpack_teal_epoch", "smallbackpack_pink_epoch"};
	backpackTypes2[] = {"B_AssaultPack_cbr", "B_AssaultPack_dgtl", "B_AssaultPack_khk", "B_AssaultPack_mcamo", "B_AssaultPack_ocamo", "B_AssaultPack_rgr", "B_AssaultPack_sgg", "B_Carryall_cbr", "B_Carryall_khk", "B_Carryall_mcamo", "B_Carryall_ocamo", "B_Carryall_oli", "B_Carryall_oucamo", "B_FieldPack_blk", "B_FieldPack_cbr", "B_FieldPack_khk", "B_FieldPack_ocamo", "B_FieldPack_oli", "B_FieldPack_oucamo", "B_Kitbag_cbr", "B_Kitbag_mcamo", "B_Kitbag_rgr", "B_Kitbag_sgg", "B_Parachute", "B_TacticalPack_blk", "B_TacticalPack_mcamo", "B_TacticalPack_ocamo", "B_TacticalPack_oli", "B_TacticalPack_rgr", "smallbackpack_red_epoch", "smallbackpack_green_epoch", "smallbackpack_teal_epoch", "smallbackpack_pink_epoch"};
	backpackTypes3[] = {"B_AssaultPack_cbr", "B_AssaultPack_dgtl", "B_AssaultPack_khk", "B_AssaultPack_mcamo", "B_AssaultPack_ocamo", "B_AssaultPack_rgr", "B_AssaultPack_sgg", "B_Carryall_cbr", "B_Carryall_khk", "B_Carryall_mcamo", "B_Carryall_ocamo", "B_Carryall_oli", "B_Carryall_oucamo", "B_FieldPack_blk", "B_FieldPack_cbr", "B_FieldPack_khk", "B_FieldPack_ocamo", "B_FieldPack_oli", "B_FieldPack_oucamo", "B_Kitbag_cbr", "B_Kitbag_mcamo", "B_Kitbag_rgr", "B_Kitbag_sgg", "B_Parachute", "B_TacticalPack_blk", "B_TacticalPack_mcamo", "B_TacticalPack_ocamo", "B_TacticalPack_oli", "B_TacticalPack_rgr", "smallbackpack_red_epoch", "smallbackpack_green_epoch", "smallbackpack_teal_epoch", "smallbackpack_pink_epoch"};
	
	//AI vest types (for AI levels 0-3). Note: vestTypes0-3 will not be read if generateDynamicVests is enabled.
	//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	vestTypes0[] = {"V_1_EPOCH", "V_2_EPOCH", "V_3_EPOCH", "V_4_EPOCH", "V_5_EPOCH", "V_6_EPOCH", "V_7_EPOCH", "V_8_EPOCH", "V_9_EPOCH", "V_10_EPOCH", "V_11_EPOCH", "V_12_EPOCH", "V_13_EPOCH", "V_14_EPOCH", "V_15_EPOCH", "V_16_EPOCH", "V_17_EPOCH", "V_18_EPOCH", "V_19_EPOCH", "V_20_EPOCH", "V_21_EPOCH", "V_22_EPOCH", "V_23_EPOCH", "V_24_EPOCH", "V_25_EPOCH", "V_26_EPOCH", "V_27_EPOCH", "V_28_EPOCH", "V_29_EPOCH", "V_30_EPOCH", "V_31_EPOCH", "V_32_EPOCH", "V_33_EPOCH", "V_34_EPOCH", "V_35_EPOCH", "V_36_EPOCH", "V_37_EPOCH", "V_38_EPOCH", "V_39_EPOCH", "V_40_EPOCH"};
	vestTypes1[] = {"V_1_EPOCH", "V_2_EPOCH", "V_3_EPOCH", "V_4_EPOCH", "V_5_EPOCH", "V_6_EPOCH", "V_7_EPOCH", "V_8_EPOCH", "V_9_EPOCH", "V_10_EPOCH", "V_11_EPOCH", "V_12_EPOCH", "V_13_EPOCH", "V_14_EPOCH", "V_15_EPOCH", "V_16_EPOCH", "V_17_EPOCH", "V_18_EPOCH", "V_19_EPOCH", "V_20_EPOCH", "V_21_EPOCH", "V_22_EPOCH", "V_23_EPOCH", "V_24_EPOCH", "V_25_EPOCH", "V_26_EPOCH", "V_27_EPOCH", "V_28_EPOCH", "V_29_EPOCH", "V_30_EPOCH", "V_31_EPOCH", "V_32_EPOCH", "V_33_EPOCH", "V_34_EPOCH", "V_35_EPOCH", "V_36_EPOCH", "V_37_EPOCH", "V_38_EPOCH", "V_39_EPOCH", "V_40_EPOCH"};
	vestTypes2[] = {"V_1_EPOCH", "V_2_EPOCH", "V_3_EPOCH", "V_4_EPOCH", "V_5_EPOCH", "V_6_EPOCH", "V_7_EPOCH", "V_8_EPOCH", "V_9_EPOCH", "V_10_EPOCH", "V_11_EPOCH", "V_12_EPOCH", "V_13_EPOCH", "V_14_EPOCH", "V_15_EPOCH", "V_16_EPOCH", "V_17_EPOCH", "V_18_EPOCH", "V_19_EPOCH", "V_20_EPOCH", "V_21_EPOCH", "V_22_EPOCH", "V_23_EPOCH", "V_24_EPOCH", "V_25_EPOCH", "V_26_EPOCH", "V_27_EPOCH", "V_28_EPOCH", "V_29_EPOCH", "V_30_EPOCH", "V_31_EPOCH", "V_32_EPOCH", "V_33_EPOCH", "V_34_EPOCH", "V_35_EPOCH", "V_36_EPOCH", "V_37_EPOCH", "V_38_EPOCH", "V_39_EPOCH", "V_40_EPOCH"};
	vestTypes3[] = {"V_1_EPOCH", "V_2_EPOCH", "V_3_EPOCH", "V_4_EPOCH", "V_5_EPOCH", "V_6_EPOCH", "V_7_EPOCH", "V_8_EPOCH", "V_9_EPOCH", "V_10_EPOCH", "V_11_EPOCH", "V_12_EPOCH", "V_13_EPOCH", "V_14_EPOCH", "V_15_EPOCH", "V_16_EPOCH", "V_17_EPOCH", "V_18_EPOCH", "V_19_EPOCH", "V_20_EPOCH", "V_21_EPOCH", "V_22_EPOCH", "V_23_EPOCH", "V_24_EPOCH", "V_25_EPOCH", "V_26_EPOCH", "V_27_EPOCH", "V_28_EPOCH", "V_29_EPOCH", "V_30_EPOCH", "V_31_EPOCH", "V_32_EPOCH", "V_33_EPOCH", "V_34_EPOCH", "V_35_EPOCH", "V_36_EPOCH", "V_37_EPOCH", "V_38_EPOCH", "V_39_EPOCH", "V_40_EPOCH"};
	
	//AI head gear types. Note: headgearTypes0-3 will not be read if generateDynamicHeadgear is enabled.
	headgearTypes0[] = {"H_1_EPOCH","H_2_EPOCH","H_3_EPOCH","H_4_EPOCH","H_5_EPOCH","H_6_EPOCH","H_7_EPOCH","H_8_EPOCH","H_9_EPOCH","H_10_EPOCH","H_11_EPOCH","H_12_EPOCH","H_13_EPOCH","H_14_EPOCH","H_15_EPOCH","H_16_EPOCH","H_17_EPOCH","H_18_EPOCH","H_19_EPOCH","H_20_EPOCH","H_21_EPOCH","H_22_EPOCH","H_23_EPOCH","H_24_EPOCH","H_25_EPOCH","H_26_EPOCH","H_27_EPOCH","H_28_EPOCH","H_29_EPOCH","H_30_EPOCH","H_31_EPOCH","H_32_EPOCH","H_33_EPOCH","H_34_EPOCH","H_35_EPOCH","H_36_EPOCH","H_37_EPOCH","H_38_EPOCH","H_39_EPOCH","H_40_EPOCH","H_41_EPOCH","H_42_EPOCH","H_43_EPOCH","H_44_EPOCH","H_45_EPOCH","H_46_EPOCH","H_47_EPOCH","H_48_EPOCH","H_49_EPOCH","H_50_EPOCH","H_51_EPOCH","H_52_EPOCH","H_53_EPOCH","H_54_EPOCH","H_55_EPOCH","H_56_EPOCH","H_57_EPOCH","H_58_EPOCH","H_59_EPOCH","H_60_EPOCH","H_61_EPOCH","H_62_EPOCH","H_63_EPOCH","H_64_EPOCH","H_65_EPOCH","H_66_EPOCH","H_67_EPOCH","H_68_EPOCH","H_69_EPOCH","H_70_EPOCH","H_71_EPOCH","H_72_EPOCH","H_73_EPOCH","H_74_EPOCH","H_75_EPOCH","H_76_EPOCH","H_77_EPOCH","H_78_EPOCH","H_79_EPOCH","H_80_EPOCH","H_81_EPOCH","H_82_EPOCH","H_83_EPOCH","H_84_EPOCH","H_85_EPOCH","H_86_EPOCH","H_87_EPOCH","H_88_EPOCH","H_89_EPOCH","H_90_EPOCH","H_91_EPOCH","H_92_EPOCH","H_93_EPOCH","H_94_EPOCH","H_95_EPOCH","H_96_EPOCH","H_97_EPOCH","H_98_EPOCH","H_99_EPOCH","H_100_EPOCH","H_101_EPOCH","H_102_EPOCH","H_103_EPOCH","H_104_EPOCH"};
	headgearTypes1[] = {"H_1_EPOCH","H_2_EPOCH","H_3_EPOCH","H_4_EPOCH","H_5_EPOCH","H_6_EPOCH","H_7_EPOCH","H_8_EPOCH","H_9_EPOCH","H_10_EPOCH","H_11_EPOCH","H_12_EPOCH","H_13_EPOCH","H_14_EPOCH","H_15_EPOCH","H_16_EPOCH","H_17_EPOCH","H_18_EPOCH","H_19_EPOCH","H_20_EPOCH","H_21_EPOCH","H_22_EPOCH","H_23_EPOCH","H_24_EPOCH","H_25_EPOCH","H_26_EPOCH","H_27_EPOCH","H_28_EPOCH","H_29_EPOCH","H_30_EPOCH","H_31_EPOCH","H_32_EPOCH","H_33_EPOCH","H_34_EPOCH","H_35_EPOCH","H_36_EPOCH","H_37_EPOCH","H_38_EPOCH","H_39_EPOCH","H_40_EPOCH","H_41_EPOCH","H_42_EPOCH","H_43_EPOCH","H_44_EPOCH","H_45_EPOCH","H_46_EPOCH","H_47_EPOCH","H_48_EPOCH","H_49_EPOCH","H_50_EPOCH","H_51_EPOCH","H_52_EPOCH","H_53_EPOCH","H_54_EPOCH","H_55_EPOCH","H_56_EPOCH","H_57_EPOCH","H_58_EPOCH","H_59_EPOCH","H_60_EPOCH","H_61_EPOCH","H_62_EPOCH","H_63_EPOCH","H_64_EPOCH","H_65_EPOCH","H_66_EPOCH","H_67_EPOCH","H_68_EPOCH","H_69_EPOCH","H_70_EPOCH","H_71_EPOCH","H_72_EPOCH","H_73_EPOCH","H_74_EPOCH","H_75_EPOCH","H_76_EPOCH","H_77_EPOCH","H_78_EPOCH","H_79_EPOCH","H_80_EPOCH","H_81_EPOCH","H_82_EPOCH","H_83_EPOCH","H_84_EPOCH","H_85_EPOCH","H_86_EPOCH","H_87_EPOCH","H_88_EPOCH","H_89_EPOCH","H_90_EPOCH","H_91_EPOCH","H_92_EPOCH","H_93_EPOCH","H_94_EPOCH","H_95_EPOCH","H_96_EPOCH","H_97_EPOCH","H_98_EPOCH","H_99_EPOCH","H_100_EPOCH","H_101_EPOCH","H_102_EPOCH","H_103_EPOCH","H_104_EPOCH"};
	headgearTypes2[] = {"H_1_EPOCH","H_2_EPOCH","H_3_EPOCH","H_4_EPOCH","H_5_EPOCH","H_6_EPOCH","H_7_EPOCH","H_8_EPOCH","H_9_EPOCH","H_10_EPOCH","H_11_EPOCH","H_12_EPOCH","H_13_EPOCH","H_14_EPOCH","H_15_EPOCH","H_16_EPOCH","H_17_EPOCH","H_18_EPOCH","H_19_EPOCH","H_20_EPOCH","H_21_EPOCH","H_22_EPOCH","H_23_EPOCH","H_24_EPOCH","H_25_EPOCH","H_26_EPOCH","H_27_EPOCH","H_28_EPOCH","H_29_EPOCH","H_30_EPOCH","H_31_EPOCH","H_32_EPOCH","H_33_EPOCH","H_34_EPOCH","H_35_EPOCH","H_36_EPOCH","H_37_EPOCH","H_38_EPOCH","H_39_EPOCH","H_40_EPOCH","H_41_EPOCH","H_42_EPOCH","H_43_EPOCH","H_44_EPOCH","H_45_EPOCH","H_46_EPOCH","H_47_EPOCH","H_48_EPOCH","H_49_EPOCH","H_50_EPOCH","H_51_EPOCH","H_52_EPOCH","H_53_EPOCH","H_54_EPOCH","H_55_EPOCH","H_56_EPOCH","H_57_EPOCH","H_58_EPOCH","H_59_EPOCH","H_60_EPOCH","H_61_EPOCH","H_62_EPOCH","H_63_EPOCH","H_64_EPOCH","H_65_EPOCH","H_66_EPOCH","H_67_EPOCH","H_68_EPOCH","H_69_EPOCH","H_70_EPOCH","H_71_EPOCH","H_72_EPOCH","H_73_EPOCH","H_74_EPOCH","H_75_EPOCH","H_76_EPOCH","H_77_EPOCH","H_78_EPOCH","H_79_EPOCH","H_80_EPOCH","H_81_EPOCH","H_82_EPOCH","H_83_EPOCH","H_84_EPOCH","H_85_EPOCH","H_86_EPOCH","H_87_EPOCH","H_88_EPOCH","H_89_EPOCH","H_90_EPOCH","H_91_EPOCH","H_92_EPOCH","H_93_EPOCH","H_94_EPOCH","H_95_EPOCH","H_96_EPOCH","H_97_EPOCH","H_98_EPOCH","H_99_EPOCH","H_100_EPOCH","H_101_EPOCH","H_102_EPOCH","H_103_EPOCH","H_104_EPOCH"};
	headgearTypes3[] = {"H_1_EPOCH","H_2_EPOCH","H_3_EPOCH","H_4_EPOCH","H_5_EPOCH","H_6_EPOCH","H_7_EPOCH","H_8_EPOCH","H_9_EPOCH","H_10_EPOCH","H_11_EPOCH","H_12_EPOCH","H_13_EPOCH","H_14_EPOCH","H_15_EPOCH","H_16_EPOCH","H_17_EPOCH","H_18_EPOCH","H_19_EPOCH","H_20_EPOCH","H_21_EPOCH","H_22_EPOCH","H_23_EPOCH","H_24_EPOCH","H_25_EPOCH","H_26_EPOCH","H_27_EPOCH","H_28_EPOCH","H_29_EPOCH","H_30_EPOCH","H_31_EPOCH","H_32_EPOCH","H_33_EPOCH","H_34_EPOCH","H_35_EPOCH","H_36_EPOCH","H_37_EPOCH","H_38_EPOCH","H_39_EPOCH","H_40_EPOCH","H_41_EPOCH","H_42_EPOCH","H_43_EPOCH","H_44_EPOCH","H_45_EPOCH","H_46_EPOCH","H_47_EPOCH","H_48_EPOCH","H_49_EPOCH","H_50_EPOCH","H_51_EPOCH","H_52_EPOCH","H_53_EPOCH","H_54_EPOCH","H_55_EPOCH","H_56_EPOCH","H_57_EPOCH","H_58_EPOCH","H_59_EPOCH","H_60_EPOCH","H_61_EPOCH","H_62_EPOCH","H_63_EPOCH","H_64_EPOCH","H_65_EPOCH","H_66_EPOCH","H_67_EPOCH","H_68_EPOCH","H_69_EPOCH","H_70_EPOCH","H_71_EPOCH","H_72_EPOCH","H_73_EPOCH","H_74_EPOCH","H_75_EPOCH","H_76_EPOCH","H_77_EPOCH","H_78_EPOCH","H_79_EPOCH","H_80_EPOCH","H_81_EPOCH","H_82_EPOCH","H_83_EPOCH","H_84_EPOCH","H_85_EPOCH","H_86_EPOCH","H_87_EPOCH","H_88_EPOCH","H_89_EPOCH","H_90_EPOCH","H_91_EPOCH","H_92_EPOCH","H_93_EPOCH","H_94_EPOCH","H_95_EPOCH","H_96_EPOCH","H_97_EPOCH","H_98_EPOCH","H_99_EPOCH","H_100_EPOCH","H_101_EPOCH","H_102_EPOCH","H_103_EPOCH","H_104_EPOCH"};
	
	
	//AI Food/Loot item types. 
	// Note: foodLoot will not be read if generateDynamicFood is enabled.
	// Note: miscLoot1/miscLoot2 will not be read if generateDynamicLoot is enabled.
	//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	foodLoot[] = {"FoodSnooter","FoodWalkNSons","FoodBioMeat","ItemSodaOrangeSherbet","ItemSodaPurple","ItemSodaMocha","ItemSodaBurst","ItemSodaRbull","honey_epoch","emptyjar_epoch","sardines_epoch","meatballs_epoch","scam_epoch","sweetcorn_epoch","WhiskeyNoodle","ItemCoolerE"};
	miscLoot1[] = {"PaintCanClear","PaintCanBlk","PaintCanBlu","PaintCanBrn","PaintCanGrn","PaintCanOra","PaintCanPur","PaintCanRed","PaintCanTeal","PaintCanYel","ItemDocument","ItemMixOil","emptyjar_epoch","emptyjar_epoch","FoodBioMeat","Towelette","Towelette","Towelette","Towelette","Towelette","HeatPack","HeatPack","HeatPack","ColdPack","ColdPack","VehicleRepair","CircuitParts","ItemCoolerE","ItemScraps","ItemScraps"};
	miscLoot2[] = {"MortarBucket","MortarBucket","ItemCorrugated","CinderBlocks","jerrycan_epoch","jerrycan_epoch","VehicleRepair","VehicleRepair","CircuitParts"};
	
	
	//AI toolbelt item types. Toolbelt items are added to AI inventory upon death. Format: {item classname, item probability}
	//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	toolsList0[] = {
		{"ItemWatch",0.90},{"ItemCompass",0.30},{"ItemMap",0.30},{"ItemGPS",0.00},{"EpochRadio0",0.00}
	};
	toolsList1[] = {
		{"ItemWatch",0.90},{"ItemCompass",0.50},{"ItemMap",0.50},{"ItemGPS",0.10},{"EpochRadio0",0.10}
	};
	toolsList2[] = {
		{"ItemWatch",0.90},{"ItemCompass",0.70},{"ItemMap",0.70},{"ItemGPS",0.20},{"EpochRadio0",0.20}
	};
	toolsList3[] = {
		{"ItemWatch",0.90},{"ItemCompass",0.90},{"ItemMap",0.90},{"ItemGPS",0.30},{"EpochRadio0",0.30}
	};
	
	
	//AI-useable toolbelt item types. These items are added to AI inventory at unit creation and may be used by AI. Format: [item classname, item probability]
	//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	gadgetsList0[] = {
		{"binocular",0.50},{"NVG_EPOCH",0.00}
	};
	gadgetsList1[] = {
		{"binocular",0.50},{"NVG_EPOCH",0.10}
	};
	gadgetsList2[] = {
		{"binocular",0.70},{"NVG_EPOCH",0.20}
	};
	gadgetsList3[] = { 
		{"binocular",0.90},{"NVG_EPOCH",0.30}
	};
};
