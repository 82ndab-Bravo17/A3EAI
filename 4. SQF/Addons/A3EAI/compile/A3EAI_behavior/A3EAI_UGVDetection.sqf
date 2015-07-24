private ["_unitGroup","_vehicle","_canCall"];
_unitGroup = _this select 0;

if (_unitGroup getVariable ["EnemiesIgnored",false]) then {[_unitGroup,"Behavior_Reset"] call A3EAI_forceBehavior};

_vehicle = _unitGroup getVariable ["assignedVehicle",objNull];

_canCall = true;

if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Group %1 %2 detection start.",_unitGroup,(typeOf (_vehicle))];};

if ((diag_tickTime - (_unitGroup getVariable ["UVLastCall",-A3EAI_UGVCallReinforceCooldown])) > A3EAI_UGVCallReinforceCooldown) then {
	_detectStartPos = getPosATL _vehicle;
	
	while {!(_vehicle getVariable ["vehicle_disabled",false]) && {(_unitGroup getVariable ["GroupSize",-1]) > 0} && {local _unitGroup}} do {
		private ["_detected","_detectOrigin","_startPos"];
		_startPos = getPosATL _vehicle;
		_detectOrigin = [_startPos,0,getDir _vehicle,1] call SHK_pos;
		_detected = _detectOrigin nearEntities [["Epoch_Male_F","Epoch_Female_F","LandVehicle"],250];
		if ((count _detected) > 5) then {_detected resize 5};
		{
			if (isPlayer _x) then {
				_UGVAimPos = aimPos _vehicle;
				_playerEyePos = eyePos _x;
				if (!(terrainIntersectASL [_UGVAimPos,_playerEyePos]) && {!(lineIntersects [_UGVAimPos,_playerEyePos,_vehicle,_x])} && {A3EAI_UGVDetectChance call A3EAI_chance}) then {
					if (_canCall) then {
						if (isDedicated) then {
							_nul = [(getPosATL _x),_x,_unitGroup getVariable ["unitLevel",0]] spawn A3EAI_spawn_reinforcement;
						} else {
							A3EAI_spawnReinforcements_PVS = [(getPosATL _x),_x,_unitGroup getVariable ["unitLevel",0]];
							publicVariableServer "A3EAI_spawnReinforcements_PVS";
						};
						_unitGroup setVariable ["UVLastCall",diag_tickTime];
						_canCall = false;
					};
					if (({if ("EpochRadio0" in (assignedItems _x)) exitWith {1}} count (crew (vehicle _x))) > 0) then {
						[_x,[51+(floor (random 5)),[_unitGroup,[configFile >> "CfgVehicles" >> (typeOf _vehicle),"displayName",""] call BIS_fnc_returnConfigEntry]]] call A3EAI_radioSend;
					};
				};
			};
			uiSleep 0.1;
		} forEach _detected;
		if (((_vehicle distance _detectStartPos) > 500) or {_vehicle getVariable ["vehicle_disabled",false]}) exitWith {};
		uiSleep 15;
	};
};

if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Group %1 %2 detection end.",_unitGroup,(typeOf (_vehicle))];};
