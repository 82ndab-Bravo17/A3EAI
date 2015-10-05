#include "\A3EAI\globaldefines.hpp"

private ["_unitType", "_unitGroup", "_loadout", "_weapon", "_magazine", "_useLaunchers", "_maxLaunchers", "_unitLevel", "_launchWeapon", "_launchAmmo","_launchersAdded"];

_unitGroup = _this select 0;
_unitType = _this select 1;
_unitLevel = _this select 2;

if !(_unitType in ["uav","ugv"]) then {
	_useLaunchers = if !(A3EAI_levelRequiredLauncher isEqualTo -1) then {((count A3EAI_launcherTypes) > 0) && {(_unitLevel >= A3EAI_levelRequiredLauncher)}} else {false};
	_maxLaunchers = if (_useLaunchers) then {A3EAI_launchersPerGroup min _unitLevel} else {0};
	_launchersAdded = 0;
	
	_unitGroup setVariable ["LootPool",[]];
	_unitGroup spawn A3EAI_generateLootPool;

	//Set up individual group units
	{
		_loadout = _x getVariable "loadout";
		if (isNil "_loadout") then {
			_weapon = primaryWeapon _x;
			_magazine = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines") select 0;
			_loadout = [[_weapon],[_magazine]];
			_x setVariable ["loadout",_loadout];
		};
		

		if (_launchersAdded < _maxLaunchers) then {
			_launchWeapon = A3EAI_launcherTypes call A3EAI_selectRandom;
			_launchAmmo = getArray (configFile >> "CfgWeapons" >> _launchWeapon >> "magazines") select 0;
			if (_x canAdd _launchAmmo) then {
				_x addMagazine _launchAmmo;
				_x addWeapon _launchWeapon; 
				(_loadout select 1) pushBack _launchAmmo;
				(_loadout select 0) pushBack _launchWeapon;
				_launchersAdded = _launchersAdded + 1;
				if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Successfully added weapon %1 and ammo %2 to unit %3.",_launchWeapon,_launchAmmo,_x];};
			} else {
				if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Unable to add weapon %1 and ammo %2 to unit %3.",_launchWeapon,_launchAmmo,_x];};
			};
		};
			
		if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: %1 Unit %2 loadout: %3. unitLevel %4.",_unitType,_x,_x getVariable ["loadout",[]],_unitLevel];};
	} forEach (units _unitGroup);
};

true