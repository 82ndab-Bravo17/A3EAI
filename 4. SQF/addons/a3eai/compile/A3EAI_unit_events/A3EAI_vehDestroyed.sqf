#include "\A3EAI\globaldefines.hpp"

private ["_vehicle","_unitGroup","_unitsAlive","_vehiclePos"];

_vehicle = (_this select 0);

if (isNull _vehicle) exitWith {};
if (_vehicle getVariable ["vehicle_disabled",false]) exitWith {};
_vehicle setVariable ["vehicle_disabled",true];
{_vehicle removeAllEventHandlers _x} count ["Killed","HandleDamage","GetOut","Fired","Local","Hit"];
_unitGroup = _vehicle getVariable ["unitGroup",grpNull];
_vehicle call A3EAI_respawnAIVehicle;
if !(isNil {_unitGroup getVariable "dummyUnit"}) exitWith {};

_unitsAlive = {alive _x} count (units _unitGroup);

if (_unitsAlive > 0) then {
	{
		if !((gunner _vehicle) isEqualTo _x) then {
			unassignVehicle _x;
		};
	} forEach (units _unitGroup);
	(units _unitGroup) allowGetIn false;
	
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
	
	if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: AI land vehicle patrol group %1 was converted to vehiclecrew type.",_unitGroup];};
} else {
	_unitGroup setVariable ["GroupSize",-1];
	if !(isDedicated) then {
		A3EAI_updateGroupSize_PVS = [_unitGroup,-1];
		publicVariableServer "A3EAI_updateGroupSize_PVS";
	};
};

if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Group %1 %2 destroyed at %3",_unitGroup,(typeOf _vehicle),mapGridPosition _vehicle];};
