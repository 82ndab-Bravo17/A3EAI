if (hasInterface) exitWith {};

if (isDedicated) then {
	[] call compile preprocessFileLineNumbers "\A3EAI\init\A3EAI_initserver.sqf";
} else {
	[] call compile preprocessFileLineNumbers "\A3EAI\init\A3EAI_initHC.sqf";
};

