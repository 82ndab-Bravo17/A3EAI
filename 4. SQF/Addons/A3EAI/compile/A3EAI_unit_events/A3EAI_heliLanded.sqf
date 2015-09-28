#include "\A3EAI\globaldefines.hpp"

private ["_vehicle","_unitsAlive","_unitGroup","_vehiclePos"];

_vehicle = (_this select 0);
_unitGroup = _vehicle getVariable ["unitGroup",grpNull];

if (isNull _vehicle) exitWith {};
if (_vehicle getVariable ["vehicle_disabled",false]) exitWith {};

{_vehicle removeAllEventHandlers _x} count ["HandleDamage","GetOut","Killed","Hit"];
_vehicle setVariable ["vehicle_disabled",true];
if !((_unitGroup getVariable ["unitType",""]) isEqualTo "air_reinforce") then {_vehicle call A3EAI_respawnAIVehicle;};
if !(isNil {_unitGroup getVariable "dummyUnit"}) exitWith {};

_unitsAlive = {alive _x} count (units _unitGroup);
if (_unitsAlive > 0) then {
	if (isDedicated) then {
		[_unitGroup,_vehicle] call A3EAI_addVehicleGroup;
	} else {
		_vehiclePos = getPosATL _vehicle;
		_vehiclePos set [2,0];
		[_unitGroup,_vehiclePos] call A3EAI_createGroupTriggerObject;
		A3EAI_addVehicleGroup_PVS = [_unitGroup,_vehicle];
		publicVariableServer "A3EAI_addVehicleGroup_PVS";
		_unitGroup setVariable ["unitType","vehiclecrew"];
	};
	
	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Group %1 %2 landed at %3",_unitGroup,(typeOf _vehicle),mapGridPosition _vehicle];};
};
