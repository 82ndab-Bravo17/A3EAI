/*
	A3EAI Functions

*/

diag_log "[A3EAI] Compiling A3EAI functions.";

call compile preprocessFile format ["%1\SHK_pos\A3EAI_SHK_pos_init.sqf",A3EAI_directory];

//A3EAI_behavior
A3EAI_BIN_taskPatrol = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_BIN_taskPatrol.sqf",A3EAI_directory];
A3EAI_customHeliDetect = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_customHeliDetect.sqf",A3EAI_directory];
A3EAI_heliDetection = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_heliDetection.sqf",A3EAI_directory];
A3EAI_heliStartPatrol = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_heliStartPatrol.sqf",A3EAI_directory];
A3EAI_hunterLocate = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_hunterLocate.sqf",A3EAI_directory];
A3EAI_huntKiller = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_huntKiller.sqf",A3EAI_directory];
A3EAI_reinforce_begin = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_reinforce_begin.sqf",A3EAI_directory];
A3EAI_vehCrewRegroup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_vehCrewRegroup.sqf",A3EAI_directory];
A3EAI_vehCrewRegroupComplete = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_vehCrewRegroupComplete.sqf",A3EAI_directory];
A3EAI_vehStartPatrol = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_vehStartPatrol.sqf",A3EAI_directory];
A3EAI_UAVStartPatrol = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_UAVStartPatrol.sqf",A3EAI_directory];
A3EAI_UAVDetection = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_UAVDetection.sqf",A3EAI_directory];
A3EAI_UGVStartPatrol = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_UGVStartPatrol.sqf",A3EAI_directory];
A3EAI_UGVDetection = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_UGVDetection.sqf",A3EAI_directory];
A3EAI_areaSearching = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_areaSearching.sqf",A3EAI_directory];
A3EAI_startHunting = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_startHunting.sqf",A3EAI_directory];
A3EAI_forceBehavior = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_forceBehavior.sqf",A3EAI_directory];
A3EAI_defensiveAggression = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_defensiveAggression.sqf",A3EAI_directory];

//A3EAI_unit_events
A3EAI_handle_death_UV = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handle_death_UV.sqf",A3EAI_directory];
A3EAI_handleDamageHeli = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDamageHeli.sqf",A3EAI_directory];
A3EAI_handleDamageVeh = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDamageVeh.sqf",A3EAI_directory];
A3EAI_handleDamageUnit = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDamageUnit.sqf",A3EAI_directory];
A3EAI_handleDamageUGV = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDamageUGV.sqf",A3EAI_directory];
A3EAI_handleDeath_air = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDeath_air.sqf",A3EAI_directory];
A3EAI_handleDeath_air_reinforce = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDeath_air_reinforce.sqf",A3EAI_directory];
A3EAI_handleDeath_aircrashed = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDeath_aircrashed.sqf",A3EAI_directory];
A3EAI_handleDeath_aircustom = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDeath_aircustom.sqf",A3EAI_directory];
A3EAI_handleDeath_dynamic = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDeath_dynamic.sqf",A3EAI_directory];
A3EAI_handleDeath_generic = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDeath_generic.sqf",A3EAI_directory];
A3EAI_handleDeath_land = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDeath_land.sqf",A3EAI_directory];
A3EAI_handleDeath_landcustom = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDeath_landcustom.sqf",A3EAI_directory];
A3EAI_handleDeath_random = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDeath_random.sqf",A3EAI_directory];
A3EAI_handleDeath_static = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDeath_static.sqf",A3EAI_directory];
A3EAI_handleDeath_staticcustom = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDeath_staticcustom.sqf",A3EAI_directory];
A3EAI_handleDeath_vehiclecrew = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDeath_vehiclecrew.sqf",A3EAI_directory];
A3EAI_handleDeathEvent = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDeathEvent.sqf",A3EAI_directory];
A3EAI_heliDestroyed = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_heliDestroyed.sqf",A3EAI_directory];
A3EAI_heliEvacuated = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_heliEvacuated.sqf",A3EAI_directory];
A3EAI_heliLanded = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_heliLanded.sqf",A3EAI_directory];
A3EAI_heliParaDrop = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_heliParaDrop.sqf",A3EAI_directory];
A3EAI_UAV_destroyed = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_UAV_destroyed.sqf",A3EAI_directory];
A3EAI_UGV_destroyed = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_UGV_destroyed.sqf",A3EAI_directory];
A3EAI_vehDestroyed = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_vehDestroyed.sqf",A3EAI_directory];
A3EAI_ejectParachute = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_ejectParachute.sqf",A3EAI_directory];

//A3EAI_unit_spawning
A3EAI_addRespawnQueue = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_addRespawnQueue.sqf",A3EAI_directory];
A3EAI_addVehicleGunners = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_addVehicleGunners.sqf",A3EAI_directory];
A3EAI_cancelDynamicSpawn = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_cancelDynamicSpawn.sqf",A3EAI_directory];
A3EAI_cancelRandomSpawn = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_cancelRandomSpawn.sqf",A3EAI_directory];
A3EAI_create_UV_unit = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_create_UV_unit.sqf",A3EAI_directory];
A3EAI_createCustomSpawn = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_createCustomSpawn.sqf",A3EAI_directory];
A3EAI_createUnit = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_createUnit.sqf",A3EAI_directory];
A3EAI_despawn_dynamic = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_despawn_dynamic.sqf",A3EAI_directory];
A3EAI_despawn_random = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_despawn_random.sqf",A3EAI_directory];
A3EAI_despawn_static = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_despawn_static.sqf",A3EAI_directory];
A3EAI_processRespawn = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_processRespawn.sqf",A3EAI_directory];
A3EAI_respawnGroup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_respawnGroup.sqf",A3EAI_directory];
A3EAI_setup_randomspawns = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_setup_randomspawns.sqf",A3EAI_directory];
A3EAI_spawn_reinforcement = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_spawn_reinforcement.sqf",A3EAI_directory];
A3EAI_spawn_UV_patrol = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_spawn_UV_patrol.sqf",A3EAI_directory];
A3EAI_spawnGroup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_spawnGroup.sqf",A3EAI_directory];
A3EAI_spawnInfantryCustom = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_spawnInfantryCustom.sqf",A3EAI_directory];
A3EAI_spawnUnits_dynamic = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_spawnUnits_dynamic.sqf",A3EAI_directory];
A3EAI_spawnUnits_random = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_spawnUnits_random.sqf",A3EAI_directory];
A3EAI_spawnUnits_static = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_spawnUnits_static.sqf",A3EAI_directory];
A3EAI_spawnVehicleCustom = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_spawnVehicleCustom.sqf",A3EAI_directory];
A3EAI_spawnVehiclePatrol = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_spawnVehiclePatrol.sqf",A3EAI_directory];
A3EAI_addVehicleGroup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_addVehicleGroup.sqf",A3EAI_directory];
A3EAI_addParaGroup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_addParaGroup.sqf",A3EAI_directory];
A3EAI_respawnAIVehicle = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_respawnAIVehicle.sqf",A3EAI_directory];
A3EAI_cleanupReinforcementGroup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_cleanupReinforcementGroup.sqf",A3EAI_directory];

//A3EAI_utilities
A3EAI_activateKryptoPickup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_activateKryptoPickup.sqf",A3EAI_directory];
A3EAI_addItem = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_addItem.sqf",A3EAI_directory];
A3EAI_addLandVehEH = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_addLandVehEH.sqf",A3EAI_directory];
A3EAI_addMapMarker = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_addMapMarker.sqf",A3EAI_directory];
A3EAI_addTempNVG = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_addTempNVG.sqf",A3EAI_directory];
A3EAI_addTemporaryWaypoint = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_addTemporaryWaypoint.sqf",A3EAI_directory];
A3EAI_addUAVEH = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_addUAVEH.sqf",A3EAI_directory];
A3EAI_addUGVEH = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_addUGVEH.sqf",A3EAI_directory];
A3EAI_addUnitEH = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_addUnitEH.sqf",A3EAI_directory];
A3EAI_addUVUnitEH = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_addUVUnitEH.sqf",A3EAI_directory];
A3EAI_addVehAirEH = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_addVehAirEH.sqf",A3EAI_directory];
A3EAI_chance = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_chance.sqf",A3EAI_directory];
A3EAI_checkClassname = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_checkClassname.sqf",A3EAI_directory];
A3EAI_checkIsWeapon = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_checkIsWeapon.sqf",A3EAI_directory];
A3EAI_checkInNoAggroArea = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_checkInNoAggroArea.sqf",A3EAI_directory];
A3EAI_clearVehicleCargo = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_clearVehicleCargo.sqf",A3EAI_directory];
A3EAI_countVehicleGunners = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_countVehicleGunners.sqf",A3EAI_directory];
A3EAI_createBlackListArea = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_createBlackListArea.sqf",A3EAI_directory];
A3EAI_createBlackListAreaDynamic = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_createBlackListAreaDynamic.sqf",A3EAI_directory];
A3EAI_createBlackListAreaRandom = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_createBlackListAreaRandom.sqf",A3EAI_directory];
A3EAI_createBlacklistAreaQueue = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_createBlacklistAreaQueue.sqf",A3EAI_directory];
A3EAI_createCustomInfantryQueue = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_createCustomInfantryQueue.sqf",A3EAI_directory];
A3EAI_createCustomInfantrySpawnQueue = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_createCustomInfantrySpawnQueue.sqf",A3EAI_directory];
A3EAI_createCustomVehicleQueue = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_createCustomVehicleQueue.sqf",A3EAI_directory];
A3EAI_createGroup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_createGroup.sqf",A3EAI_directory];
A3EAI_createInfantryQueue = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_createInfantryQueue.sqf",A3EAI_directory];
A3EAI_createNoAggroArea = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_createNoAggroArea.sqf",A3EAI_directory];
A3EAI_createRandomInfantrySpawnQueue = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_createRandomInfantrySpawnQueue.sqf",A3EAI_directory];
A3EAI_deleteGroup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_deleteGroup.sqf",A3EAI_directory];
A3EAI_deleteCustomSpawn = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_deleteCustomSpawn.sqf",A3EAI_directory];
A3EAI_findSpawnPos = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_findSpawnPos.sqf",A3EAI_directory];
A3EAI_fixStuckGroup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_fixStuckGroup.sqf",A3EAI_directory];
A3EAI_generateKryptoPickup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_generateKryptoPickup.sqf",A3EAI_directory];
A3EAI_getNoAggroStatus = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_getNoAggroStatus.sqf",A3EAI_directory];
A3EAI_getSafePosReflected = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_getSafePosReflected.sqf",A3EAI_directory];
A3EAI_getSpawnParams = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_getSpawnParams.sqf",A3EAI_directory];
A3EAI_getUnitLevel = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_getUnitLevel.sqf",A3EAI_directory];
A3EAI_getWeapon = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_getWeapon.sqf",A3EAI_directory];
A3EAI_hasLOS = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_hasLOS.sqf",A3EAI_directory];
A3EAI_initializeTrigger = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_initializeTrigger.sqf",A3EAI_directory];
A3EAI_initNoAggroStatus = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_initNoAggroStatus.sqf",A3EAI_directory];
A3EAI_initUVGroup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_initUVGroup.sqf",A3EAI_directory];
A3EAI_moveToPosAndDeleteWP = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_moveToPosAndDeleteWP.sqf",A3EAI_directory];
A3EAI_moveToPosAndPatrol = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_moveToPosAndPatrol.sqf",A3EAI_directory];
A3EAI_noAggroAreaToggle = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_noAggroAreaToggle.sqf",A3EAI_directory];
A3EAI_param = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_param.sqf",A3EAI_directory];
A3EAI_posInBuilding = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_posInBuilding.sqf",A3EAI_directory];
A3EAI_protectGroup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_protectGroup.sqf",A3EAI_directory];
A3EAI_protectObject = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_protectObject.sqf",A3EAI_directory];
A3EAI_purgeUnitGear = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_purgeUnitGear.sqf",A3EAI_directory];
A3EAI_radioSend = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_radioSend.sqf",A3EAI_directory];
A3EAI_randomizeVehicleColor = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_randomizeVehicleColor.sqf",A3EAI_directory];
A3EAI_reloadVehicleTurrets = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_reloadVehicleTurrets.sqf",A3EAI_directory];
A3EAI_removeExplosive = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_removeExplosive.sqf",A3EAI_directory];
A3EAI_returnNoAggroArea = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_returnNoAggroArea.sqf",A3EAI_directory];
A3EAI_secureVehicle = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_secureVehicle.sqf",A3EAI_directory];
A3EAI_sendKillMessage = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_sendKillMessage.sqf",A3EAI_directory];
A3EAI_setFirstWPPos = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_setFirstWPPos.sqf",A3EAI_directory];
A3EAI_setNoAggroStatus = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_setNoAggroStatus.sqf",A3EAI_directory];
A3EAI_setSkills = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_setSkills.sqf",A3EAI_directory];
A3EAI_setVehicleRegrouped = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_setVehicleRegrouped.sqf",A3EAI_directory];
A3EAI_updateSpawnCount = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_updateSpawnCount.sqf",A3EAI_directory];
A3EAI_updGroupCount = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_updGroupCount.sqf",A3EAI_directory];
A3EAI_selectRandom = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_selectRandom.sqf",A3EAI_directory];
A3EAI_setRandomWaypoint = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_setRandomWaypoint.sqf",A3EAI_directory];
A3EAI_getPosBetween = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_getPosBetween.sqf",A3EAI_directory];
A3EAI_debugMarkerLocation = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_debugMarkerLocation.sqf",A3EAI_directory];

//Group functions
A3EAI_getLocalFunctions = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_group_functions\A3EAI_getLocalFunctions.sqf",A3EAI_directory];
A3EAI_getAntistuckTime = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_group_functions\A3EAI_getAntistuckTime.sqf",A3EAI_directory];
A3EAI_setLoadoutVariables = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_group_functions\A3EAI_setLoadoutVariables.sqf",A3EAI_directory];
A3EAI_execEveryLoop_air = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_group_functions\A3EAI_execEveryLoop_air.sqf",A3EAI_directory];
A3EAI_execEveryLoop_infantry = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_group_functions\A3EAI_execEveryLoop_infantry.sqf",A3EAI_directory];
A3EAI_execEveryLoop_vehicle = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_group_functions\A3EAI_execEveryLoop_vehicle.sqf",A3EAI_directory];
A3EAI_execEveryLoop_ugv = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_group_functions\A3EAI_execEveryLoop_ugv.sqf",A3EAI_directory];
A3EAI_execEveryLoop_uav = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_group_functions\A3EAI_execEveryLoop_uav.sqf",A3EAI_directory];
A3EAI_checkGroupUnits = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_group_functions\A3EAI_checkGroupUnits.sqf",A3EAI_directory];
A3EAI_generateGroupLoot = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_group_functions\A3EAI_generateGroupLoot.sqf",A3EAI_directory];
A3EAI_checkAmmoFuel = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_group_functions\A3EAI_checkAmmoFuel.sqf",A3EAI_directory];
A3EAI_antistuck_air = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_group_functions\A3EAI_antistuck_air.sqf",A3EAI_directory];
A3EAI_antistuck_aircustom = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_group_functions\A3EAI_antistuck_aircustom.sqf",A3EAI_directory];
A3EAI_antistuck_generic = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_group_functions\A3EAI_antistuck_generic.sqf",A3EAI_directory];
A3EAI_antistuck_land = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_group_functions\A3EAI_antistuck_land.sqf",A3EAI_directory];
A3EAI_antistuck_uav = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_group_functions\A3EAI_antistuck_uav.sqf",A3EAI_directory];
A3EAI_antistuck_ugv = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_group_functions\A3EAI_antistuck_ugv.sqf",A3EAI_directory];
A3EAI_generateLootPool = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_group_functions\A3EAI_generateLootPool.sqf",A3EAI_directory];
A3EAI_generateLootOnDeath = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_group_functions\A3EAI_generateLootOnDeath.sqf",A3EAI_directory];
A3EAI_generateLoadout = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_group_functions\A3EAI_generateLoadout.sqf",A3EAI_directory];
A3EAI_addGroupManager = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_group_functions\A3EAI_addGroupManager.sqf",A3EAI_directory];

diag_log "[A3EAI] A3EAI functions compiled.";

true
