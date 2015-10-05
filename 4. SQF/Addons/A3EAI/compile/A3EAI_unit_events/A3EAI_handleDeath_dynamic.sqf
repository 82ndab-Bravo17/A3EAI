#include "\A3EAI\globaldefines.hpp"

private ["_victim","_killer","_groupIsEmpty","_trigger","_unitGroup"];

_victim = _this select 0;
_killer = _this select 1;
_unitGroup = _this select 2;
_groupIsEmpty = _this select 3;

if (_groupIsEmpty) then {
	if (isDedicated) then {
		_trigger = _unitGroup getVariable ["trigger",A3EAI_defaultTrigger];
		[_trigger,true] spawn A3EAI_despawn_dynamic;	//force despawning even if players are present in trigger area.
	} else {
		A3EAI_despawnDynamicGroup_PVS = _unitGroup;
		publicVariableServer "A3EAI_despawnDynamicGroup_PVS";
	};
} else {
	if ((A3EAI_enableFindKiller) && {(combatMode _unitGroup) isEqualTo "YELLOW"})  then {
		0 = [_killer,_unitGroup] spawn A3EAI_huntKiller;
		if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Killer-searching mode triggered for AI group %1.",_unitGroup];};
	};	
};

true
