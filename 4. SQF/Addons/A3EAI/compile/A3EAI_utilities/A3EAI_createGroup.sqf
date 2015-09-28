#include "\A3EAI\globaldefines.hpp"

private["_unitGroup","_protect","_unitType"];
_unitType = _this select 0;

_unitGroup = createGroup AI_GROUP_SIDE;
if ((count _this) > 1) then {_unitGroup call A3EAI_protectGroup};
_unitGroup setVariable ["unitType",_unitType];
[_unitGroup,true] call A3EAI_updGroupCount;

_unitGroup