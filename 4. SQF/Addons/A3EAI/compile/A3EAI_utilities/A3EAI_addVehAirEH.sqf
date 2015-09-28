#include "\A3EAI\globaldefines.hpp"

if (isNull _this) exitWith {};

if (isNil {_this getVariable "durability"}) then {_this setVariable ["durability",[0,0,0,0]];};
_this addEventHandler ["Killed","_this call A3EAI_heliDestroyed"];
_this addEventHandler ["GetOut","_this call A3EAI_heliLanded"];
_this addEventHandler ["HandleDamage","_this call A3EAI_handleDamageHeli"];

true