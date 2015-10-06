#include "\A3EAI\globaldefines.hpp"

if (isNull _this) exitWith {};

_this addEventHandler ["Killed","_this call A3EAI_UAV_destroyed"];

if (A3EAI_detectOnlyUAVs) then {
	_this addEventHandler ["Hit","_this call A3EAI_defensiveAggression"];
};

true