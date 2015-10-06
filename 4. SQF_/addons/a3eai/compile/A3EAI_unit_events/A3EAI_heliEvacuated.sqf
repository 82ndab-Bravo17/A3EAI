#include "\A3EAI\globaldefines.hpp"

private ["_vehicle","_vehiclePos","_unitGroup","_driver"];

_vehicle = (_this select 0);
_unitGroup = _vehicle getVariable ["unitGroup",grpNull];

if (_vehicle getVariable ["vehicle_disabled",false]) exitWith {};

{_vehicle removeAllEventHandlers _x} count ["HandleDamage","GetOut","Killed","Hit"];
_vehicle setVariable ["vehicle_disabled",true];
if !((_unitGroup getVariable ["unitType",""]) isEqualTo "air_reinforce") then {_vehicle call A3EAI_respawnAIVehicle;};
_vehiclePos = getPosATL _vehicle;

if (isNil {_unitGroup getVariable "dummyUnit"}) then {
	private ["_unitsAlive","_trigger","_unitLevel","_units","_waypointCount"];
	_unitLevel = _unitGroup getVariable ["unitLevel",1];
	_units = (units _unitGroup);
	if (!(surfaceIsWater _vehiclePos) && {(_vehiclePos select 2) > PARACHUTE_HEIGHT_REQUIRED}) then {
		_unitsAlive = {
			if (alive _x) then {
				_x call A3EAI_ejectParachute;
				true
			} else {
				0 = [_x,_unitLevel] spawn A3EAI_generateLootOnDeath;
				false
			};
		} count _units;
		if (_unitsAlive > 0) then {
			if (isDedicated) then {
				[_unitGroup,_vehicle] call A3EAI_addVehicleGroup;
			} else {
				_vehiclePos set [2,0];
				[_unitGroup,_vehiclePos] call A3EAI_createGroupTriggerObject;
				A3EAI_addVehicleGroup_PVS = [_unitGroup,_vehicle];
				publicVariableServer "A3EAI_addVehicleGroup_PVS";
				_unitGroup setVariable ["unitType","vehiclecrew"];
				
			};
		};
		if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: AI %1 group %2 parachuted with %3 surviving units.",(typeOf _vehicle),_unitGroup,_unitsAlive];};
	} else {
		_unitGroup setVariable ["unitType","aircrashed"];
		{
			_x call A3EAI_ejectParachute;
			_nul = [_x,objNull] call A3EAI_handleDeathEvent;
			0 = [_x,_unitLevel] spawn A3EAI_generateLootOnDeath;
		} forEach _units;
		_unitGroup setVariable ["GroupSize",-1];
		if !(isDedicated) then {
			A3EAI_updateGroupSize_PVS = [_unitGroup,-1];
			publicVariableServer "A3EAI_updateGroupSize_PVS";
		};
		if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: AI %1 group %2 parachuted with no surviving units.",(typeOf _vehicle),_unitGroup];};
	};
} else {
	_unitGroup setVariable ["GroupSize",-1];
	if !(isDedicated) then {
		A3EAI_updateGroupSize_PVS = [_unitGroup,-1];
		publicVariableServer "A3EAI_updateGroupSize_PVS";
	};
	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: %1 executed on empty AI %2 group %3.",__FILE__,(typeOf _vehicle),_unitGroup];};
};

true
