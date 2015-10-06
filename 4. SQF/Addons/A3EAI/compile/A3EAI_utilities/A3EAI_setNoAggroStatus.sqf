#include "\A3EAI\globaldefines.hpp"

private ["_unitGroup","_status"];

_unitGroup = _this select 0;
_status = _this select 1;

_unitGroup setVariable ["NoAggroStatus",_status];

//Synchronize aggro status between dedicated and HC.
if (isDedicated) then {
	if (A3EAI_HCIsConnected) then {
		A3EAI_setNoAggroStatus_PVC = [_unitGroup,_status];
		A3EAI_HCObjectOwnerID publicVariableClient "A3EAI_setNoAggroStatus_PVC";
	};
} else {
	A3EAI_setNoAggroStatus_PVS = [_unitGroup,_status];
	publicVariableServer "A3EAI_setNoAggroStatus_PVS";
};

_status
