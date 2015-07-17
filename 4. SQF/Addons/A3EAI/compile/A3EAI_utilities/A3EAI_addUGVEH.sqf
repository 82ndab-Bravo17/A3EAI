if (isNull _this) exitWith {};

_this addEventHandler ["Killed","_this call A3EAI_UGV_destroyed"];
_this addEventHandler ["HandleDamage","_this call A3EAI_handleDamageUGV"];

true