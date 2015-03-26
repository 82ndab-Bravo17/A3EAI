"A3EAI_transferGroup_PVC" addPublicVariableEventHandler {
	(_this select 1) call A3EAI_addNewGroup;
	diag_log format ["Debug: %1",_this];
};

"A3EAI_sendGroupTriggerVars_PVC" addPublicVariableEventHandler {
	_nul = (_this select 1) spawn A3EAI_setGroupTriggerVars;
	diag_log format ["Debug: %1",_this];
};

"A3EAI_updateGroupLoot_PVC" addPublicVariableEventHandler {
	(_this select 1) call A3EAI_updateGroupLootPoolHC;
	diag_log format ["Debug: %1",_this];
};

"A3EAI_sendHunterGroup_PVC" addPublicVariableEventHandler {
	(_this select 1) call A3EAI_addHunterGroup;
	diag_log format ["Debug: %1",_this];
};

"A3EAI_updateGroupSize_PVC" addPublicVariableEventHandler {
	(_this select 1) call A3EAI_updateGroupSizeHC;
	diag_log format ["Debug: %1",_this];
};

"A3EAI_upateReinforcePlaces_PVC" addPublicVariableEventHandler {
	(_this select 1) call A3EAI_updateReinforcePlacesHC;
	diag_log format ["Debug: %1",_this];
};

diag_log "Debug: A3EAI HC PVEHs loaded.";
