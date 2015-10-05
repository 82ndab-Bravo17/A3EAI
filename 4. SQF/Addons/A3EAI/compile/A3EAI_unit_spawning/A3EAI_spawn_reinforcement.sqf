#include "\A3EAI\globaldefines.hpp"

private ["_destPos", "_unitLevel", "_maxGunnerUnits", "_vehiclePosition", "_error", "_unitGroup", "_driver", "_vehicleType", "_vehicle", "_direction", "_velocity", "_nvg", "_gunnersAdded", "_cargoSpots", "_cargo", "_result", "_rearm","_targetPlayer","_unitType","_vehicleDescription"];

A3EAI_activeReinforcements = A3EAI_activeReinforcements - [grpNull];
if ((count A3EAI_activeReinforcements) >= A3EAI_maxAirReinforcements) exitWith {
	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Maximum number of active air reinforcements reached (%1).",A3EAI_activeReinforcements];};
};

_destPos = _this select 0;
_targetPlayer = _this select 1;
_unitLevel = _this select 2;

if (({(_destPos distance _x) < AIR_REINFORCE_DIST_BETWEEN_LOCATIONS} count A3EAI_reinforcedPositions) > 0) exitWith {
	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Another AI reinforcement is active within 1000m of location %1, reinforce request cancelled.",_destPos];};
};

A3EAI_reinforcedPositions pushBack _destPos;

_error = false;
_maxGunnerUnits = A3EAI_airGunnerUnits;
_vehiclePosition = [_destPos,AIR_REINFORCE_SPAWN_DIST_BASE + (random(AIR_REINFORCE_SPAWN_DIST_VARIANCE)),random(360),1] call A3EAI_SHK_pos;
_vehiclePosition set [2,200];

_unitType = "air_reinforce";
_unitGroup = [_unitType] call A3EAI_createGroup;
_driver = [_unitGroup,_unitLevel,[0,0,0]] call A3EAI_createUnit;

_vehicleType = A3EAI_airReinforcementVehicles call A3EAI_selectRandom;
_vehicle = createVehicle [_vehicleType, _vehiclePosition, [], 0, "FLY"];
_driver moveInDriver _vehicle;

_vehicle call A3EAI_protectObject;
_vehicle call A3EAI_secureVehicle;
_vehicle call A3EAI_clearVehicleCargo;
_vehicle call A3EAI_addVehAirEH;
_vehicle call A3EAI_randomizeVehicleColor;

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
_vehicle allowCrewInImmobile false;
_vehicle setUnloadInCombat [false,false];

//Setup group and crew
_nvg = _driver call A3EAI_addTempNVG;
_driver assignAsDriver _vehicle;
_driver setVariable ["isDriver",true];
_unitGroup selectLeader _driver;

_gunnersAdded = [_unitGroup,_unitLevel,_vehicle,_maxGunnerUnits] call A3EAI_addVehicleGunners;
if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Spawned %1 gunner units for %2 vehicle %3.",_gunnersAdded,_unitGroup,_vehicleType];};

_unitGroup setSpeedMode "NORMAL";
_unitGroup allowFleeing 0;

_unitGroup setVariable ["unitLevel",_unitLevel];
_unitGroup setVariable ["assignedVehicle",_vehicle];
_unitGroup setVariable ["ReinforcePos",_destPos];
(units _unitGroup) allowGetIn true;

_vehicle flyInHeight FLYINHEIGHT_AIR_REINFORCE;

if (A3EAI_removeExplosiveAmmo) then {
	_result = _vehicle call A3EAI_removeExplosive; //Remove missile weaponry for air vehicles
};

if ((!isNull _vehicle) && {!isNull _unitGroup}) then {
	A3EAI_activeReinforcements pushBack _unitGroup;
	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Created AI air reinforcement group %1 is now active and patrolling.",_unitGroup];};
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

if (A3EAI_enableRadioMessages && {!((owner _targetPlayer) isEqualTo 0)}) then {
	private ["_targetPlayerVehicleCrew","_radioText"];
	if ((_targetPlayer distance _destPos) < AIR_REINFORCE_RADIO_DIST) then {
		_targetPlayerVehicleCrew = (crew (vehicle _targetPlayer));
		if (({if (RADIO_ITEM in (assignedItems _x)) exitWith {1}} count _targetPlayerVehicleCrew) > 0) then {
			_vehicleDescription = format ["%1 %2",[configFile >> "CfgVehicles" >> _vehicleType,"displayName","patrol"] call BIS_fnc_returnConfigEntry,[configFile >> "CfgVehicles" >> _vehicleType,"textSingular","helicopter"] call BIS_fnc_returnConfigEntry];
			_radioText = [20,[_vehicleDescription]];
			{
				[_x,_radioText] call A3EAI_radioSend;
			} forEach _targetPlayerVehicleCrew;
		};
	};
};
	
if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Created AI air reinforcement at %1 with vehicle type %2 with %3 crew units. Distance from destination: %4.",_vehiclePosition,_vehicleType,(count (units _unitGroup)),(_destPos distance _vehiclePosition)]};

true
