#include "\A3EAI\globaldefines.hpp"

if (isDedicated) then {
	private ["_respawnSleep","_nextRespawnTime","_mode","_unitLevelEffective","_promoteChance","_trigger"];
	_respawnSleep = 0;
	_nextRespawnTime = 0;
	_mode = _this select 0;

	call {
		if (_mode isEqualTo 0) exitWith {
			//Infantry AI respawn
			_trigger = _this select 1;	 //spawn area to respawn
			_unitGroup = _this select 2; //infantry group to respawn
			_fastMode = if ((count _this) > 3) then {_this select 3} else {false}; //shorter wait time if retrying a spawn
			
			if (isNull _trigger) then {_trigger = _unitGroup getVariable ["trigger",objNull];};
			_respawnSleep = _trigger getVariable ["respawnTime",(A3EAI_respawnTimeMin + (random A3EAI_respawnTimeVariance))];	//Calculate wait time for respawn. Respawn time may be individually defined for custom spawns.
			if (_fastMode) then {_respawnSleep = ADD_RESPAWN_FAST_TIME;};
			_nextRespawnTime = (diag_tickTime + _respawnSleep);	//Determine time of next respawn
			A3EAI_respawnQueue pushBack [diag_tickTime + _respawnSleep,_mode,_trigger,_unitGroup];
			_respawnLimit = _trigger getVariable ["respawnLimit",-1];
			if !(_respawnLimit isEqualTo 0) then {
				if (_respawnLimit > 0) then {_trigger setVariable ["respawnLimit",(_respawnLimit -1)];};
			};
			if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Added group %1 to respawn queue. Queue position %2. Wait Time %3 (respawnHandler)",_unitGroup,(count A3EAI_respawnQueue),_respawnSleep];};
		};
		if (_mode isEqualTo 1) exitWith {
			//Custom vehicle AI respawn
			_spawnParams = _this select 1;	//parameters used to call A3EAI_createVehicleSpawn
			_respawnSleep = if ((count _spawnParams) > 5) then {_spawnParams select 5} else {600};	//calculate respawn time
			
			_nextRespawnTime = (diag_tickTime + _respawnSleep);	//Determine time of next respawn
			A3EAI_respawnQueue pushBack [diag_tickTime + _respawnSleep,_mode,_spawnParams];
			if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Added custom AI vehicle %1 patrol to respawn queue. Queue position %2. Wait Time %3 (respawnHandler)",(_spawnParams select 1),(count A3EAI_respawnQueue),_respawnSleep];};
		};
		if (_mode isEqualTo 2) exitWith {
			//Vehicle patrol AI respawn
			_vehicleType = _this select 1;
			_fastMode = if ((count _this) > 2) then {_this select 2} else {false}; //shorter wait time if retrying a spawn
			
			if (_vehicleType isKindOf "Air") then {
				_respawnSleep = (A3EAI_respawnAirMinTime + random A3EAI_respawnTimeVarAir);
			} else {
				_respawnSleep = (A3EAI_respawnLandMinTime + random A3EAI_respawnTimeVarLand);
				if (_fastMode) then {_respawnSleep = (_respawnSleep/4) max 180};
			};
			_nextRespawnTime = (diag_tickTime + _respawnSleep);	//Determine time of next respawn
			A3EAI_respawnQueue pushBack [diag_tickTime + _respawnSleep,_mode,_vehicleType];
			if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Added AI vehicle patrol type %1 to respawn queue. Queue position %2. Wait Time %3 (respawnHandler)",_vehicleType,(count A3EAI_respawnQueue),_respawnSleep];};
		};
		if (_mode isEqualTo 3) exitWith {
			//UAV/UGV respawn
			_vehicleType = _this select 1;
			_fastMode = if ((count _this) > 2) then {_this select 2} else {false}; //shorter wait time if retrying a spawn
			
			if (_vehicleType isKindOf "Air") then {
				_respawnSleep = (A3EAI_respawnUAVMinTime + random A3EAI_respawnTimeVarUAV);
			} else {
				_respawnSleep = (A3EAI_respawnUGVMinTime + random A3EAI_respawnTimeVarUGV);
				if (_fastMode) then {_respawnSleep = (_respawnSleep/4) max 180};
			};
			_nextRespawnTime = (diag_tickTime + _respawnSleep);	//Determine time of next respawn
			A3EAI_respawnQueue pushBack [diag_tickTime + _respawnSleep,_mode,_vehicleType];
			if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Added unmanned vehicle patrol type %1 to respawn queue. Queue position %2. Wait Time %3 (respawnHandler)",_vehicleType,(count A3EAI_respawnQueue),_respawnSleep];};
		};
	};

	if (!isNil "A3EAI_respawnActive") exitWith {}; 			//If the first respawn has already occured, no need to modify the initial wait time.

	if (!isNil "A3EAI_nextRespawnTime") then {
		if (_nextRespawnTime < A3EAI_nextRespawnTime) then {	//If the newest respawn is scheduled to happen sooner than the next closest respawn, reduce the initial wait time appropriately.
			A3EAI_nextRespawnTime = _nextRespawnTime;		//Time of next spawn
			if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Decreased time to next respawn to %1 seconds.",_respawnSleep];};
		};
	} else {
		A3EAI_nextRespawnTime = _nextRespawnTime;
		if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Time to first respawn set to %1 seconds.",_respawnSleep];};
	};

	if (!isNil "A3EAI_queueActive") exitWith {};
	A3EAI_queueActive = true;							//The respawn queue is established, so don't create another one until it's finished.
	A3EAI_addRespawnQueueHandle = [] spawn A3EAI_processRespawn;
} else {
	A3EAI_respawnGroup_PVS = _this;
	publicVariableServer "A3EAI_respawnGroup_PVS";
};

true
