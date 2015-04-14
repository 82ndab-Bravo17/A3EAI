if (isNull _this) exitWith {};

_this addEventHandler ["Killed","_this call A3EAI_vehDestroyed"];
_this addEventHandler ["HandleDamage","_this call A3EAI_handleDamageVeh"];

/*
if (isDedicated) then {
	_this addEventHandler ["Local","(_this select 0) enableSimulation (_this select 1);"];
};
*/

true