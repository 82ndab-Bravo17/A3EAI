#include "\A3EAI\globaldefines.hpp"

private ["_unitGroup", "_vehicle","_inNoAggroArea","_result"];

_unitGroup = _this select 0;
_vehicle = _this select 1;

_inArea = _vehicle call A3EAI_checkInNoAggroArea;
_result = [_unitGroup,_inArea] call A3EAI_noAggroAreaToggle;

true