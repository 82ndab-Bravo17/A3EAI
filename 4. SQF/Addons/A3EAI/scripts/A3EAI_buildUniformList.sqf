#include "\A3EAI\globaldefines.hpp"

private ["_startTime", "_uniformTypes", "_items", "_itemClassInfo", "_itemClassBias", "_itemClassType", "_itemClass", "_itemClasses", "_itemInfo", "_itemBias", "_itemType", "_item", "_itemSubClass", "_itemList", "_itemSubInfo", "_itemSubBias", "_itemSubType"];

_startTime = diag_tickTime;

_uniformTypes = [configFile >> "CfgLootTable" >> "Uniforms","items",[""]] call BIS_fnc_returnConfigEntry;
_items = [];
{
	_itemClassInfo = _x select 0;
	_itemClassBias = _x select 1;
	_itemClassType = _itemClassInfo select 1;
	if (_itemClassType isEqualTo "CfgLootTable") then {
		_itemClass = _itemClassInfo select 0;
		_itemClasses = [configFile >> "CfgLootTable" >> _itemClass,"items",[]] call BIS_fnc_returnConfigEntry;
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
		} forEach _itemClasses;
	};
} forEach _uniformTypes;

if !(_items isEqualTo []) then {
	if !(A3EAI_dynamicUniformBlacklist isEqualTo []) then {
		_items = _items - A3EAI_dynamicUniformBlacklist;
	};
	A3EAI_uniformTypes0 = _items;
	A3EAI_uniformTypes1 = +_items;
	A3EAI_uniformTypes2 = +_items;
	A3EAI_uniformTypes3 = +_items;
	if (A3EAI_debugLevel > 0) then {
		diag_log format ["A3EAI Debug: Generated %1 uniform classnames in %2 seconds.",(count _items),diag_tickTime - _startTime];
		if (A3EAI_debugLevel > 1) then {
			diag_log format ["A3EAI Debug: Contents of A3EAI_uniformTypes0: %1",A3EAI_uniformTypes0];
			diag_log format ["A3EAI Debug: Contents of A3EAI_uniformTypes1: %1",A3EAI_uniformTypes1];
			diag_log format ["A3EAI Debug: Contents of A3EAI_uniformTypes2: %1",A3EAI_uniformTypes2];
			diag_log format ["A3EAI Debug: Contents of A3EAI_uniformTypes3: %1",A3EAI_uniformTypes3];
		};
	};
} else {
	diag_log "A3EAI Error: Could not dynamically generate uniform classname list. Classnames from A3EAI_config.sqf used instead.";
};

A3EAI_dynamicUniformBlacklist = nil;
