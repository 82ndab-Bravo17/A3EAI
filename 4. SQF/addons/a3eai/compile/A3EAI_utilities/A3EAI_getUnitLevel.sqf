#include "\A3EAI\globaldefines.hpp"

private ["_indexWeighted","_unitLevelIndexTable"];
_unitLevelIndexTable = _this;

_indexWeighted = call {
	if (_unitLevelIndexTable isEqualTo "airvehicle") exitWith {A3EAI_levelIndicesAir};
	if (_unitLevelIndexTable isEqualTo "landvehicle") exitWith {A3EAI_levelIndicesLand};
	if (_unitLevelIndexTable isEqualTo "uav") exitWith {A3EAI_levelIndicesUAV};
	if (_unitLevelIndexTable isEqualTo "ugv") exitWith {A3EAI_levelIndicesUGV};
	[0]
};
	
A3EAI_unitLevels select (_indexWeighted call A3EAI_selectRandom)