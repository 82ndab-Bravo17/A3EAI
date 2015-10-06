#include "\A3EAI\globaldefines.hpp"

if !((typeName _this) isEqualTo "ARRAY") exitWith {diag_log format ["Error: Wrong arguments sent to %1.",__FILE__]};
if (A3EAI_customVehicleSpawnQueue isEqualTo []) then {
	A3EAI_customVehicleSpawnQueue pushBack _this;
	_vehicleQueue = [] spawn {
		if (isNil "EPOCH_server_setVToken") then {waitUntil {uiSleep 0.3; !(isNil "EPOCH_server_setVToken")};};
		while {!(A3EAI_customVehicleSpawnQueue isEqualTo [])} do {
			_vehicleType = (A3EAI_customVehicleSpawnQueue select 0) select 2;
			if (!(_vehicleType isKindOf "StaticWeapon") && {[_vehicleType,"vehicle"] call A3EAI_checkClassname}) then {
				(A3EAI_customVehicleSpawnQueue select 0) call A3EAI_spawnVehicleCustom;
			} else {
				diag_log format ["A3EAI Error: %1 attempted to spawn unsupported vehicle type %2.",__FILE__,_vehicleType];
			};
			A3EAI_customVehicleSpawnQueue deleteAt 0;
			uiSleep 2;
		};
	};
} else {
	A3EAI_customVehicleSpawnQueue pushBack _this;
};
