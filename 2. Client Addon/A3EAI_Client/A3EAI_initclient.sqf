if (hasInterface) then {
	#include "A3EAI_client_version.txt"

	call compile preprocessFileLineNumbers "A3EAI_Client\A3EAI_client_config.sqf";
	call compile preprocessFileLineNumbers "A3EAI_Client\A3EAI_client_verifySettings.sqf";
	call compile preprocessFileLineNumbers "A3EAI_Client\A3EAI_client_functions.sqf";
		
	if (A3EAI_client_radio) then {
		"A3EAI_SMS" addPublicVariableEventHandler {(_this select 1) call A3EAI_client_radioMessage; diag_log _this;};
	};

	if (A3EAI_client_deathMessages) then {
		"A3EAI_killMSG" addPublicVariableEventHandler {(_this select 1) call A3EAI_client_killMessage; diag_log _this;};
	};

	diag_log format ["[A3EAI] Initialized %1 version %2. Radio enabled: %3. Kill messages: %4.",A3EAI_CLIENT_TYPE,A3EAI_CLIENT_VERSION,A3EAI_client_radio,A3EAI_client_deathMessages];
};
