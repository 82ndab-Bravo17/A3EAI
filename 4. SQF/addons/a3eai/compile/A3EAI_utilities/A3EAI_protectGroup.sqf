#include "\A3EAI\globaldefines.hpp"

private ["_dummy"]; //_this = group
	
_dummy = _this createUnit ["Logic",[0,0,0],[],0,"FORM"];
[_dummy] joinSilent _this;
_this setVariable ["dummyUnit",_dummy];
if !(isDedicated) then {
	A3EAI_protectGroup_PVS = [_unitGroup,_dummy];
	publicVariableServer "A3EAI_protectGroup_PVS";
};

if (A3EAI_debugLevel > 1) then {diag_log format["A3EAI Debug: Spawned 1 dummy AI unit to preserve group %1.",_this];};

_dummy