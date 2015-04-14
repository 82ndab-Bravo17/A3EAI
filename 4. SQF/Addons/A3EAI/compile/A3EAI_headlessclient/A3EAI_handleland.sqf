private ["_unitGroup", "_unitLevel", "_trigger", "_unitType", "_groupSize","_vehicle"];

_unitGroup = _this;

_unitLevel = _unitGroup getVariable ["unitLevel",1];
_unitType = _unitGroup getVariable ["unitType","unknown"];
_groupSize = _unitGroup getVariable ["GroupSize",-1];

_vehicle = assignedVehicle (leader _unitGroup);
_unitGroup setVariable ["assignedVehicle",_vehicle];
(assignedDriver _vehicle) setVariable ["isDriver",true];
_vehicle call A3EAI_addLandVehEH;
_vehicle call A3EAI_secureVehicle;
_vehicle setVariable ["unitGroup",_unitGroup];

if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Group %1 (Level: %2): %3, %4, %5",_unitGroup,_unitLevel,_vehicle,_unitType,_groupSize];};

true