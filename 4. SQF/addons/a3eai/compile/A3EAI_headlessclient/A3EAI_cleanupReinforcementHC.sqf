#include "\A3EAI\globaldefines.hpp"

private ["_unitGroup", "_vehicle"];

_unitGroup = _this select 0;
_vehicle = _this select 1;

{_vehicle removeAllEventHandlers _x} count ["Killed","HandleDamage","GetIn","GetOut","Fired","Local","Hit"];
_unitGroup setVariable ["GroupSize",-1];

if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Releasing ownership of reinforcement group %1 to server.",_unitGroup];};

true
