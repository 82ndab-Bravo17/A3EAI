private ["_objectMonitor","_object","_index"];
_object = _this;

_object call EPOCH_server_setVToken;
_object setVehicleLock "LOCKEDPLAYER";
_object enableCopilot false;

_index = A3EAI_monitoredObjects pushBack _object;

_index