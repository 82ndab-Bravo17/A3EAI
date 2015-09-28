#include "\A3EAI\globaldefines.hpp"

private ["_unitGroup", "_unitType", "_fnc_execEveryLoop", "_fnc_checkUnits", "_fnc_generateLoot", "_fnc_vehicleAmmoFuelCheck", "_fnc_antistuck"];

_unitGroup = _this select 0;
_unitType = _this select 1;

call {
	if (_unitType isEqualTo "static") exitWith {
		_fnc_execEveryLoop = A3EAI_execEveryLoop_infantry;
		_fnc_checkUnits = A3EAI_checkGroupUnits;
		_fnc_generateLoot = A3EAI_generateGroupLoot;
		_fnc_vehicleAmmoFuelCheck = {};
		_fnc_antistuck = A3EAI_antistuck_generic;
	};
	if (_unitType isEqualTo "random") exitWith {
		_fnc_execEveryLoop = A3EAI_execEveryLoop_infantry;
		_fnc_checkUnits = A3EAI_checkGroupUnits;
		_fnc_generateLoot = A3EAI_generateGroupLoot;
		_fnc_vehicleAmmoFuelCheck = {};
		_fnc_antistuck = A3EAI_antistuck_generic;
	};
	if (_unitType isEqualTo "dynamic") exitWith {
		_fnc_execEveryLoop = A3EAI_execEveryLoop_infantry;
		_fnc_checkUnits = A3EAI_checkGroupUnits;
		_fnc_generateLoot = A3EAI_generateGroupLoot;
		_fnc_vehicleAmmoFuelCheck = {};
		_fnc_antistuck = A3EAI_antistuck_generic;
	};
	if (_unitType isEqualTo "air") exitWith {
		_fnc_execEveryLoop = A3EAI_execEveryLoop_air;
		_fnc_checkUnits = {};
		_fnc_generateLoot = A3EAI_generateGroupLoot;
		_fnc_vehicleAmmoFuelCheck = A3EAI_checkAmmoFuel;
		_fnc_antistuck = A3EAI_antistuck_air;
	};
	if (_unitType isEqualTo "land") exitWith {
		_fnc_execEveryLoop = A3EAI_execEveryLoop_vehicle;
		_fnc_checkUnits = A3EAI_checkGroupUnits;
		_fnc_generateLoot = A3EAI_generateGroupLoot;
		_fnc_vehicleAmmoFuelCheck = A3EAI_checkAmmoFuel;
		_fnc_antistuck = A3EAI_antistuck_land;
	};
	if (_unitType isEqualTo "uav") exitWith {
		_fnc_execEveryLoop = A3EAI_execEveryLoop_uav;
		_fnc_checkUnits = {};
		_fnc_generateLoot = {};
		_fnc_vehicleAmmoFuelCheck = A3EAI_checkAmmoFuel;
		_fnc_antistuck = A3EAI_antistuck_uav;
	};
	if (_unitType isEqualTo "ugv") exitWith {
		_fnc_execEveryLoop = A3EAI_execEveryLoop_ugv;
		_fnc_checkUnits = {};
		_fnc_generateLoot = {};
		_fnc_vehicleAmmoFuelCheck = A3EAI_checkAmmoFuel;
		_fnc_antistuck = A3EAI_antistuck_ugv;
	};
	if (_unitType isEqualTo "air_reinforce") exitWith {
		_fnc_execEveryLoop = {};
		_fnc_checkUnits = {};
		_fnc_generateLoot = {};
		_fnc_vehicleAmmoFuelCheck = {};
		_fnc_antistuck = {};
	};
	if (_unitType isEqualTo "vehiclecrew") exitWith {
		_fnc_execEveryLoop = A3EAI_execEveryLoop_infantry;
		_fnc_checkUnits = A3EAI_checkGroupUnits;
		_fnc_generateLoot = A3EAI_generateGroupLoot;
		_fnc_vehicleAmmoFuelCheck = {};
		_fnc_antistuck = A3EAI_antistuck_generic;
	};
	if (_unitType isEqualTo "staticcustom") exitWith {
		_fnc_execEveryLoop = {};
		_fnc_checkUnits = A3EAI_checkGroupUnits;
		_fnc_generateLoot = A3EAI_generateGroupLoot;
		_fnc_vehicleAmmoFuelCheck = {};
		_fnc_antistuck = A3EAI_antistuck_generic;
	};
	if (_unitType isEqualTo "aircustom") exitWith {
		_fnc_execEveryLoop = {};
		_fnc_checkUnits = {};
		_fnc_generateLoot = A3EAI_generateGroupLoot;
		_fnc_vehicleAmmoFuelCheck = A3EAI_checkAmmoFuel;
		_fnc_antistuck = A3EAI_antistuck_aircustom;
	};
	if (_unitType isEqualTo "landcustom") exitWith {
		_fnc_execEveryLoop = A3EAI_execEveryLoop_vehicle;
		_fnc_checkUnits = A3EAI_checkGroupUnits;
		_fnc_generateLoot = A3EAI_generateGroupLoot;
		_fnc_vehicleAmmoFuelCheck = A3EAI_checkAmmoFuel;
		_fnc_antistuck = A3EAI_antistuck_generic;
	};
	
	_fnc_execEveryLoop = {};
	_fnc_checkUnits = {};
	_fnc_generateLoot = {};
	_fnc_vehicleAmmoFuelCheck = {};
	_fnc_antistuck = {};
	
	diag_log format ["A3EAI Warning: Group functions for unit type %1 not found.",_unitType];
};

[_fnc_execEveryLoop,_fnc_checkUnits,_fnc_generateLoot,_fnc_vehicleAmmoFuelCheck,_fnc_antistuck]