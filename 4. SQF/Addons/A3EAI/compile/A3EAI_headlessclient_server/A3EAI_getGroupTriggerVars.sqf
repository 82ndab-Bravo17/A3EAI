#include "\A3EAI\globaldefines.hpp"

private ["_unitGroup", "_trigger", "_triggerVars", "_value"];

_unitGroup = _this;
_trigger = _unitGroup getVariable ["trigger",A3EAI_defaultTrigger];
_triggerVars = [_unitGroup];

{
	_value = _trigger getVariable [_x select 0,_x select 1];
	_triggerVars pushBack _value;
} forEach [
	["GroupArray",[]],
	["patrolDist",100],
	["unitLevel",1],
	["unitLevelEffective",1],
	["maxUnits",[0,0]],
	["spawnChance",0],
	["spawnType",""],
	["respawn",true],
	["permadelete",false]
];

A3EAI_sendGroupTriggerVars_PVC = _triggerVars;
A3EAI_HCObjectOwnerID publicVariableClient "A3EAI_sendGroupTriggerVars_PVC";

if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Retrieved group %1 trigger variables: %2",_unitGroup,_triggerVars];};
