#include "\A3EAI\globaldefines.hpp"

if (isNull _this) exitWith {};

_this addEventHandler ["Killed","_this call A3EAI_handleDeathEvent;"];
_this addEventHandler ["HandleDamage","_this call A3EAI_handleDamageUnit;"];

_this setVariable ["bodyName",(name _this)];

true