#include "\A3EAI\globaldefines.hpp"

private ["_vehicle", "_hitSource", "_damage", "_unitGroup", "_aggroExpiry"];

_vehicle = _this select 0;
_hitSource = _this select 1;
_damage = _this select 2;

_unitGroup = _vehicle getVariable ["unitGroup",grpNull];

if (_unitGroup call A3EAI_getNoAggroStatus) exitWith {false};

if ((isPlayer _hitSource) && {_damage > 0.1} && {(combatMode _unitGroup isEqualTo "BLUE")}) then {
	_aggroExpiry = diag_tickTime + DEFENSIVE_AGGRESSION_TIME;
	_vehicle setVariable ["AggroTime",_aggroExpiry];
	[_unitGroup,"Behavior_Reset"] call A3EAI_forceBehavior;
	if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Defensive aggression enabled for %1 %2",_unitGroup,(typeOf _vehicle)];};
};

true
