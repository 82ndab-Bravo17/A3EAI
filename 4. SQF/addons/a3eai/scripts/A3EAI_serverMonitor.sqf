#include "\A3EAI\globaldefines.hpp"

if (A3EAI_debugLevel > 0) then {diag_log "A3EAI Server Monitor will start in 60 seconds."};

//Initialize timer variables
_currentTime = diag_tickTime;
_cleanDead = _currentTime;
_monitorReport = _currentTime;
_deleteObjects = _currentTime;
_dynLocations = _currentTime;
_checkRandomSpawns = _currentTime - MONITOR_CHECK_RANDSPAWN_FREQ;
_sideCheck = _currentTime;
_playerCountTime = _currentTime - MONITOR_UPDATE_PLAYER_COUNT_FREQ;

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

_fnc_purgeAndDelete = {
	if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Purging a %1 from A3EAI_monitoredObjects.",(typeOf _this)];};
	{_this removeAllEventHandlers _x} count ["Killed","HandleDamage","GetIn","GetOut","Fired","Local","Hit"];
	_index = A3EAI_monitoredObjects find _this;
	if (_index > -1) then {A3EAI_monitoredObjects deleteAt _index;};
	deleteVehicle _this;
	true
};

//Script handles
_cleanupMain = scriptNull;
_cleanupLocations = scriptNull;
_cleanupRandomSpawns = scriptNull;

_canKillCleanupMain = false;
_canKillCleanupLocations = false;
_canKillRandomSpawns = false;

uiSleep 60;

while {true} do {
	//Main cleanup loop
	_currentTime = diag_tickTime;
	if ((_currentTime - _cleanDead) > MONITOR_CLEANDEAD_FREQ) then {
		if (scriptDone _cleanupMain) then {
			if (_canKillCleanupMain) then {_canKillCleanupMain = false;};
			_cleanupMain = [_currentTime,_fnc_purgeAndDelete] spawn {
				_currentTime = _this select 0;
				_fnc_purgeAndDelete = _this select 1;

				//Clean abandoned AI vehicles
				{	
					call {
						if (_x isKindOf "i_survivor_F") exitWith {
							if !(alive _x) then {
								_deathTime = _x getVariable "A3EAI_deathTime";
								if (!isNil "_deathTime") then {
									if ((_currentTime - _deathTime) > A3EAI_cleanupDelay) then {
										if (({isPlayer _x} count (_x nearEntities [[PLAYER_UNITS,"Air","LandVehicle"],30])) isEqualTo 0) then {
											_x call _fnc_purgeAndDelete;
										};
									};
								} else {
									_x setVariable ["A3EAI_deathTime",_currentTime];
								};
							};
						};
						if (_x isKindOf "I_UAV_AI") exitWith {
							if !(alive _x) then {
								_x call _fnc_purgeAndDelete;
							};
						};
						if (_x isKindOf "AllVehicles") exitWith {
							_deathTime = _x getVariable "A3EAI_deathTime";
							if (!isNil "_deathTime") then {
								if ((_currentTime - _deathTime) > MONITOR_VEHICLECLEANUP_FREQ) then {
									if (({isPlayer _x} count (_x nearEntities [[PLAYER_UNITS,"Air","LandVehicle"],60])) isEqualTo 0) then {
										if (({alive _x} count (crew _x)) isEqualTo 0) then {
											{
												if !(alive _x) then {
													_x call _fnc_purgeAndDelete;
												};
											} forEach (crew _x);
											_x call _fnc_purgeAndDelete;
										};
									};
								};
							} else {
								if !(alive _x) then {
									_x setVariable ["A3EAI_deathTime",_currentTime];
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
									_index = A3EAI_kryptoAreas find _kryptoArea;
									if (_index > -1) then {A3EAI_kryptoAreas deleteAt _index;};
									deleteVehicle _kryptoArea;
								};
								deleteVehicle _x;
								A3EAI_kryptoObjects deleteAt _forEachIndex;
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
									A3EAI_kryptoAreas deleteAt _forEachIndex;
								};
								if ((_currentTime - (_x getVariable ["A3EAI_kryptoGenTime",0])) > A3EAI_kryptoPickupAssist) exitWith {
									deleteVehicle (_x getVariable ["A3EAI_arrowObject",objNull]);
									deleteVehicle _x;
									A3EAI_kryptoAreas deleteAt _forEachIndex;
								};
							};
						} else {
							A3EAI_kryptoAreas deleteAt _forEachIndex;
						};
					};
					uiSleep 0.025;
				} forEach A3EAI_kryptoAreas;
			};
		} else {
			if (_canKillCleanupMain) then {
				terminate _cleanupMain; 
				diag_log "A3EAI terminated previous cleanupMain thread.";
			} else {
				_canKillCleanupMain = true;
				diag_log "A3EAI marked current cleanupMain thread for termination.";
			};
		};
		_cleanDead = _currentTime;
	};

	//Main location cleanup loop
	if ((_currentTime - _dynLocations) > MONITOR_LOCATIONCLEANUP_FREQ) then {
		if (scriptDone _cleanupLocations) then {
			if (_canKillCleanupLocations) then {_canKillCleanupLocations = false;};
			_cleanupLocations  = [_currentTime] spawn {
				_currentTime = _this select 0;
				A3EAI_areaBlacklists = A3EAI_areaBlacklists - [locationNull];
				{
					_deletetime = _x getVariable "deletetime"; 
					if (isNil "_deleteTime") then {_deleteTime = _currentTime}; //since _x getVariable ["deletetime",_currentTime] gives an error...
					//diag_log format ["DEBUG: CurrentTime: %1. Delete Time: %2",_currentTime,_deletetime];
					if (_currentTime > _deletetime) then {
						deleteLocation _x;
						A3EAI_areaBlacklists deleteAt _forEachIndex;
					};
					uiSleep 0.025;
				} forEach A3EAI_areaBlacklists;
			};
		} else {
			if (_canKillCleanupLocations) then {
				terminate _cleanupLocations; 
				diag_log "A3EAI terminated previous cleanupLocations thread.";
			} else {
				_canKillCleanupLocations = true;
				diag_log "A3EAI marked current cleanupLocations thread for termination.";
			};
		};
		_dynLocations = _currentTime;
	};

	if ((_currentTime - _checkRandomSpawns) > MONITOR_CHECK_RANDSPAWN_FREQ) then {
		if (scriptDone _cleanupRandomSpawns) then {
			if (_canKillRandomSpawns) then {_canKillRandomSpawns = false;};
			_cleanupRandomSpawns = [_currentTime] spawn {
				_currentTime = _this select 0;
				A3EAI_randTriggerArray = A3EAI_randTriggerArray - [objNull];
				{
					if ((((triggerStatements _x) select 1) != "") && {(_currentTime - (_x getVariable ["timestamp",_currentTime])) > RANDSPAWN_EXPIRY_TIME}) then {
						_triggerLocation = _x getVariable ["triggerLocation",locationNull];
						deleteLocation _triggerLocation;
						if (A3EAI_enableDebugMarkers) then {deleteMarker (str _x)};	
						deleteVehicle _x;
						A3EAI_randTriggerArray deleteAt _forEachIndex;
					};
					if ((_forEachIndex % 3) isEqualTo 0) then {uiSleep 0.05};
				} forEach A3EAI_randTriggerArray;
				_spawnsAvailable = A3EAI_maxRandomSpawns - (count A3EAI_randTriggerArray);
				if (_spawnsAvailable > 0) then {
					_nul = _spawnsAvailable spawn A3EAI_setup_randomspawns;
				};
			};
		} else {
			if (_canKillRandomSpawns) then {
				terminate _cleanupRandomSpawns; 
				diag_log "A3EAI terminated previous cleanupRandomSpawns thread.";
			} else {
				_canKillRandomSpawns = true;
				diag_log "A3EAI marked current cleanupRandomSpawns thread for termination.";
			};
		};
		_checkRandomSpawns = _currentTime;
	};
	
	if ((_currentTime - _playerCountTime) > MONITOR_UPDATE_PLAYER_COUNT_FREQ) then {
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
		if !((AI_GROUP_SIDE getFriend PLAYER_GROUP_SIDE1) isEqualTo 0) then {AI_GROUP_SIDE setFriend [PLAYER_GROUP_SIDE1, 0]};
		if !((AI_GROUP_SIDE getFriend PLAYER_GROUP_SIDE2) isEqualTo 0) then {AI_GROUP_SIDE setFriend [PLAYER_GROUP_SIDE2, 0]};
		if !((PLAYER_GROUP_SIDE2 getFriend AI_GROUP_SIDE) isEqualTo 0) then {PLAYER_GROUP_SIDE2 setFriend [AI_GROUP_SIDE, 0]};
		if !((PLAYER_GROUP_SIDE1 getFriend AI_GROUP_SIDE) isEqualTo 0) then {PLAYER_GROUP_SIDE1 setFriend [AI_GROUP_SIDE, 0]};
		if !((AI_GROUP_SIDE getFriend AI_GROUP_SIDE) isEqualTo 1) then {AI_GROUP_SIDE setFriend [AI_GROUP_SIDE, 1]};
		_sideCheck = _currentTime;
	};
	
	if (A3EAI_enableDebugMarkers) then {
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
	if ((A3EAI_monitorReportRate > 0) && {((_currentTime - _monitorReport) > A3EAI_monitorReportRate)}) then {
		_uptime = [] call _getUptime;
		diag_log format ["[A3EAI Monitor] [Uptime:%1:%2:%3][FPS:%4][Groups:%5][Respawn:%6][HC:%7]",_uptime select 0, _uptime select 1, _uptime select 2,round diag_fps,_activeGroupAmount,(count A3EAI_respawnQueue),A3EAI_HCIsConnected];
		diag_log format ["[A3EAI Monitor] [Static:%1][Dynamic:%2][Random:%3][Air:%4][Land:%5][UAV:%6][UGV:%7]",(count A3EAI_staticTriggerArray),(count A3EAI_dynTriggerArray),(count A3EAI_randTriggerArray),A3EAI_curHeliPatrols,A3EAI_curLandPatrols,A3EAI_curUAVPatrols,A3EAI_curUGVPatrols];
		_monitorReport = _currentTime;
	};

	uiSleep 30;
};
