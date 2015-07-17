A3EAI_setGroupTriggerVars = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_setGroupTriggerVars.sqf",A3EAI_directory]; 
A3EAI_handlestatic = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_handlestatic.sqf",A3EAI_directory]; 
A3EAI_handlestaticcustom = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_handlestaticcustom.sqf",A3EAI_directory]; 
A3EAI_handleland = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_handleland.sqf",A3EAI_directory]; 
A3EAI_handleair = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_handleair.sqf",A3EAI_directory]; 
A3EAI_handleaircustom = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_handleaircustom.sqf",A3EAI_directory]; 
A3EAI_handleair_reinforce = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_handleair_reinforce.sqf",A3EAI_directory];
A3EAI_handlelandcustom = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_handlelandcustom.sqf",A3EAI_directory]; 
A3EAI_handledynamic = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_handledynamic.sqf",A3EAI_directory]; 
A3EAI_handlerandom = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_handlerandom.sqf",A3EAI_directory]; 
A3EAI_handleuav = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_handleuav.sqf",A3EAI_directory]; 
A3EAI_handleugv = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_handleugv.sqf",A3EAI_directory]; 
A3EAI_handlevehiclecrew = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_handlevehiclecrew.sqf",A3EAI_directory]; 
A3EAI_addNewGroup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_addNewGroup.sqf",A3EAI_directory]; 
A3EAI_addHunterGroup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_addHunterGroup.sqf",A3EAI_directory]; 
A3EAI_updateGroupSizeHC = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_updateGroupSizeHC.sqf",A3EAI_directory];
A3EAI_airReinforcementDetection = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_airReinforcementDetection.sqf",A3EAI_directory]; 
A3EAI_cleanupReinforcementHC = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_cleanupReinforcementHC.sqf",A3EAI_directory]; 
A3EAI_setLoadoutVariables_HC = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_setLoadoutVariables_HC.sqf",A3EAI_directory];
A3EAI_createGroupTriggerObject = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient\A3EAI_createGroupTriggerObject.sqf",A3EAI_directory];

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
	
	if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Updated group %1 loot pool to %2.",_unitGroup,_lootPool];};
	
	true
';

A3EAI_setCurrentWaypointHC = compileFinal '
	private ["_unitGroup","_waypointIndex"];
	_unitGroup = _this select 0;
	_waypointIndex = _this select 1;
	_unitGroup setCurrentWaypoint [_unitGroup,_waypointIndex];
	true
';

A3EAI_setBehaviorHC = compileFinal '
	private ["_unitGroup","_mode"];
	_unitGroup = _this select 0;
	_mode = _this select 1;
	
	call {
		if (_mode isEqualTo 0) exitWith {
			_unitGroup setBehaviour "CARELESS";
			{_x doWatch objNull} forEach (units _unitGroup);
			_unitGroup setVariable ["EnemiesIgnored",true];
			true
		};
		if (_mode isEqualTo 1) exitWith {
			_unitGroup setBehaviour "AWARE";
			_unitGroup setVariable ["EnemiesIgnored",false];
			true
		};
		false
	};
';

diag_log "[A3EAI] A3EAI HC functions loaded.";
