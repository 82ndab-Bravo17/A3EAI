if (hasInterface) exitWith {};

A3EAI_devOptions = [];
A3EAI_EpochHiveDir = "@epochhive";

if (isDedicated) then {
	[] call compile preprocessFileLineNumbers "\a3eai\init\a3eai_initserver.sqf";
} else {
	[] call compile preprocessFileLineNumbers "\a3eai\init\a3eai_inithc.sqf";
};

