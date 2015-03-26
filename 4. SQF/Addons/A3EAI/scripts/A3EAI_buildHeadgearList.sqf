private ["_startTime", "_itemList", "_items", "_itemClassInfo", "_itemClassBias", "_itemClassType", "_itemInfo", "_itemBias", "_itemType", "_item","_itemClass", "_headgearList"];

_startTime = diag_tickTime;

_headgearList = [configFile >> "CfgLootTable" >> "Headgear","items",[]] call BIS_fnc_returnConfigEntry;
_items = [];
{
	_itemClassInfo = _x select 0;
	_itemClassBias = _x select 1;
	_itemClassType = _itemClassInfo select 1;
	if (_itemClassType isEqualTo "CfgLootTable") then {
		_itemClass = _itemClassInfo select 0;
		_itemList = [configFile >> "CfgLootTable" >> _itemClass,"items",[]] call BIS_fnc_returnConfigEntry;
		{
			_itemInfo = _x select 0;
			_itemBias = _x select 1;
			_itemType = _itemInfo select 1;
			if (_itemType isEqualTo "item") then {
				_item = _itemInfo select 0;
				_items pushBack _item;
			};
		} forEach _itemList;
	};
} forEach _headgearList;

if !(_items isEqualTo []) then {
	A3EAI_headgearTypes0 = _items;
	A3EAI_headgearTypes1 = +_items;
	A3EAI_headgearTypes2 = +_items;
	A3EAI_headgearTypes3 = +_items;
	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Generated %1 headgear classnames in %2 seconds.",(count _items),diag_tickTime - _startTime]};
} else {
	diag_log "A3EAI Error: Could not dynamically generate headgear classname list. Classnames from A3EAI_config.sqf used instead.";
};
