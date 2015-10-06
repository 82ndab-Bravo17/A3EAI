#include "\A3EAI\globaldefines.hpp"

private ["_startTime", "_vestList", "_items", "_itemInfo", "_itemBias", "_itemType", "_item"];

_startTime = diag_tickTime;

_vestList = [configFile >> "CfgLootTable" >> "Vests","items",[]] call BIS_fnc_returnConfigEntry;
_items = [];
{
	_itemInfo = _x select 0;
	_itemBias = _x select 1;
	_itemType = _itemInfo select 1;
	call {
		if (_itemType isEqualTo "item") exitWith {
			_item = _itemInfo select 0;
			_items pushBack _item;
		};
		if (_itemType isEqualTo "CfgLootTable") exitWith {
			_itemSubClass = _itemInfo select 0;
			_itemList = [configFile >> "CfgLootTable" >> _itemSubClass,"items",[]] call BIS_fnc_returnConfigEntry;
			{
				_itemSubInfo = _x select 0;
				_itemSubBias = _x select 1;
				_itemSubType = _itemSubInfo select 1;
				if (_itemSubType isEqualTo "item") then {
					_item = _itemSubInfo select 0;
					_items pushBack _item;
				};
			} forEach _itemList;
		};
	};
} forEach _vestList;

if !(_items isEqualTo []) then {
	if !(A3EAI_dynamicVestBlacklist isEqualTo []) then {
		_items = _items - A3EAI_dynamicVestBlacklist;
	};
	A3EAI_vestTypes0 = _items;
	A3EAI_vestTypes1 = +_items;
	A3EAI_vestTypes2 = +_items;
	A3EAI_vestTypes3 = +_items;
	if (A3EAI_debugLevel > 0) then {
		diag_log format ["A3EAI Debug: Generated %1 vest classnames in %2 seconds.",(count _items),diag_tickTime - _startTime];
		if (A3EAI_debugLevel > 1) then {
			diag_log format ["A3EAI Debug: Contents of A3EAI_vestTypes0: %1",A3EAI_vestTypes0];
			diag_log format ["A3EAI Debug: Contents of A3EAI_vestTypes1: %1",A3EAI_vestTypes1];
			diag_log format ["A3EAI Debug: Contents of A3EAI_vestTypes2: %1",A3EAI_vestTypes2];
			diag_log format ["A3EAI Debug: Contents of A3EAI_vestTypes3: %1",A3EAI_vestTypes3];
		};
	};
} else {
	diag_log "A3EAI Error: Could not dynamically generate vest classname list. Classnames from A3EAI_config.sqf used instead.";
};
A3EAI_dynamicVestBlacklist = nil;

