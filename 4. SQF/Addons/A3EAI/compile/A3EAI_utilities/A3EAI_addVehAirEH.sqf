if (isNull _this) exitWith {};

_this setVariable ["durability",[0,0,0]];	//[structural, engine, tail rotor]
_this addEventHandler ["Killed","_this call A3EAI_heliDestroyed"];
_this addEventHandler ["GetOut","_this call A3EAI_heliLanded"];
_this addEventHandler ["HandleDamage","_this call A3EAI_handleDamageHeli"];

/*
if (isDedicated) then {
	_this addEventHandler ["Local","(_this select 0) enableSimulation (_this select 1);"];
};
*/

true