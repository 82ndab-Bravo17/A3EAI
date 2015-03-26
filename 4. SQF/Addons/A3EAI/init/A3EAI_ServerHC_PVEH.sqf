"A3EAI_respawnGroup_PVS" addPublicVariableEventHandler {(_this select 1) call A3EAI_addRespawnQueue;diag_log format ["Debug: %1",_this];};
"A3EAI_killMsg_PVS" addPublicVariableEventHandler {(_this select 1) spawn A3EAI_sendKillMessage;diag_log format ["Debug: %1",_this];};
"A3EAI_despawnRandomGroup_PVS" addPublicVariableEventHandler {private ["_trigger"];_trigger = (_this select 1) getVariable ["trigger",objNull];[_trigger,true] spawn A3EAI_despawn_random;diag_log format ["Debug: %1",_this];};
"A3EAI_despawnDynamicGroup_PVS" addPublicVariableEventHandler {private ["_trigger"];_trigger = (_this select 1) getVariable ["trigger",objNull];[_trigger,true] spawn A3EAI_despawn_dynamic;diag_log format ["Debug: %1",_this];};
"A3EAI_respawnVehicle_PVS" addPublicVariableEventHandler {(_this select 1) call A3EAI_respawnAIVehicle;diag_log format ["Debug: %1",_this];};
"A3EAI_addVehicleGroup_PVS" addPublicVariableEventHandler {(_this select 1) call A3EAI_addVehicleGroup;diag_log format ["Debug: %1",_this];};
"A3EAI_addParaGroup_PVS" addPublicVariableEventHandler {(_this select 1) call A3EAI_addParaGroup;diag_log format ["Debug: %1",_this];};
"A3EAI_transferGroup_PVS" addPublicVariableEventHandler {(_this select 1) call A3EAI_HCGroupToServer;diag_log format ["Debug: %1",_this];};
"A3EAI_SMS_PVS" addPublicVariableEventHandler {(_this select 1) call A3EAI_radioSend;diag_log format ["Debug: %1",_this];};
"A3EAI_getGroupTriggerVars_PVS" addPublicVariableEventHandler {(_this select 1) spawn A3EAI_getGroupTriggerVars;diag_log format ["Debug: %1",_this];};
"A3EAI_setDeathTime_PVS" addPublicVariableEventHandler {(_this select 1) setVariable ["A3EAI_deathTime",diag_tickTime];diag_log format ["Debug: %1",_this];};
"A3EAI_updateGroupLoot_PVS" addPublicVariableEventHandler {(_this select 1) call A3EAI_updateGroupLootPool;diag_log format ["Debug: %1",_this];};
"A3EAI_protectGroup_PVS" addPublicVariableEventHandler {(_this select 1) call A3EAI_protectRemoteGroup;diag_log format ["Debug: %1",_this];};
"A3EAI_updateGroupSize_PVS" addPublicVariableEventHandler {(_this select 1) call A3EAI_updateGroupSizeServer;diag_log format ["Debug: %1",_this];};
"A3EAI_HCLogin_PVS" addPublicVariableEventHandler {(_this select 1) call A3EAI_HCListener;diag_log format ["Debug: %1",_this];};
"A3EAI_upateReinforcePlaces_PVS" addPublicVariableEventHandler {(_this select 1) call A3EAI_updateReinforcePlaces;diag_log format ["Debug: %1",_this];};
"A3EAI_setPermaDeleteSpawn_PVS" addPublicVariableEventHandler {(_this select 1) setVariable ["permadelete",true];diag_log format ["Debug: %1",_this];};

diag_log "[A3EAI] Serverside PVEHs loaded.";
