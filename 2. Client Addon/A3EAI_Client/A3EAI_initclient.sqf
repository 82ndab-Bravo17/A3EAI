if !(hasInterface) exitWith {};

#include "A3EAI_client_version.txt"

call compile preprocessFileLineNumbers "A3EAI_Client\A3EAI_client_config.sqf";

if (A3EAIC_radio) then {
	A3EAIC_lastRadioMessage = 0;
	"A3EAI_SMS" addPublicVariableEventHandler {
		_dialogueType = (_this select 1) select 0;
		_dialogueParams = (_this select 1) select 1;
		
		if ((diag_tickTime - A3EAIC_lastRadioMessage) > 5) then {
			_paramCount = (count _dialogueParams);
			_dialogueTextTemplate = missionNamespace getVariable [format ["A3EAIC_radioMessage%1",_dialogueType],""];
			_dialogueTextFormat = call {
				if (_paramCount isEqualTo 0) exitWith {
					_dialogueTextTemplate
				};
				if (_paramCount isEqualTo 1) exitWith {
					format [_dialogueTextTemplate,_dialogueParams select 0]
				};
				if (_paramCount isEqualTo 2) exitWith {
					format [_dialogueTextTemplate,_dialogueParams select 0,_dialogueParams select 1]
				};
				""
			};
			if !(_dialogueTextFormat isEqualTo "") then {
				systemChat _dialogueTextFormat;
				playSound [format ["UAV_0%1",(floor (random 5) + 1)],true];
				A3EAIC_lastRadioMessage = diag_tickTime;
			};
		};
	};
};

if (A3EAIC_deathMessages) then {
	"A3EAI_killMSG" addPublicVariableEventHandler {
		systemChat (format [A3EAIC_killMessage0,(_this select 1)]);
		//diag_log format ["A3EAI Debug: %1 was killed.",(_this select 1)];
	};
};

diag_log format ["[A3EAI] Initialized %1 version %2. Radio enabled: %3. Kill messages: %4.",A3EAI_CLIENT_TYPE,A3EAI_CLIENT_VERSION,A3EAIC_radio,A3EAIC_deathMessages];
