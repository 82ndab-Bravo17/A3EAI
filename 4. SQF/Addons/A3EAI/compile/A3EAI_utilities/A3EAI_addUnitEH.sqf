if (isNull _this) exitWith {};

_this addEventHandler ["Killed","_this call A3EAI_handleDeathEvent;"];
_this addEventHandler ["HandleDamage","_this call A3EAI_handleDamageUnit;"];

/*
if (isDedicated) then {
	_this addEventHandler ["Local","(_this select 0) enableSimulation (_this select 1);"];
};
*/

_this setVariable ["bodyName",(name _this)];

true