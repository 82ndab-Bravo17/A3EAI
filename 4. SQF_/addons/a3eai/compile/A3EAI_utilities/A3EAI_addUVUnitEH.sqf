#include "\A3EAI\globaldefines.hpp"

if (isNull _this) exitWith {};

_this addEventHandler ["Killed","_this call A3EAI_handle_death_UV;"];

true