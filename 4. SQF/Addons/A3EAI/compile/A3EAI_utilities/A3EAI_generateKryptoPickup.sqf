private ["_kryptoDevice","_kryptoPos","_kryptoPickup"];

_kryptoDevice = _this select 0;
_kryptoPos = _this select 1;

if (isNull _kryptoDevice) exitWith {};

_kryptoPickup = createTrigger ["EmptyDetector",_kryptoPos,false];
_kryptoPickup setTriggerArea [2, 2, 0, false];
_kryptoPickup setTriggerActivation ["ANY", "PRESENT", true];
_kryptoPickup setTriggerTimeout [10, 10, 10, true];
_kryptoPickup setTriggerStatements ["{if (isPlayer _x) exitWith {1}} count thisList > 0;","[thisList,thisTrigger] call A3EAI_activateKryptoPickup;",""];

_kryptoPickup attachTo [_kryptoDevice,[0,0,0]];

_kryptoPickup setVariable ["A3EAI_kryptoGenTime",diag_tickTime];
_kryptoPickup setVariable ["A3EAI_kryptoObject",_kryptoDevice];

A3EAI_kryptoAreas pushBack _kryptoPickup;

if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Generated krypto pickup assist area at %1.",_kryptoPos];};

_kryptoPickup