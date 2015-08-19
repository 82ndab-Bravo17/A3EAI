//Function frequency definitions
#define CLEANDEAD_FREQ 600
#define VEHICLE_CLEANUP_FREQ 60
#define LOCATION_CLEANUP_FREQ 360
#define RANDSPAWN_CHECK_FREQ 360
#define RANDSPAWN_EXPIRY_TIME 1080
#define SIDECHECK_TIME 1200
#define UPDATE_PLAYER_COUNT_FREQ 60
#define KRYPTO_CLEANUP_FREQ 900

if (A3EAI_debugLevel > 0) then {diag_log "A3EAI Server Monitor will start in 60 seconds."};

//Initialize timer variables
_currentTime = diag_tickTime;
_cleanDead = _currentTime;
_monitorReport = _currentTime;
_deleteObjects = _currentTime;
_dynLocations = _currentTime;
_checkRandomSpawns = _currentTime - (RANDSPAWN_CHECK_FREQ/2);
_sideCheck = _currentTime;
_playerCountTime = _currentTime - UPDATE_PLAYER_COUNT_FREQ;

//Setup variables
_currentPlayerCount = 0;
_lastPlayerCount = 0;
_multiplierLowPlayers = 0;
_multiplierHighPlayers = 0;
_maxSpawnChancePlayers = (A3EAI_playerCountThreshold max 1);

if (A3EAI_upwardsChanceScaling) then {
	_multiplierLowPlayers = A3EAI_chanceScalingThreshold;
	_multiplierHighPlayers = 1;
} else {
	_multiplierLowPlayers = 1;
	_multiplierHighPlayers = A3EAI_chanceScalingThreshold;
};

//Cleanup global variables
A3EAI_chanceScalingThreshold = nil;
A3EAI_upwardsChanceScaling = nil;
A3EAI_playerCountThreshold = nil;

//Local functions
_getUptime = {
	private ["_currentSec","_outSec","_outMin","_outHour"];
	_currentSec = diag_tickTime;
	_outHour = (floor (_currentSec/3600));
	_outMin = (floor ((_currentSec - (_outHour*3600))/60));
	_outSec = (floor (_currentSec - (_outHour*3600) - (_outMin*60)));
	
	_outHour = str (_outHour);
	_outMin = str (_outMin);
	_outSec = str (_outSec);
	
	if ((count _outHour) isEqualTo 1) then {_outHour = format ["0%1",_outHour];};
	if ((count _outMin) isEqualTo 1) then {_outMin = format ["0%1",_outMin];};
	if ((count _outSec) isEqualTo 1) then {_outSec = format ["0%1",_outSec];};
	
	[_outHour,_outMin,_outSec]
};

_purgeEH = {
	{_this removeAllEventHandlers _x} count ["Killed","HandleDamage","GetIn","GetOut","Fired","Local"];
};

//Script handles
_cleanupMain = scriptNull;
_cleanupLocations = scriptNull;
_cleanupRandomSpawns = scriptNull;

uiSleep 60;

while {true} do {
	//Main cleanup loop
	_currentTime = diag_tickTime;
	if ((_currentTime - _cleanDead) > CLEANDEAD_FREQ) then {
		if !(scriptDone _cleanupMain) then {terminate _cleanupMain; diag_log "A3EAI terminated previous cleanupMain loop.";};
		_cleanupMain = [_currentTime,_purgeEH] spawn {
			_currentTime = _this select 0;
			_purgeEH = _this select 1;
			_bodiesCleaned = 0;
			_vehiclesCleaned = 0;
			
			//Body/vehicle cleanup loop
			{
				_deathTime = _x getVariable "A3EAI_deathTime";
				if (!isNil "_deathTime") then {
					call {
						if (_x isKindOf "CAManBase") exitWith {
							if ((_currentTime - _deathTime) > A3EAI_cleanupDelay) then {
								if (({isPlayer _x} count (_x nearEntities [["Epoch_Male_F","Epoch_Female_F","Air","LandVehicle"],30])) isEqualTo 0) then {
									_x call _purgeEH;
									deleteVehicle _x;
									_bodiesCleaned = _bodiesCleaned + 1;
								};
							};
						};
						if (_x isKindOf "AllVehicles") exitWith {
							if ((_currentTime - _deathTime) > VEHICLE_CLEANUP_FREQ) then {
								if (({isPlayer _x} count (_x nearEntities [["Epoch_Male_F","Epoch_Female_F","Air","LandVehicle"],60])) isEqualTo 0) then {
									if (_x in A3EAI_monitoredObjects) then {
										{
											if (!(alive _x)) then {
												deleteVehicle _x;
											};
										} forEach (crew _x);
									};
									_x call _purgeEH;
									deleteVehicle _x;
									_vehiclesCleaned = _vehiclesCleaned + 1;
								};
							};
						};
					};
				};
				uiSleep 0.025;
			} count allDead;
			
			//Clean abandoned AI vehicles
			{	
				if (!isNull _x) then {
					private ["_deathTime"];
					_deathTime = _x getVariable "A3EAI_deathTime";
					if (!isNil "_deathTime") then {
						if ((_currentTime - _deathTime) > VEHICLE_CLEANUP_FREQ) then {
							if (({alive _x} count (crew _x)) isEqualTo 0) then {
								_x call _purgeEH;
								deleteVehicle _x;
								_vehiclesCleaned = _vehiclesCleaned + 1;
							};
						};
					};
				};
				uiSleep 0.025;
			} count A3EAI_monitoredObjects;
			
			{
				if (!isNull _x) then {
					private ["_kryptoGenTime"];
					_kryptoGenTime = _x getVariable "A3EAI_kryptoGenTime";
					if (!isNil "_kryptoGenTime") then {
						if ((_currentTime - _kryptoGenTime) > KRYPTO_CLEANUP_FREQ) then {
							_kryptoArea = _x getVariable ["A3EAI_kryptoArea",objNull];
							if !(isNull _kryptoArea) then {
								A3EAI_kryptoAreas = A3EAI_kryptoAreas - [_kryptoArea];
								deleteVehicle _kryptoArea;
							};
							deleteVehicle _x;
						};
					};
				};
				uiSleep 0.025;
			} forEach A3EAI_kryptoObjects;
			
			{
				if (!isNull _x) then {
					private ["_kryptoObject"];
					_kryptoObject = _x getVariable "A3EAI_kryptoObject";
					if (!isNil "_kryptoObject") then {
						call {
							private ["_kryptoGenTime","_arrowObject"];
							if (isNull _kryptoObject) exitWith {
								deleteVehicle (_x getVariable ["A3EAI_arrowObject",objNull]);
								deleteVehicle _x;
							};
							if ((_currentTime - (_x getVariable ["A3EAI_kryptoGenTime",0])) > A3EAI_kryptoPickupAssist) exitWith {
								deleteVehicle (_x getVariable ["A3EAI_arrowObject",objNull]);
								deleteVehicle _x;
							};
						};
					} else {
						A3EAI_kryptoAreas set [_forEachIndex,objNull];
					};
				};
				uiSleep 0.025;
			} forEach A3EAI_kryptoAreas;

			//Clean server object monitor
			if (objNull in A3EAI_monitoredObjects) then {A3EAI_monitoredObjects = A3EAI_monitoredObjects - [objNull];};
			if (objNull in A3EAI_kryptoObjects) then {A3EAI_kryptoObjects = A3EAI_kryptoObjects - [objNull];};
			if (objNull in A3EAI_kryptoAreas) then {A3EAI_kryptoAreas = A3EAI_kryptoAreas - [objNull];};
			if ((_bodiesCleaned + _vehiclesCleaned) > 0) then {diag_log format ["A3EAI Cleanup: Cleaned up %1 dead units and %2 destroyed vehicles.",_bodiesCleaned,_vehiclesCleaned]};
		};
		_cleanDead = _currentTime;
	};

	//Main location cleanup loop
	if ((_currentTime - _dynLocations) > LOCATION_CLEANUP_FREQ) then {
		if !(scriptDone _cleanupLocations) then {terminate _cleanupLocations; diag_log "A3EAI terminated previous cleanupLocations loop.";};
		_cleanupLocations  = [_currentTime] spawn {
			_currentTime = _this select 0;
			_locationsDeleted = 0;
			A3EAI_areaBlacklists = A3EAI_areaBlacklists - [locationNull];
			{
				_deletetime = _x getVariable "deletetime"; 
				if (isNil "_deleteTime") then {_deleteTime = _currentTime}; //since _x getVariable ["deletetime",_currentTime] gives an error...
				//diag_log format ["DEBUG: CurrentTime: %1. Delete Time: %2",_currentTime,_deletetime];
				if (_currentTime > _deletetime) then {
					deleteLocation _x;
					_locationsDeleted = _locationsDeleted + 1;
				};
				uiSleep 0.025;
			} count A3EAI_areaBlacklists;
			A3EAI_areaBlacklists = A3EAI_areaBlacklists - [locationNull];
			if (_locationsDeleted > 0) then {diag_log format ["A3EAI Cleanup: Cleaned up %1 expired temporary blacklist areas.",_locationsDeleted]};
		};
		_dynLocations = _currentTime;
	};

	if ((_currentTime - _checkRandomSpawns) > RANDSPAWN_CHECK_FREQ) then {
		if !(scriptDone _cleanupRandomSpawns) then {terminate _cleanupRandomSpawns; diag_log "A3EAI terminated previous cleanupRandomSpawns loop.";};
		_cleanupRandomSpawns = [_currentTime] spawn {
			_currentTime = _this select 0;
			A3EAI_randTriggerArray = A3EAI_randTriggerArray - [objNull];
			{
				if ((((triggerStatements _x) select 1) != "") && {(_currentTime - (_x getVariable ["timestamp",_currentTime])) > RANDSPAWN_EXPIRY_TIME}) then {
					_triggerLocation = _x getVariable ["triggerLocation",locationNull];
					deleteLocation _triggerLocation;
					if (A3EAI_debugMarkersEnabled) then {deleteMarker (str _x)};	
					deleteVehicle _x;
				};
				if ((_forEachIndex % 3) isEqualTo 0) then {uiSleep 0.05};
			} forEach A3EAI_randTriggerArray;
			A3EAI_randTriggerArray = A3EAI_randTriggerArray - [objNull];
			_spawnsAvailable = A3EAI_maxRandomSpawns - (count A3EAI_randTriggerArray);
			if (_spawnsAvailable > 0) then {
				_nul = _spawnsAvailable spawn A3EAI_setup_randomspawns;
			};
		};
		_checkRandomSpawns = _currentTime;
	};
	
	if ((_currentTime - _playerCountTime) > UPDATE_PLAYER_COUNT_FREQ) then {
		_currentPlayerCount = ({alive _x} count allPlayers);
		if (A3EAI_HCIsConnected) then {_currentPlayerCount = _currentPlayerCount - 1};
		if !(_lastPlayerCount isEqualTo _currentPlayerCount) then {
			A3EAI_spawnChanceMultiplier = linearConversion [1, _maxSpawnChancePlayers, _currentPlayerCount, _multiplierLowPlayers, _multiplierHighPlayers, true];
			_lastPlayerCount = _currentPlayerCount;
			if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Updated A3EAI_spawnChanceMultiplier to %1",A3EAI_spawnChanceMultiplier];};
		};
		_playerCountTime = _currentTime;
	};
	
	//Check for unwanted side modifications
	if ((_currentTime - _sideCheck) > SIDECHECK_TIME) then {
		if !((resistance getFriend west) isEqualTo 0) then {resistance setFriend [west, 0]};
		if !((resistance getFriend east) isEqualTo 0) then {resistance setFriend [east, 0]};
		if !((east getFriend resistance) isEqualTo 0) then {east setFriend [resistance, 0]};
		if !((west getFriend resistance) isEqualTo 0) then {west setFriend [resistance, 0]};
		if !((resistance getFriend resistance) isEqualTo 1) then {resistance setFriend [resistance, 1]};
		_sideCheck = _currentTime;
	};
	
	if (A3EAI_debugMarkersEnabled) then {
		{
			if (_x in allMapMarkers) then {
				_x setMarkerPos (getMarkerPos _x);
			} else {
				A3EAI_mapMarkerArray set [_forEachIndex,""];
			};
			if ((_forEachIndex % 3) isEqualTo 0) then {uiSleep 0.05};
		} forEach A3EAI_mapMarkerArray;
		A3EAI_mapMarkerArray = A3EAI_mapMarkerArray - [""];
	};
	
	A3EAI_activeGroups = A3EAI_activeGroups - [grpNull];
	_activeGroupAmount = format ["%1/%2",{(_x getVariable ["GroupSize",0]) > 0} count A3EAI_activeGroups,count A3EAI_activeGroups];
	
	//Report statistics to RPT log
	if ((A3EAI_monitorRate > 0) && {((_currentTime - _monitorReport) > A3EAI_monitorRate)}) then {
		_uptime = [] call _getUptime;
		diag_log format ["[A3EAI Monitor] [Uptime:%1:%2:%3][FPS:%4][Groups:%5][Respawn:%6][HC:%7]",_uptime select 0, _uptime select 1, _uptime select 2,round diag_fps,_activeGroupAmount,(count A3EAI_respawnQueue),A3EAI_HCIsConnected];
		diag_log format ["[A3EAI Monitor] [Static:%1][Dynamic:%2][Random:%3][Air:%4][Land:%5][UAV:%6][UGV:%7]",(count A3EAI_staticTriggerArray),(count A3EAI_dynTriggerArray),(count A3EAI_randTriggerArray),A3EAI_curHeliPatrols,A3EAI_curLandPatrols,A3EAI_curUAVPatrols,A3EAI_curUGVPatrols];
		_monitorReport = _currentTime;
	};

	uiSleep 30;
};
