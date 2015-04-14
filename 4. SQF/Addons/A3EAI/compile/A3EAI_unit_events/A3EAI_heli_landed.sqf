private ["_vehicle","_trigger","_pos","_unitsAlive","_unitGroup","_waypointCount"];

_vehicle = (_this select 0);

if (_vehicle getVariable ["heli_disabled",false]) exitWith {};
_vehicle setVariable ["heli_disabled",true];
{_vehicle removeAllEventHandlers _x} count ["HandleDamage","GetOut","Killed"];
_unitGroup = _vehicle getVariable ["unitGroup",grpNull];
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
		_unitGroup setVariable ["unitType","static"];
	};

	if ((behaviour (leader _unitGroup)) isEqualTo "CARELESS") then {[_unitGroup,"IgnoreEnemies_Undo"] call A3EAI_forceBehavior};
	if ((combatMode _unitGroup) isEqualTo "BLUE") then {_unitGroup setCombatMode "YELLOW"};

	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Group %1 %2 landed at %3",_unitGroup,(typeOf _vehicle),mapGridPosition _vehicle];};
};
