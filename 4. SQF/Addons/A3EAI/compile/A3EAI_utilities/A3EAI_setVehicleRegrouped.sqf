private ["_unitGroup"];

_unitGroup = _this;

_unitGroup setVariable ["regrouped",true];
if !(isDedicated) then {
	A3EAI_setVehicleRegrouped_PVS = _unitGroup;
	publicVariableServer "A3EAI_setVehicleRegrouped_PVS";
};

true