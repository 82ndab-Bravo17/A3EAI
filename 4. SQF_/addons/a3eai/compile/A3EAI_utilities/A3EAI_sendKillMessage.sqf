#include "\A3EAI\globaldefines.hpp"

private ["_killer","_victim"];
_killer = _this select 0;
_victim = _this select 1;

if (isDedicated) then {
	_victimName = _victim getVariable ["bodyName","Bandit"];
	{
		if (isPlayer _x) then {
			A3EAI_killMSG = _victimName;
			(owner _x) publicVariableClient "A3EAI_killMSG";
		};
	} count (crew _killer);
} else {
	A3EAI_killMsg_PVS = [_killer,_victim];
	publicVariableServer "A3EAI_killMsg_PVS";
};