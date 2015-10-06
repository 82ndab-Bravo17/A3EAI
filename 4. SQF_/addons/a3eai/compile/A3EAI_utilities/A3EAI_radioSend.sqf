#include "\A3EAI\globaldefines.hpp"

A3EAI_SMS = (_this select 1);

if (isDedicated) then {
	(owner (_this select 0)) publicVariableClient "A3EAI_SMS";
} else {
	A3EAI_SMS_PVS = [(_this select 0),A3EAI_SMS];
	publicVariableServer "A3EAI_SMS_PVS";
};

true