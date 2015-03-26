A3EAI_setGroupTriggerVars = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_setGroupTriggerVars.sqf",A3EAI_directory]; 
A3EAI_handlestatic = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_handlestatic.sqf",A3EAI_directory]; 
A3EAI_handleland = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_handleland.sqf",A3EAI_directory]; 
A3EAI_handleair = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_handleair.sqf",A3EAI_directory]; 
A3EAI_handleaircustom = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_handleaircustom.sqf",A3EAI_directory]; 
A3EAI_handlelandcustom = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_handlelandcustom.sqf",A3EAI_directory]; 
A3EAI_handledynamic = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_handledynamic.sqf",A3EAI_directory]; 
A3EAI_handlerandom = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_handlerandom.sqf",A3EAI_directory]; 
A3EAI_addNewGroup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_addNewGroup.sqf",A3EAI_directory]; 
A3EAI_addHunterGroup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_addHunterGroup.sqf",A3EAI_directory]; 
A3EAI_updateGroupSizeHC = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_updateGroupSizeHC.sqf",A3EAI_directory]; 

A3EAI_requestGroupVars = compileFinal '
	A3EAI_getGroupTriggerVars_PVS = _this;
	publicVariableServer "A3EAI_getGroupTriggerVars_PVS";
	true
';

A3EAI_updateServerLoot = compileFinal '
	A3EAI_updateGroupLoot_PVS = _this;
	publicVariableServer "A3EAI_updateGroupLoot_PVS";
	true
';

A3EAI_updateGroupLootPoolHC = compileFinal '
	private ["_unitGroup","_lootPool"];
	_unitGroup = _this select 0;
	_lootPool = _this select 1;
	
	_unitGroup setVariable ["LootPool",_lootPool];
	
	if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Updated group %1 loot pool to %2.",_unitGroup,_lootPool];};
	
	true
';

A3EAI_updateReinforcePlacesHC = compileFinal '
	private ["_trigger","_targetPlayer"];
	_trigger = _this select 0; //dynamic spawn trigger object
	_targetPlayer = _this select 1; //target player object
	if (_trigger isKindOf "EmptyDetector") then {
		_trigger setVariable ["targetplayer",_targetPlayer];
		A3EAI_reinforcePlaces pushBack _trigger;
	};
	
	if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Received new dynamic trigger %1 from server with target player %2.",_trigger,_targetPlayer];};
	
	true
';

diag_log "Debug: A3EAI HC functions loaded.";
