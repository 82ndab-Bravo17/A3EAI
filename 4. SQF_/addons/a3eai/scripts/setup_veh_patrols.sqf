#include "\A3EAI\globaldefines.hpp"

waitUntil {uiSleep 0.3; (!isNil "A3EAI_locations_ready" && {!isNil "A3EAI_classnamesVerified"} && {!(isNil "EPOCH_server_setVToken")})};

if (A3EAI_maxAirPatrols > 0) then {
	_nul = [] spawn {
		for "_i" from 0 to ((count A3EAI_airVehicleList) - 1) do {
			_currentElement = (A3EAI_airVehicleList select _i);
			if ((typeName _currentElement) isEqualTo "ARRAY") then {
				_heliType = _currentElement select 0;
				_amount = _currentElement select 1;
				
				if ([_heliType,"vehicle"] call A3EAI_checkClassname) then {
					for "_j" from 1 to _amount do {
						A3EAI_heliTypesUsable pushBack _heliType;
					};
				} else {
					if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: %1 attempted to spawn invalid vehicle type %2.",__FILE__,_heliType];};
				};
			} else {
				diag_log "A3EAI Error: Non-array element found in A3EAI_airVehicleList. Please see default configuration file for proper format.";
			};
		};
		
		if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Assembled helicopter list: %1",A3EAI_heliTypesUsable];};
		
		_maxHelis = (A3EAI_maxAirPatrols min (count A3EAI_heliTypesUsable));
		for "_i" from 1 to _maxHelis do {
			_index = floor (random (count A3EAI_heliTypesUsable));
			_heliType = A3EAI_heliTypesUsable select _index;
			_nul = _heliType spawn A3EAI_spawnVehiclePatrol;
			A3EAI_heliTypesUsable deleteAt _index;
			if (_i < _maxHelis) then {uiSleep 20};
		};
	};
	uiSleep 5;
};

if (A3EAI_maxLandPatrols > 0) then {
	_nul = [] spawn {
		for "_i" from 0 to ((count A3EAI_landVehicleList) - 1) do {
			_currentElement = (A3EAI_landVehicleList select _i);
			if ((typeName _currentElement) isEqualTo "ARRAY") then {
				_vehType = _currentElement select 0;
				_amount = _currentElement select 1;
				
				if ([_vehType,"vehicle"] call A3EAI_checkClassname) then {
					for "_j" from 1 to _amount do {
						A3EAI_vehTypesUsable pushBack _vehType;
					};
				} else {
					if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: %1 attempted to spawn invalid vehicle type %2.",__FILE__,_vehType];};
				};
			} else {
				diag_log "A3EAI Error: Non-array element found in A3EAI_landVehicleList. Please see default configuration file for proper format.";
			};
		};
		
		if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Assembled vehicle list: %1",A3EAI_vehTypesUsable];};
		
		_maxVehicles = (A3EAI_maxLandPatrols min (count A3EAI_vehTypesUsable));
		for "_i" from 1 to _maxVehicles do {
			_index = floor (random (count A3EAI_vehTypesUsable));
			_vehType = A3EAI_vehTypesUsable select _index;
			_nul = _vehType spawn A3EAI_spawnVehiclePatrol;
			A3EAI_vehTypesUsable deleteAt _index;
			if (_i < _maxVehicles) then {uiSleep 20};
		};
	};
};

if (A3EAI_maxUAVPatrols > 0) then {
	_nul = [] spawn {
		for "_i" from 0 to ((count A3EAI_UAVList) - 1) do {
			_currentElement = (A3EAI_UAVList select _i);
			if ((typeName _currentElement) isEqualTo "ARRAY") then {
				_vehType = _currentElement select 0;
				_amount = _currentElement select 1;
				
				if ([_vehType,"vehicle"] call A3EAI_checkClassname) then {
					for "_j" from 1 to _amount do {
						A3EAI_UAVTypesUsable pushBack _vehType;
					};
				} else {
					if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: %1 attempted to spawn invalid vehicle type %2.",__FILE__,_vehType];};
				};
			} else {
				diag_log "A3EAI Error: Non-array element found in A3EAI_UAVList. Please see default configuration file for proper format.";
			};
		};
		
		if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Assembled UAV list: %1",A3EAI_UAVTypesUsable];};
		
		_maxVehicles = (A3EAI_maxUAVPatrols min (count A3EAI_UAVTypesUsable));
		for "_i" from 1 to _maxVehicles do {
			_index = floor (random (count A3EAI_UAVTypesUsable));
			_vehType = A3EAI_UAVTypesUsable select _index;
			_vehicleClass = [configFile >> "CfgVehicles" >> _vehType,"vehicleClass",""] call BIS_fnc_returnConfigEntry;
			_nul = _vehType spawn A3EAI_spawn_UV_patrol;
			A3EAI_UAVTypesUsable deleteAt _index;
			if (_i < _maxVehicles) then {uiSleep 20};
		};
	};
};

if (A3EAI_maxUGVPatrols > 0) then {
	_nul = [] spawn {
		for "_i" from 0 to ((count A3EAI_UGVList) - 1) do {
			_currentElement = (A3EAI_UGVList select _i);
			if ((typeName _currentElement) isEqualTo "ARRAY") then {
				_vehType = _currentElement select 0;
				_amount = _currentElement select 1;
				
				if ([_vehType,"vehicle"] call A3EAI_checkClassname) then {
					for "_j" from 1 to _amount do {
						A3EAI_UGVTypesUsable pushBack _vehType;
					};
				} else {
					if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: %1 attempted to spawn invalid vehicle type %2.",__FILE__,_vehType];};
				};
			} else {
				diag_log "A3EAI Error: Non-array element found in A3EAI_UGVList. Please see default configuration file for proper format.";
			};
		};
		
		if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Assembled UGV list: %1",A3EAI_UGVTypesUsable];};
		
		_maxVehicles = (A3EAI_maxUGVPatrols min (count A3EAI_UGVTypesUsable));
		for "_i" from 1 to _maxVehicles do {
			_index = floor (random (count A3EAI_UGVTypesUsable));
			_vehType = A3EAI_UGVTypesUsable select _index;
			_nul = _vehType spawn A3EAI_spawn_UV_patrol;
			A3EAI_UGVTypesUsable deleteAt _index;
			if (_i < _maxVehicles) then {uiSleep 20};
		};
	};
};
