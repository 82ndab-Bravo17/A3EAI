#include "\A3EAI\globaldefines.hpp"

if (isNull _this) exitWith {};

_this addEventHandler ["Killed","_this call A3EAI_vehDestroyed"];
_this addEventHandler ["HandleDamage","_this call A3EAI_handleDamageVeh"];

true