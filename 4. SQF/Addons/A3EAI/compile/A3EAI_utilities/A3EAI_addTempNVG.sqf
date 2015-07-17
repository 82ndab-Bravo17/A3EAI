if (_this hasWeapon "NVG_EPOCH") exitWith {false};
_this addWeapon "NVGoggles";

if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Generated temporary NVGs for AI %1.",_this];};

true