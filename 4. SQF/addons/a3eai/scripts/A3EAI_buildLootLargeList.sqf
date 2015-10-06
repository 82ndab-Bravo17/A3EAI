#include "\A3EAI\globaldefines.hpp"

private ["_startTime", "_lootListLarge1", "_lootListLarge2", "_lootListLarge", "_items", "_itemClassInfo", "_itemClassBias", "_itemClassType", "_item", "_itemSubClass", "_itemList", "_itemInfo", "_itemBias", "_itemType"];

_startTime = diag_tickTime;

_lootListLarge1 = [configFile >> "CfgLootTable" >> "GenericLarge","items",[]] call BIS_fnc_returnConfigEntry;
_lootListLarge2 = [configFile >> "CfgLootTable" >> "GenericAuto","items",[]] call BIS_fnc_returnConfigEntry;
_lootListLarge = _lootListLarge1 + _lootListLarge2;

_items = [];
{
	_itemClassInfo = _x select 0;
	_itemClassBias = _x select 1;
	_itemClassType = _itemClassInfo select 1;
	call {
		if (_itemClassType isEqualTo "magazine") exitWith {
			_item = _itemClassInfo select 0;
			_items pushBack _item;
		};
		if (_itemClassType isEqualTo "CfgLootTable") exitWith {
			_itemSubClass = _itemClassInfo select 0;
			_itemList = [configFile >> "CfgLootTable" >> _itemSubClass,"items",[]] call BIS_fnc_returnConfigEntry;
			{
				_itemInfo = _x select 0;
				_itemBias = _x select 1;
				_itemType = _itemInfo select 1;
				if (_itemType isEqualTo "magazine") then {
					_item = _itemInfo select 0;
					_items pushBack _item;
				};
			} forEach _itemList;
		};
	};
} forEach _lootListLarge;

if !(_items isEqualTo []) then {
	if !(A3EAI_dynamicLootBlacklist isEqualTo []) then {
		_items = _items - A3EAI_dynamicLootBlacklist;
	};
	A3EAI_MiscLoot2 = _items;
	if (A3EAI_debugLevel > 0) then {
		diag_log format ["A3EAI Debug: Generated %1 generic loot (large) classnames in %2 seconds.",(count _items),diag_tickTime - _startTime];
		if (A3EAI_debugLevel > 1) then {
			diag_log format ["A3EAI Debug: Contents of A3EAI_MiscLoot2: %1",A3EAI_MiscLoot2];
		};
	};
} else {
	diag_log "A3EAI Error: Could not dynamically generate loot (large) classname list. Classnames from A3EAI_config.sqf used instead.";
};

A3EAI_dynamicLootBlacklist = nil;
