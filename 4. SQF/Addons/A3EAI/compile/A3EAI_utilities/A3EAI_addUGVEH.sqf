if (isNull _this) exitWith {};

_this addEventHandler ["Killed","_this call A3EAI_UGV_destroyed"];
_this addEventHandler ["HandleDamage","_this call A3EAI_handleDamageUGV"];

if (A3EAI_UGVDetectOnly) then {
	_this addEventHandler ["Hit","_this call A3EAI_defensiveAggression"];
};

true