private ["_unitGroup", "_vehicle", "_lastRegroupCheck"];

_unitGroup = _this select 0;
_vehicle = _this select 1;

_lastRegroupCheck = _vehicle getVariable "LastRegroupCheck";
if (isNil "_lastRegroupCheck") then {
	_lastRegroupCheck = diag_tickTime;
	_vehicle setVariable ["LastRegroupCheck",0];
};

if ((diag_tickTime - _lastRegroupCheck) < 30) exitWith {false};

if ((alive _vehicle) && {_unitGroup getVariable ["regrouped",true]} && {({if ((_x distance _vehicle) > 175) exitWith {1}} count (assignedCargo _vehicle)) > 0}) then {
	_unitGroup setVariable ["regrouped",false];
	[_unitGroup,_vehicle] call A3EAI_vehCrewRegroup;
};

_vehicle setVariable ["LastRegroupCheck",diag_tickTime];

true