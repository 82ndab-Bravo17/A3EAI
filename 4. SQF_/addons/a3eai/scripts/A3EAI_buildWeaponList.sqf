#include "\A3EAI\globaldefines.hpp"

private ["_startTime", "_checkWeapon", "_magazineTypes", "_cursorAim", "_ammo", "_ammoHit", "_buildWeaponList", "_pistolList", "_rifleList", "_machinegunList", "_sniperList"];

_startTime = diag_tickTime;

if (isNil "A3EAI_dynamicWeaponBlacklist") then {A3EAI_dynamicWeaponBlacklist = [];};

_checkWeapon = 
{
	private ["_magazineTypes","_ammo","_ammoMaxRange","_ammoHit"];
	if ((typeName _this) != "STRING") exitWith {false};
	if (_this in A3EAI_dynamicWeaponBlacklist) exitWith {false};
	_magazineTypes = [configFile >> "CfgWeapons" >> _this,"magazines",[]] call BIS_fnc_returnConfigEntry;
	if (_magazineTypes isEqualTo []) exitWith {false};
	_cursorAim = [configFile >> "CfgWeapons" >> _this,"cursorAim","throw"] call BIS_fnc_returnConfigEntry;
	if (_cursorAim isEqualTo "throw") exitWith {false};
	_ammo = [configFile >> "CfgMagazines" >> (_magazineTypes select 0),"ammo",""] call BIS_fnc_returnConfigEntry;
	if (_ammo isEqualTo "") exitWith {false};
	_ammoHit = [configFile >> "CfgAmmo" >> _ammo,"hit",0] call BIS_fnc_returnConfigEntry;
	if (_ammoHit isEqualTo 0) exitWith {false};
	true
};

_buildWeaponList = {
	private ["_items", "_itemClassInfo", "_itemClassBias", "_itemClassType", "_weapon", "_itemClass", "_itemList"];
	_items = [];
	
	{
		_itemClassInfo = (_x select 0);
		_itemClassBias = (_x select 1);
		_itemClassType = _itemClassInfo select 1;
		call {
			if (_itemClassType isEqualTo "weapon") exitWith {
				_item = _itemClassInfo select 0;
				if (_item call _checkWeapon) then {
					_items pushBack _item;
				};
			};
			if (_itemClassType isEqualTo "CfgLootTable") exitWith {
				_itemClass = _itemClassInfo select 0;
				_itemList = [configFile >> "CfgLootTable" >> _itemClass,"items",[]] call BIS_fnc_returnConfigEntry;
				{
					_itemInfo = (_x select 0);
					_itemBias = (_x select 1);
					_itemType = _itemInfo select 1;
					if (_itemType isEqualTo "weapon") then {
						_item = _itemInfo select 0;
						if (_item call _checkWeapon) then {
							_items pushBack _item;
						};
					};
				} forEach _itemList;
			};
		};
	} forEach _this;
	
	_items
};

_pistolList = [configFile >> "CfgLootTable" >> "Pistols","items",[]] call BIS_fnc_returnConfigEntry;
_rifleList = [configFile >> "CfgLootTable" >> "Rifle","items",[]] call BIS_fnc_returnConfigEntry;
_machinegunList = [configFile >> "CfgLootTable" >> "Machinegun","items",[]] call BIS_fnc_returnConfigEntry;
_sniperList = [configFile >> "CfgLootTable" >> "SniperRifle","items",[]] call BIS_fnc_returnConfigEntry;

_pistolList = _pistolList call _buildWeaponList;
_rifleList = _rifleList call _buildWeaponList;
_machinegunList = _machinegunList call _buildWeaponList;
_sniperList = _sniperList call _buildWeaponList;

if !(_pistolList isEqualTo []) then {A3EAI_pistolList = _pistolList} else {diag_log "A3EAI Error: Could not dynamically generate Pistol weapon classname list. Classnames from A3EAI_config.sqf used instead."};
if !(_rifleList isEqualTo []) then {A3EAI_rifleList = _rifleList} else {diag_log "A3EAI Error: Could not dynamically generate Rifle weapon classname list. Classnames from A3EAI_config.sqf used instead."};
if !(_machinegunList isEqualTo []) then {A3EAI_machinegunList = _machinegunList} else {diag_log "A3EAI Error: Could not dynamically Machinegun weapon classname list. Classnames from A3EAI_config.sqf used instead."};
if !(_sniperList isEqualTo []) then {A3EAI_sniperList = _sniperList} else {diag_log "A3EAI Error: Could not dynamically generate Sniper weapon classname list. Classnames from A3EAI_config.sqf used instead."};

if (A3EAI_debugLevel > 0) then {
	if (A3EAI_debugLevel > 1) then {
		//Display finished weapon arrays
		diag_log format ["Contents of A3EAI_pistolList: %1",A3EAI_pistolList];
		diag_log format ["Contents of A3EAI_rifleList: %1",A3EAI_rifleList];
		diag_log format ["Contents of A3EAI_machinegunList: %1",A3EAI_machinegunList];
		diag_log format ["Contents of A3EAI_sniperList: %1",A3EAI_sniperList];
	};
	diag_log format ["A3EAI Debug: Weapon classname tables created in %1 seconds.",(diag_tickTime - _startTime)];
};

A3EAI_dynamicWeaponBlacklist = nil;
