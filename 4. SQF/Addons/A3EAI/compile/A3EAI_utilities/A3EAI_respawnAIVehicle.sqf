private ["_vehicle", "_vehicleType", "_spawnParams"];
if (isNull _this) exitWith {diag_log format ["Error: %1 attempted to respawn null vehicle",__FILE__];};
if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Respawning AI vehicle %1.",_this]};
if (isDedicated) then {
	_vehicle = _this;
	_vehicleType = (typeOf _vehicle);
	_spawnParams = _vehicle getVariable ["spawnParams",[]];
	if !(_spawnParams isEqualTo []) then {
		if (_spawnParams select 4) then {
			[1,_spawnParams] call A3EAI_addRespawnQueue;
		};
	} else {
		[2,_vehicleType] call A3EAI_addRespawnQueue;
	};
	if (_vehicleType isKindOf "Air") then {A3EAI_curHeliPatrols = A3EAI_curHeliPatrols - 1} else {A3EAI_curLandPatrols = A3EAI_curLandPatrols - 1};
	_vehicle setVariable ["A3EAI_deathTime",diag_tickTime]; //mark vehicle for cleanup
} else {
	A3EAI_respawnVehicle_PVS = _this;
	publicVariableServer "A3EAI_respawnVehicle_PVS";
};
{_this removeAllEventHandlers _x} count ["HandleDamage","Killed","GetOut","Local"];

true