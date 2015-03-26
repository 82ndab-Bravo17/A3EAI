private ["_unitGroup", "_vehicle", "_targetPlayer", "_cargoAvailable", "_paraGroup", "_startPos"];

_unitGroup = _this select 0;
_vehicle = _this select 1;
_targetPlayer = _this select 2;

if (surfaceIsWater (getPosATL _vehicle)) exitWith {};
_cargoAvailable = (_vehicle emptyPositions "cargo") min A3EAI_paraDropAmount;
if (_cargoAvailable > 0) then {
	if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: %1 group %2 has enough cargo positions for successful paradrop. Spawning new group ...",typeOf _vehicle,_unitGroup];};
	
	_nul = _vehicle spawn {
		_this allowDamage false;
		uiSleep 5;
		_this allowDamage true;
	};
	
	if (isDedicated) then {
		[_vehicle,_targetPlayer] call A3EAI_addParaGroup;
	} else {
		A3EAI_addParaGroup_PVS = [_vehicle,_targetPlayer];
		publicVariableServer "A3EAI_addParaGroup_PVS";
	};
	
	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Paradrop group %1 with %2 units deployed at %3 by %4 group %5.",_paraGroup,_cargoAvailable,_startPos,typeOf _vehicle,_unitGroup];};
};
