private ["_destPos", "_unitLevel", "_maxCargoUnits", "_maxGunnerUnits", "_vehiclePosition", "_spawnMode", "_keepLooking", "_error", "_unitGroup", "_driver", "_vehicleType", "_vehicle", "_direction", "_velocity", "_nvg", "_gunnersAdded", "_cargoSpots", "_cargo", "_result", "_rearm"];

A3EAI_activeReinforcements = A3EAI_activeReinforcements - [grpNull];
if ((count A3EAI_activeReinforcements) >= A3EAI_maxAirReinforcements) exitWith {
	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Maximum number of active air reinforcements reached (%1).",A3EAI_activeReinforcements];};
};

_destPos = _this select 0;
_unitLevel = _this select 1;

if (({(_destPos distance _x) < 600} count A3EAI_reinforcedPositions) > 0) exitWith {
	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Another AI reinforcement is active within 600m of location %1, reinforce request cancelled.",_destPos];};
};

A3EAI_reinforcedPositions pushBack _destPos;

_maxCargoUnits = 0;
_maxGunnerUnits = 0;
_vehiclePosition = [];
_spawnMode = "NONE";
_keepLooking = true;
_error = false;

_maxGunnerUnits = A3EAI_heliGunnerUnits;
_vehiclePosition = [_destPos,1200 + (random(600)),random(360),1] call SHK_pos;
_vehiclePosition set [2,200];
_spawnMode = "FLY";

_unitGroup = ["air_reinforce"] call A3EAI_createGroup;
_driver = [_unitGroup,_unitLevel,[0,0,0]] call A3EAI_createUnit;

_vehicleType = A3EAI_airReinforcementVehicles call BIS_fnc_selectRandom2;
_vehicle = createVehicle [_vehicleType, _vehiclePosition, [], 0, _spawnMode];
_driver moveInDriver _vehicle;

_vehicle call A3EAI_protectObject;
_vehicle call A3EAI_secureVehicle;
_vehicle call A3EAI_clearVehicleCargo;
_vehicle call A3EAI_addVehAirEH;

call {
	if (_vehicle isKindOf "Plane") exitWith {
		_direction = (random 360);
		_velocity = velocity _vehicle;
		_vehicle setDir _direction;
		_vehicle setVelocity [(_velocity select 1)*sin _direction - (_velocity select 0)*cos _direction, (_velocity select 0)*sin _direction + (_velocity select 1)*cos _direction, _velocity select 2];
	};
	if (_vehicle isKindOf "Helicopter") exitWith {
		_vehicle setDir (random 360);
	};
	_error = true;
};

if (_error) exitWith {diag_log format ["A3EAI Error: Selected reinforcement vehicle %1 is non-Air type!",_vehicleType];};

//Set variables
_vehicle setVariable ["unitGroup",_unitGroup];
_vehicle setVariable ["vehicle_disabled",true];
_vehicle allowCrewInImmobile false;
_vehicle setUnloadInCombat [false,false];

//Setup group and crew
_nvg = _driver call A3EAI_addTempNVG;
_driver assignAsDriver _vehicle;
_driver setVariable ["isDriver",true];
_unitGroup selectLeader _driver;

_gunnersAdded = [_unitGroup,_unitLevel,_vehicle,_maxGunnerUnits] call A3EAI_addVehicleGunners;
if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Spawned %1 gunner units for %2 vehicle %3.",_gunnersAdded,_unitGroup,_vehicleType];};

_cargoSpots = _vehicle emptyPositions "cargo";
for "_i" from 0 to ((_cargoSpots min _maxCargoUnits) - 1) do {
	_cargo = [_unitGroup,_unitLevel,[0,0,0]] call A3EAI_createUnit;
	_nvg = _cargo call A3EAI_addTempNVG;
	_cargo assignAsCargoIndex [_vehicle,_i];
	_cargo moveInCargo _vehicle;
};
if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Spawned %1 cargo units for %2 vehicle %3.",(_cargoSpots min _maxCargoUnits),_unitGroup,_vehicleType]};

//[_unitGroup,"IgnoreEnemies"] call A3EAI_forceBehavior;
_unitGroup setSpeedMode "NORMAL";
_unitGroup allowFleeing 0;

_unitGroup setVariable ["unitLevel",_unitLevel];
_unitGroup setVariable ["assignedVehicle",_vehicle];
_unitGroup setVariable ["ReinforcePos",_destPos];
_vehicle setVariable ["ArmedVehicle",((({_x call A3EAI_checkIsWeapon} count (weapons _vehicle)) > 0) || {_gunnersAdded > 0})];
(units _unitGroup) allowGetIn true;

_vehicle flyInHeight 115;

if (A3EAI_removeMissileWeapons) then {
	_result = _vehicle call A3EAI_clearMissileWeapons; //Remove missile weaponry for air vehicles
};

if ((!isNull _vehicle) && {!isNull _unitGroup}) then {
	A3EAI_activeReinforcements pushBack _unitGroup;
	if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Created AI air reinforcement group %1 is now active and patrolling.",_unitGroup];};
};

//Set initial waypoint and begin patrol
[_unitGroup,0] setWPPos _destPos;
[_unitGroup,0] setWaypointType "MOVE";
[_unitGroup,0] setWaypointTimeout [0.5,0.5,0.5];
[_unitGroup,0] setWaypointCompletionRadius 200;
[_unitGroup,0] setWaypointStatements ["true","if (isServer) then {(group this) spawn A3EAI_reinforce_begin};"];
[_unitGroup,0] setWaypointBehaviour "CARELESS";
[_unitGroup,0] setWaypointCombatMode "BLUE";
_unitGroup setCurrentWaypoint [_unitGroup,0];

_rearm = [_unitGroup,_unitLevel] spawn A3EAI_addGroupManager;	//start group-level manager

if (A3EAI_enableHC && {_unitType in A3EAI_HCAllowedTypes}) then {
	_unitGroup setVariable ["HC_Ready",true];
};

if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Created AI air reinforcement at %1 with vehicle type %2 with %3 crew units. Distance from destination: %4.",_vehiclePosition,_vehicleType,(count (units _unitGroup)),(_destPos distance _vehiclePosition)]};

true
