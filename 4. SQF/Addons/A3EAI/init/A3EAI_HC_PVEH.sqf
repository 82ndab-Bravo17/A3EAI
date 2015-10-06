"A3EAI_transferGroup_PVC" addPublicVariableEventHandler {(_this select 1) call A3EAI_addNewGroup;diag_log format ["Debug: %1",_this];};
"A3EAI_sendGroupTriggerVars_PVC" addPublicVariableEventHandler {_nul = (_this select 1) spawn A3EAI_setGroupTriggerVars;diag_log format ["Debug: %1",_this];};
"A3EAI_updateGroupLoot_PVC" addPublicVariableEventHandler {(_this select 1) call A3EAI_updateGroupLootPoolHC;diag_log format ["Debug: %1",_this];};
"A3EAI_sendHunterGroup_PVC" addPublicVariableEventHandler {(_this select 1) call A3EAI_addHunterGroup;diag_log format ["Debug: %1",_this];};
"A3EAI_updateGroupSize_PVC" addPublicVariableEventHandler {(_this select 1) call A3EAI_updateGroupSizeHC;diag_log format ["Debug: %1",_this];};
"A3EAI_setCurrentWaypoint_PVC" addPublicVariableEventHandler {(_this select 1) call A3EAI_setCurrentWaypointHC;diag_log format ["Debug: %1",_this];};
"A3EAI_cleanupReinforcement_PVC" addPublicVariableEventHandler {(_this select 1) spawn A3EAI_cleanupReinforcementHC;diag_log format ["Debug: %1",_this];};
"A3EAI_setBehavior_PVC" addPublicVariableEventHandler {(_this select 1) call A3EAI_setBehaviorHC;diag_log format ["Debug: %1",_this];};

diag_log "[A3EAI] A3EAI HC PVEHs loaded.";

true
