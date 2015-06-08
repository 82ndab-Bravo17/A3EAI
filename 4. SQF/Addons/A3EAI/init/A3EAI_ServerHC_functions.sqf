diag_log "[A3EAI] Compiling A3EAI HC functions.";

A3EAI_transferGroupToHC = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient_server\A3EAI_transferGroupToHC.sqf",A3EAI_directory];
A3EAI_HCGroupToServer = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient_server\A3EAI_transferGroupToServer.sqf",A3EAI_directory];
A3EAI_getGroupTriggerVars = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient_server\A3EAI_getGroupTriggerVars.sqf",A3EAI_directory];
A3EAI_updateGroupLootPool = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient_server\A3EAI_updateGroupLootPool.sqf",A3EAI_directory];
A3EAI_HCListener = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient_server\A3EAI_HCListener.sqf",A3EAI_directory];
A3EAI_updateGroupSizeServer = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient_server\A3EAI_updateGroupSizeServer.sqf",A3EAI_directory];
A3EAI_registerDeath = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_headlessclient_server\A3EAI_registerDeath.sqf",A3EAI_directory];

A3EAI_protectRemoteGroup = compileFinal '
	private ["_unitGroup","_dummy"];
	_unitGroup = _this select 0;
	_dummy = _this select 1;
	_unitGroup setVariable ["dummyUnit",_dummy];
	true
';

diag_log "[A3EAI] A3EAI HC functions compiled.";