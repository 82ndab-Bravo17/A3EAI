private ["_unitGroup", "_vehicle", "_lastAggro"];

_unitGroup = _this select 0;
_vehicle = _this select 1;

if (A3EAI_UAVDetectOnly) then {
	_lastAggro = _vehicle getVariable "AggroTime";
	if (isNil "AggroTime") then {
		_lastAggro = diag_tickTime - 180;
		_vehicle setVariable ["AggroTime",0];
	};

	if ((diag_tickTime - _lastAggro) > 180) then {
		if ((combatMode _unitGroup) isEqualTo "YELLOW") then {
			[_unitGroup,"IgnoreEnemies"] call A3EAI_forceBehavior;
			if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Reset Group %1 %2 UAV to non-hostile mode.",_unitGroup,(typeOf _vehicle)]};
		};
	};
} else {
	_this call A3EAI_checkInNoAggroArea;
};
