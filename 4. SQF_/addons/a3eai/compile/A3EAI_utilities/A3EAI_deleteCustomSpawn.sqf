#include "\A3EAI\globaldefines.hpp"

private ["_trigger","_triggerType"];

_trigger = call {
	_triggerType = (typeName _this);
	if (_triggerType isEqualTo "OBJECT") exitWith {
		_this
	};
	if (_triggerType isEqualTo "GROUP") exitWith {
		_this getVariable ["trigger",objNull]
	};
	_this
};

if (A3EAI_enableDebugMarkers) then {deleteMarker str(_trigger)};
_trigger setTriggerStatements ["this","true","false"]; //Disable trigger from activating or deactivating while cleanup is performed
if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Deleting custom-defined AI spawn %1 at %2 in 30 seconds.",triggerText _trigger, mapGridPosition _trigger];};
uiSleep 30;
{
	_x setVariable ["GroupSize",-1];
	if (A3EAI_HCIsConnected) then {
		A3EAI_updateGroupSize_PVC = [_x,-1];
		A3EAI_HCObjectOwnerID publicVariableClient "A3EAI_updateGroupSize_PVC";
	};
} forEach (_trigger getVariable ["GroupArray",[]]);
//deleteMarker (_trigger getVariable ["spawnmarker",""]);
[_trigger,"A3EAI_staticTriggerArray"] call A3EAI_updateSpawnCount;

if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Deleting custom-defined AI spawn %1 at %2.",triggerText _trigger, mapGridPosition _trigger];};

deleteVehicle _trigger;

true