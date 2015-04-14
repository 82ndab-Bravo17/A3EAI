private ["_vehicle","_vehPos","_unitGroup"];

_vehicle = (_this select 0);

if (_vehicle getVariable ["heli_disabled",false]) exitWith {false};
_vehicle setVariable ["heli_disabled",true];
{_vehicle removeAllEventHandlers _x} count ["HandleDamage","GetOut","Killed"];
_unitGroup = _vehicle getVariable ["unitGroup",grpNull];
_vehicle call A3EAI_respawnAIVehicle;
_vehPos = getPosATL _vehicle;

if (isNil {_unitGroup getVariable "dummyUnit"}) then {
	private ["_unitsAlive","_trigger","_unitLevel","_units","_waypointCount"];
	_unitLevel = _unitGroup getVariable ["unitLevel",1];
	_units = (units _unitGroup);
	if (!(surfaceIsWater _vehPos) && {(_vehPos select 2) > 50}) then {
		_unitsAlive = {
			if (alive _x) then {
				unassignVehicle _x;
				_x action ["eject",_vehicle];
				true
			} else {
				0 = [_x,_unitLevel] spawn A3EAI_generateLoot;
				false
			};
		} count _units;
		if !(_unitsAlive isEqualTo 0) then {
			for "_i" from ((count (waypoints _unitGroup)) - 1) to 0 step -1 do {
				deleteWaypoint [_unitGroup,_i];
			};
	
			_vehPos set [2,0];
			0 = [_unitGroup,_vehPos,75] spawn A3EAI_BIN_taskPatrol;
			
			if (isDedicated) then {
				[_unitGroup,_vehicle] call A3EAI_addVehicleGroup;
			} else {
				A3EAI_addVehicleGroup_PVS = [_unitGroup,_vehicle];
				publicVariableServer "A3EAI_addVehicleGroup_PVS";
				_unitGroup setVariable ["unitType","static"];
				
			};
			
			if ((behaviour (leader _unitGroup)) isEqualTo "CARELESS") then {[_unitGroup,"IgnoreEnemies_Undo"] call A3EAI_forceBehavior};
			if ((combatMode _unitGroup) isEqualTo "BLUE") then {_unitGroup setCombatMode "YELLOW"};
		};
		if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: AI %1 group %2 parachuted with %3 surviving units.",(typeOf _vehicle),_unitGroup,_unitsAlive];};
	} else {
		_unitGroup setVariable ["unitType","aircrashed"];
		{
			_x action ["eject",_vehicle];
			_nul = [_x,_x] call A3EAI_handleDeathEvent;
			0 = [_x,_unitLevel] spawn A3EAI_generateLoot;
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
	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: AI %1 group %2 is now empty.",(typeOf _vehicle),_unitGroup];};
};

true
