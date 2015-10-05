#include "\A3EAI\globaldefines.hpp"

private ["_startTime", "_backpackList", "_items", "_itemClassInfo", "_itemClassBias", "_itemClassType", "_item", "_itemList", "_itemInfo", "_itemBias", "_itemType","_itemClass"];

_startTime = diag_tickTime;

_backpackList = [configFile >> "CfgLootTable" >> "Backpack","items",[]] call BIS_fnc_returnConfigEntry;
_items = [];
{
	_itemClassInfo = _x select 0;
	_itemClassBias = _x select 1;
	_itemClassType = _itemClassInfo select 1;
	call {
		if (_itemClassType isEqualTo "backpack") exitWith {
			_item = _itemClassInfo select 0;
			_items pushBack _item;
		};
		if (_itemClassType isEqualTo "CfgLootTable") exitWith {
			_itemClass = _itemClassInfo select 0;
			_itemList = [configFile >> "CfgLootTable" >> _itemClass,"items",[]] call BIS_fnc_returnConfigEntry;
			{
				_itemInfo = _x select 0;
				_itemBias = _x select 1;
				_itemType = _itemInfo select 1;
				if (_itemType isEqualTo "backpack") then {
					_item = _itemInfo select 0;
					_items pushBack _item;
				};
			} forEach _itemList;
		};
	};
} forEach _backpackList;

if !(_items isEqualTo []) then {
	if !(A3EAI_dynamicBackpackBlacklist isEqualTo []) then {
		_items = _items - A3EAI_dynamicBackpackBlacklist;
	};
	A3EAI_backpackTypes0 = _items;
	A3EAI_backpackTypes1 = +_items;
	A3EAI_backpackTypes2 = +_items;
	A3EAI_backpackTypes3 = +_items;
	if (A3EAI_debugLevel > 0) then {
		diag_log format ["A3EAI Debug: Generated %1 backpack classnames in %2 seconds.",(count _items),diag_tickTime - _startTime];
		if (A3EAI_debugLevel > 1) then {
			diag_log format ["A3EAI Debug: Contents of A3EAI_backpackTypes0: %1",A3EAI_backpackTypes0];
			diag_log format ["A3EAI Debug: Contents of A3EAI_backpackTypes1: %1",A3EAI_backpackTypes1];
			diag_log format ["A3EAI Debug: Contents of A3EAI_backpackTypes2: %1",A3EAI_backpackTypes2];
			diag_log format ["A3EAI Debug: Contents of A3EAI_backpackTypes3: %1",A3EAI_backpackTypes3];
		};
	};
} else {
	diag_log "A3EAI Error: Could not dynamically generate backpack classname list. Classnames from A3EAI_config.sqf used instead.";
};

A3EAI_dynamicBackpackBlacklist = nil;
