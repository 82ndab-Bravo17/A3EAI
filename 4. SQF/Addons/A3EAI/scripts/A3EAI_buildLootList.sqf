#include "\A3EAI\globaldefines.hpp"

private ["_startTime", "_lootList1", "_lootList2", "_items", "_itemClassInfo", "_itemClassBias", "_itemClassType", "_item", "_itemSubClass", "_itemSubClasses", "_itemInfo", "_itemBias", "_itemType"];

_startTime = diag_tickTime;

_lootList1 = [configFile >> "CfgLootTable" >> "Generic","items",[]] call BIS_fnc_returnConfigEntry;
_lootList2 = [configFile >> "CfgLootTable" >> "GenericBed","items",[]] call BIS_fnc_returnConfigEntry;
_lootList1 append _lootList2;

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
			_itemSubClasses = [configFile >> "CfgLootTable" >> _itemSubClass,"items",[]] call BIS_fnc_returnConfigEntry;
			{
				_itemInfo = _x select 0;
				_itemBias = _x select 1;
				_itemType = _itemInfo select 1;
				if (_itemType isEqualTo "magazine") then {
					_item = _itemInfo select 0;
					_items pushBack _item;
				};
			} forEach _itemSubClasses;
		};
	};
} forEach _lootList1;

if !(_items isEqualTo []) then {
	if !(A3EAI_dynamicLootBlacklist isEqualTo []) then {
		_items = _items - A3EAI_dynamicLootBlacklist;
	};
	A3EAI_MiscLoot1 = _items;
	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Generated %1 generic loot classnames in %2 seconds.",(count _items),diag_tickTime - _startTime];
		if (A3EAI_debugLevel > 1) then {
			diag_log format ["A3EAI Debug: Contents of A3EAI_MiscLoot1: %1",A3EAI_MiscLoot1];
		};
	};
} else {
	diag_log "A3EAI Error: Could not dynamically generate loot classname list. Classnames from A3EAI_config.sqf used instead.";
};

//A3EAI_dynamicLootBlacklist is nil'ed in buildLootLargeList