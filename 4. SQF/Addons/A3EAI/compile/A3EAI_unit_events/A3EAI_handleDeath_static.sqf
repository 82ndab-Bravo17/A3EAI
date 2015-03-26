private ["_victim","_killer","_unitGroup","_trigger","_dummy","_groupIsEmpty"];

_victim = _this select 0;
_killer = _this select 1;
_unitGroup = _this select 2;
_groupIsEmpty = _this select 3;

_trigger = _unitGroup getVariable ["trigger",A3EAI_defaultTrigger];

if (_groupIsEmpty) then {
	if (_trigger getVariable ["respawn",true]) then {
		_respawnCount = _trigger getVariable ["respawnLimit",-1];
		if !(_respawnCount isEqualTo 0) then {
			[0,_trigger,_unitGroup] call A3EAI_addRespawnQueue; //If there are still respawns possible... respawn the group
		} else {
			if (isDedicated) then {
				_trigger setVariable ["permadelete",true];	//deny respawn and delete trigger on next despawn.
			} else {
				A3EAI_setPermaDeleteSpawn_PVS = _trigger;
				publicVariableServer "A3EAI_setPermaDeleteSpawn_PVS";
			};
		};
	} else {
		if (A3EAI_debugMarkersEnabled) then {deleteMarker str(_trigger)};
		_nul = _trigger spawn {
			_trigger = _this;
			_trigger setTriggerStatements ["this","true","false"]; //Disable trigger from activating or deactivating while cleanup is performed
			if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Deleting custom-defined AI spawn %1 at %2 in 30 seconds.",triggerText _trigger, mapGridPosition _trigger];};
			uiSleep 30;
			{
				_x setVariable ["GroupSize",-1];
				if !(isDedicated) then {
					A3EAI_updateGroupSize_PVS = [_unitGroup,-1];
					publicVariableServer "A3EAI_updateGroupSize_PVS";
				};
			} forEach (_trigger getVariable ["GroupArray",[]]);
			deleteMarker (_trigger getVariable ["spawnmarker",""]);
			[_trigger,"A3EAI_staticTriggerArray"] call A3EAI_updateSpawnCount;
			deleteVehicle _trigger;
		};
	};
} else {
	if (!(_trigger getVariable ["respawn",true])) then {
		_maxUnits = _trigger getVariable ["maxUnits",[0,0]]; //Reduce maximum AI for spawn trigger for each AI killed for non-respawning spawns.
		_maxUnits set [0,(_maxUnits select 0) - 1];
		if (A3EAI_debugLevel > 1) then {diag_log format["A3EAI Extended Debug: MaxUnits variable for group %1 set to %2.",_unitGroup,_maxUnits];};
	};
};

true
