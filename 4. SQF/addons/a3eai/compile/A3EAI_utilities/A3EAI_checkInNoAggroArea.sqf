#include "\A3EAI\globaldefines.hpp"

private ["_inNoAggroArea", "_objectPos", "_noAggroDistance"];

_objectPos = _this select 0;
_noAggroRange = [_this,1,900] call A3EAI_param;

if ((typeName _objectPos) isEqualTo "OBJECT") then {_objectPos = getPosATL _objectPos};

_inNoAggroArea = false;
{
	if (((position _x) distance2D _objectPos) < _noAggroRange) exitWith {
		_inNoAggroArea = true;
	};
} count A3EAI_noAggroAreas;

_inNoAggroArea
