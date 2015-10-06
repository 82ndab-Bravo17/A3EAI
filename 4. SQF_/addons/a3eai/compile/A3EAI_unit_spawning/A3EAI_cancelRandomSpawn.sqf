#include "\A3EAI\globaldefines.hpp"

private["_trigger","_triggerLocation"];
_trigger = _this;

[_trigger,"A3EAI_randTriggerArray"] call A3EAI_updateSpawnCount;
if (A3EAI_enableDebugMarkers) then {deleteMarker (str _trigger)};

_triggerLocation = _trigger getVariable "triggerLocation";
deleteLocation _triggerLocation;
deleteVehicle _trigger;

false
