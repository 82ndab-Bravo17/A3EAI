#include "\A3EAI\globaldefines.hpp"

private ["_unitGroup", "_lootPool", "_updateServerLoot", "_pullChance", "_lootUnit", "_lootIndex", "_loot", "_unitLevel"];

_unitGroup = _this select 0;
_unitLevel = _this select 1;

_lootPool = _unitGroup getVariable ["LootPool",[]];
_updateServerLoot = (A3EAI_enableHC && {!isDedicated});
_pullChance = missionNamespace getVariable [format ["A3EAI_lootPullChance%1",_unitLevel],0.40];
if !(_lootPool isEqualTo []) then {
	if (_pullChance call A3EAI_chance) then {
		_lootUnit = (units _unitGroup) call A3EAI_selectRandom;
		_lootIndex = floor (random (count _lootPool));
		_loot = _lootPool select _lootIndex;
		if (alive _lootUnit) then {
			if ([_lootUnit,_loot] call A3EAI_addItem) then {
				_lootPool deleteAt _lootIndex;
				if (_updateServerLoot) then {
					[_unitGroup,_lootIndex] call A3EAI_updateServerLoot;
				};
				if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Pulled %1 from %2 loot pool (%3 items remain).",_loot,_unitGroup,(count _lootPool)];};
			};
		};
	};
};
_unitGroup setVariable ["lootGenTime",diag_tickTime];

true