#include "\A3EAI\globaldefines.hpp"

private ["_unitGroup","_isNewGroup"];
_unitGroup = _this select 0;
_isNewGroup = _this select 1;

if (isNull _unitGroup) exitWith {false};

if (_isNewGroup) then {
	A3EAI_activeGroups pushBack _unitGroup;
} else {
	A3EAI_activeGroups = A3EAI_activeGroups - [_unitGroup,grpNull];
};

true