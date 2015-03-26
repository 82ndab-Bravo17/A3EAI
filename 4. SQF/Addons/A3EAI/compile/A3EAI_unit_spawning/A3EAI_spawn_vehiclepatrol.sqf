private ["_vehicleType", "_maxCargoUnits", "_maxGunnerUnits", "_unitLevel", "_isAirVehicle", "_vehiclePosition", "_spawnMode", "_keepLooking", "_error", "_playerNear", "_unitType", "_unitGroup", "_driver", "_vehicle", "_direction", "_velocity", "_nearRoads", "_nextRoads", "_gunnersAdded", "_cargoSpots", "_cargo", "_waypoint", "_result", "_rearm"];

_vehicleType = _this;

_maxCargoUnits = 0;
_maxGunnerUnits = 0;
_unitLevel = 0;
_isAirVehicle = (_vehicleType isKindOf "Air");
_vehiclePosition = [];
_spawnMode = "NONE";
_keepLooking = true;
_error = false;

call {
	if (_vehicleType isKindOf "Air") exitWith {
		//Note: no cargo units for air vehicles
		_maxGunnerUnits = A3EAI_heliGunnerUnits;
		_unitLevel = "airvehicle" call A3EAI_getUnitLevel;
		_vehiclePosition = [(getMarkerPos "A3EAI_centerMarker"),300 + (random((getMarkerSize "A3EAI_centerMarker") select 0)),random(360),1] call SHK_pos;
		_vehiclePosition set [2,150];
		_spawnMode = "FLY";
	};
	if (_vehicleType isKindOf "Car") exitWith {
		_maxGunnerUnits = A3EAI_vehGunnerUnits;
		_maxCargoUnits = A3EAI_vehCargoUnits;
		_unitLevel = "landvehicle" call A3EAI_getUnitLevel;
		while {_keepLooking} do {
			_vehiclePosition = [(getMarkerPos "A3EAI_centerMarker"),300 + random((getMarkerSize "A3EAI_centerMarker") select 0),random(360),0,[2,750]] call SHK_pos;
			if ((count _vehiclePosition) > 1) then {
				_playerNear = ({isPlayer _x} count (_vehiclePosition nearEntities [["Epoch_Male_F","Epoch_Female_F","AllVehicles"], 300]) > 0);
				if(!_playerNear) then {
					_keepLooking = false;	//Found road position, stop searching
				};
			} else {
				if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Unable to find road position to spawn AI %1. Retrying in 30 seconds.",_vehicleType]};
				uiSleep 30; //Couldnt find road, search again in 30 seconds.
			};
		};
	};
	_error = true;
};

if (_error) exitWith {diag_log format ["A3EAI Error: %1 attempted to spawn unsupported vehicle type %2.",__FILE__,_vehicleType]};

_unitType = if (_isAirVehicle) then {"air"} else {"land"};
_unitGroup = [_unitType] call A3EAI_createGroup;
_driver = [_unitGroup,_unitLevel,[0,0,0]] call A3EAI_createUnit;

_vehicle = createVehicle [_vehicleType, _vehiclePosition, [], 0, _spawnMode];
_driver moveInDriver _vehicle;

_vehicle call A3EAI_protectObject;
_vehicle call A3EAI_secureVehicle;
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
	if (_vehicle isKindOf "Car") exitWith {
		_nearRoads = _vehiclePosition nearRoads 100;
		if !(_nearRoads isEqualTo []) then {
			_nextRoads = roadsConnectedTo (_nearRoads select 0);
			if !(_nextRoads isEqualTo []) then {
				_direction = [_vehicle,(_nextRoads select 0)] call BIS_fnc_relativeDirTo;
				_vehicle setDir _direction;
				//diag_log format ["Debug: Reoriented vehicle %1 to direction %2.",_vehicle,_direction];
			};
		} else {
			_vehicle setDir (random 360);
		};
	};
};

//Set variables
_vehicle setVariable ["unitGroup",_unitGroup];

//Determine vehicle type and add needed eventhandlers
if (_isAirVehicle) then {
	_vehicle setVariable ["durability",[0,0,0]];	//[structural, engine, tail rotor]
	_vehicle addEventHandler ["Killed",{[_this,_unitGroup] call A3EAI_heliDestroyed;}];					//Begin despawn process when heli is destroyed.
	_vehicle addEventHandler ["GetOut",{[_this,_unitGroup] call A3EAI_heliLanded;}];	//Converts AI crew to ground AI units.
	_vehicle addEventHandler ["HandleDamage",{[_this,_unitGroup] call A3EAI_handleDamageHeli}];
} else {
	_vehicle addEventHandler ["Killed",{[_this,_unitGroup] call A3EAI_vehDestroyed;}];
	_vehicle addEventHandler ["HandleDamage",{_this call A3EAI_handleDamageVeh}];
};
_vehicle allowCrewInImmobile (!_isAirVehicle);
_vehicle setUnloadInCombat [!_isAirVehicle,false];
clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;

//Setup group and crew
if (!(_driver hasWeapon "NVG_EPOCH")) then {
	_nvg = _driver call A3EAI_addTempNVG;
};
_driver assignAsDriver _vehicle;
_driver setVariable ["isDriver",true];
_unitGroup selectLeader _driver;

_gunnersAdded = [_unitGroup,_unitLevel,_vehicle,_maxGunnerUnits] call A3EAI_addVehicleGunners;
if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Spawned %1 gunner units for %2 vehicle %3.",_gunnersAdded,_unitGroup,_vehicleType];};

_cargoSpots = _vehicle emptyPositions "cargo";
for "_i" from 0 to ((_cargoSpots min _maxCargoUnits) - 1) do {
	_cargo = [_unitGroup,_unitLevel,[0,0,0]] call A3EAI_createUnit;
	if (!(_cargo hasWeapon "NVG_EPOCH")) then {
		_nvg = _cargo call A3EAI_addTempNVG;
	};
	_cargo assignAsCargoIndex [_vehicle,_i];
	_cargo moveInCargo _vehicle;
};
if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Spawned %1 cargo units for %2 vehicle %3.",(_cargoSpots min _maxCargoUnits),_unitGroup,_vehicleType]};

_unitGroup setBehaviour "AWARE";
_unitGroup setSpeedMode "NORMAL";
_unitGroup setCombatMode "YELLOW";
_unitGroup allowFleeing 0;

_unitGroup setVariable ["unitLevel",_unitLevel];
_unitGroup setVariable ["assignedVehicle",_vehicle];
(units _unitGroup) allowGetIn true;

if (_isAirVehicle) then {
	//Set initial waypoint and begin patrol
	[_unitGroup,0] setWPPos _vehiclePosition;
	[_unitGroup,0] setWaypointType "MOVE";
	[_unitGroup,0] setWaypointTimeout [0.5,0.5,0.5];
	[_unitGroup,0] setWaypointCompletionRadius 200;
	[_unitGroup,0] setWaypointStatements ["true","if (local this) then {[(group this)] spawn A3EAI_heliDetection;};"];

	_waypoint = _unitGroup addWaypoint [_vehiclePosition,0];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointTimeout [3,6,9];
	_waypoint setWaypointCompletionRadius 150;
	_waypoint setWaypointStatements ["true","if (local this) then {[(group this)] spawn A3EAI_heliStartPatrol;};"];
	
	_unitGroup setVariable ["HeliLastParaDrop",diag_tickTime - A3EAI_paraDropCooldown];
	_vehicle flyInHeight 125;
	
	if (A3EAI_removeMissileWeapons) then {
		_result = _vehicle call A3EAI_clearMissileWeapons; //Remove missile weaponry for air vehicles
	};
	
	if ((!isNull _vehicle) && {!isNull _unitGroup}) then {
		A3EAI_curHeliPatrols = A3EAI_curHeliPatrols + 1;
		if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Created AI helicopter crew group %1 is now active and patrolling.",_unitGroup];};
	};
} else {
	//Set initial waypoint and begin patrol
	[_unitGroup,0] setWaypointType "MOVE";
	[_unitGroup,0] setWaypointTimeout [5,10,15];
	[_unitGroup,0] setWaypointCompletionRadius 150;
	[_unitGroup,0] setWaypointStatements ["true","if (local this) then {[(group this)] spawn A3EAI_vehStartPatrol;};"];
	
	if ((!isNull _vehicle) && {!isNull _unitGroup}) then {
		A3EAI_curLandPatrols = A3EAI_curLandPatrols + 1;
		if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Created AI land vehicle crew group %1 is now active and patrolling.",_unitGroup];};
	};
};

if (_isAirVehicle) then {
	[_unitGroup] spawn A3EAI_heliStartPatrol;
} else {
	[_unitGroup] spawn A3EAI_vehStartPatrol;
};
_rearm = [_unitGroup,_unitLevel] spawn A3EAI_addGroupManager;	//start group-level manager

if (A3EAI_enableHC) then {
	_nul = _unitGroup spawn {
		uiSleep 30;
		_this setVariable ["HC_Ready",true];
	};
};

if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Created AI vehicle patrol at %1 with vehicle type %2 with %3 crew units.",_vehiclePosition,_vehicleType,(count (units _unitGroup))]};

true
