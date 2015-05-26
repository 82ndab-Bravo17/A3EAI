private ["_vehicle","_trigger","_pos","_unitsAlive","_unitGroup","_waypointCount"];

_vehicle = (_this select 0);
_unitGroup = _vehicle getVariable ["unitGroup",grpNull];

if (isNull _vehicle) exitWith {};
if (_vehicle getVariable ["vehicle_disabled",false]) exitWith {
	if ((_unitGroup getVariable ["unitType",""]) isEqualTo "air_reinforce") then {
		//diag_log format ["Debug: %1",__FILE__];
		
		_unitGroup setVariable ["GroupSize",-1];
		if !(isDedicated) then {
			A3EAI_updateGroupSize_PVS = [_unitGroup,-1];
			publicVariableServer "A3EAI_updateGroupSize_PVS";
		};
	};
	false
};

{_vehicle removeAllEventHandlers _x} count ["HandleDamage","GetOut","Killed"];
_vehicle setVariable ["vehicle_disabled",true];
_vehicle call A3EAI_respawnAIVehicle;
if !(isNil {_unitGroup getVariable "dummyUnit"}) exitWith {};

_unitsAlive = {alive _x} count (units _unitGroup);
if (_unitsAlive > 0) then {
	//Convert helicrew units to ground units
	{
		if (alive _x) then {
			if !(canMove _x) then {_x setHit["legs",0]};
			unassignVehicle _x;
		};
	} count (units _unitGroup);
	for "_i" from ((count (waypoints _unitGroup)) - 1) to 0 step -1 do {
		deleteWaypoint [_unitGroup,_i];
	};

	_pos = getPosATL _vehicle;
	_pos set [2,0];
	0 = [_unitGroup,_pos,75] spawn A3EAI_BIN_taskPatrol;

	if (isDedicated) then {
		[_unitGroup,_vehicle] call A3EAI_addVehicleGroup;
	} else {
		A3EAI_addVehicleGroup_PVS = [_unitGroup,_vehicle];
		publicVariableServer "A3EAI_addVehicleGroup_PVS";
		_unitGroup setVariable ["unitType","vehiclecrew"];
	};

	if ((behaviour (leader _unitGroup)) isEqualTo "CARELESS") then {[_unitGroup,"Behavior_Reset"] call A3EAI_forceBehavior};
	if ((combatMode _unitGroup) isEqualTo "BLUE") then {_unitGroup setCombatMode "YELLOW"};

	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Group %1 %2 landed at %3",_unitGroup,(typeOf _vehicle),mapGridPosition _vehicle];};
};
