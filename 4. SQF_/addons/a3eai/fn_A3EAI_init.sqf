if (hasInterface) exitWith {};

if (isDedicated) then {
	[] call compile preprocessFileLineNumbers "\a3eai\init\a3eai_initserver.sqf";
} else {
	[] call compile preprocessFileLineNumbers "\a3eai\init\a3eai_inithc.sqf";
};

