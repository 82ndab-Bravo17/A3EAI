_startTime = diag_tickTime;

if (A3EAI_HC_serverResponse isEqualTo []) exitWith {};

{
	_variableName 	= _x select 0;
	_variableValue 	= _x select 1;
	
	missionNamespace setVariable [format ["A3EAI_%1",_variableName],_variableValue];
	diag_log format ["Debug: %1:%2",_variableName,_variableValue];
} forEach A3EAI_HC_serverResponse;

diag_log format ["[A3EAI] Loaded all A3EAI settings in %1 seconds.",(diag_tickTime - _startTime)];

true
