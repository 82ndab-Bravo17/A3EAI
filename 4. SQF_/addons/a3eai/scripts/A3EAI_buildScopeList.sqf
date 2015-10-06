#include "\A3EAI\globaldefines.hpp"

private ["_startTime", "_scopeList", "_items", "_itemClassInfo", "_itemClassBias", "_itemClassType", "_itemList", "_itemInfo", "_itemBias", "_itemType", "_item","_itemClass"];

_startTime = diag_tickTime;

_scopeList = [configFile >> "CfgLootTable" >> "Scopes","items",[]] call BIS_fnc_returnConfigEntry;
_items = [];
{
	_itemClassInfo = _x select 0;
	_itemClassBias = _x select 1;
	_itemClassType = _itemClassInfo select 1;
	call {
		if (_itemClassType isEqualTo "CfgLootTable") exitWith {
			_itemClass = _itemClassInfo select 0;
			_itemList = [configFile >> "CfgLootTable" >> _itemClass,"items",[]] call BIS_fnc_returnConfigEntry;
			{
				_itemInfo = _x select 0;
				_itemBias = _x select 1;
				_itemType = _itemInfo select 1;
				if (_itemType isEqualTo "item") then {
					_item = _itemInfo select 0;
					if !(isClass (configfile >> "CfgWeapons" >> _item >> "ItemInfo" >> "OpticsModes" >> "TWS")) then {
						_items pushBack _item;
					};
				};
			} forEach _itemList;
		};
		if (_itemClassType isEqualTo "item") exitWith {
			_item = _itemClassInfo select 0;
			if !(isClass (configfile >> "CfgWeapons" >> _item >> "ItemInfo" >> "OpticsModes" >> "TWS")) then {
				_items pushBack _item;
			};
		};
	};
} forEach _scopeList;

if !(_items isEqualTo []) then {
	if !(A3EAI_dynamicOpticsBlacklist isEqualTo []) then {
		_items = _items - A3EAI_dynamicOpticsBlacklist;
	};
	A3EAI_weaponOpticsList = _items;
	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Generated %1 weapon optics classnames in %2 seconds.",(count _items),diag_tickTime - _startTime];
		if (A3EAI_debugLevel > 1) then {
			diag_log format ["A3EAI Debug: Contents of A3EAI_weaponOpticsList: %1",A3EAI_weaponOpticsList];
		};
	};
} else {
	diag_log "A3EAI Error: Could not dynamically generate weapon optics classname list. Classnames from A3EAI_config.sqf used instead.";
};

A3EAI_dynamicOpticsBlacklist = nil;
