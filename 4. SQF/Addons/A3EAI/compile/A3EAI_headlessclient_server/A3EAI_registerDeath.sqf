private ["_victim", "_killer", "_unitGroup", "_unitLevel"];

_victim = _this select 0;
_killer = _this select 1;

_victim setVariable ["A3EAI_deathTime",diag_tickTime];
_unitGroup = (group _victim);
_unitLevel = (_unitGroup getVariable ["unitLevel",0]);

if ((_unitGroup getVariable ["ReinforceAvailable",false]) && {isPlayer _killer} && {(A3EAI_airReinforcementSpawnChance select _unitLevel) call A3EAI_chance}) then {
	_unitGroup setVariable ["ReinforceAvailable",false];
	diag_log format ["Debug: Group %1 is calling reinforcements.",_unitGroup];
	_nul = [(getPosATL _victim),_unitLevel] spawn A3EAI_spawn_reinforcement;
};
