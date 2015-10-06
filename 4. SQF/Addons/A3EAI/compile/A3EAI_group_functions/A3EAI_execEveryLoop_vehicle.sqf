#include "\A3EAI\globaldefines.hpp"

private ["_unitGroup", "_vehicle", "_lastRegroupCheck","_inNoAggroArea","_inArea","_result"];

_unitGroup = _this select 0;
_vehicle = _this select 1;

_inArea = (leader _unitGroup) call A3EAI_checkInNoAggroArea;
_result = [_unitGroup,_inArea] call A3EAI_noAggroAreaToggle;

_lastRegroupCheck = _vehicle getVariable "LastRegroupCheck";
if (isNil "_lastRegroupCheck") then {
	_lastRegroupCheck = diag_tickTime;
	_vehicle setVariable ["LastRegroupCheck",0];
};

if ((diag_tickTime - _lastRegroupCheck) > 30) then {
	if ((alive _vehicle) && {_unitGroup getVariable ["regrouped",true]} && {({if ((_x distance2D _vehicle) > REGROUP_VEHICLEGROUP_DIST) exitWith {1}} count (assignedCargo _vehicle)) > 0}) then {
		_unitGroup setVariable ["regrouped",false];
		[_unitGroup,_vehicle] call A3EAI_vehCrewRegroup;
	};

	_vehicle setVariable ["LastRegroupCheck",diag_tickTime];
};

true