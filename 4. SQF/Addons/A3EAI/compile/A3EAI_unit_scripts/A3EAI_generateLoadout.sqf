private ["_unit", "_unitLevel", "_unitLevelInvalid", "_loadout", "_weaponSelected", "_unitLevelString", "_uniforms", "_backpacks", "_vests", "_headgears", "_magazine", "_uniformItem", "_backpackItem", "_vestItem", "_headgearItem", 
"_useGL", "_weaponMuzzles", "_GLWeapon", "_GLMagazines", "_isRifle", "_opticsList", "_opticsType", "_pointersList", "_pointerType", "_muzzlesList", "_muzzleType", "_underbarrelList", "_underbarrelType", "_gadgetsArray", "_gadget"];

_unit = _this select 0;
_unitLevel = _this select 1;

if !(isNil {_unit getVariable "loadout"}) exitWith {diag_log format ["A3EAI Error: Unit already has loadout! (%1)",__FILE__];};

if !(_unitLevel in A3EAI_unitLevelsAll) then {
	_unitLevelInvalid = _unitLevel;
	_unitLevel = A3EAI_unitLevels call A3EAI_selectRandom;
	diag_log format ["A3EAI Error: Invalid unitLevel provided: %1. Generating new unitLevel value: %2. (%3)",_unitLevelInvalid,_unitLevel,__FILE__];
};

_unit call A3EAI_purgeUnitGear;	//Clear unwanted gear from unit first.

_loadout = [[],[]];
_weaponSelected = _unitLevel call A3EAI_getWeapon;
_unitLevelString = str (_unitLevel);
_uniforms = missionNamespace getVariable ["A3EAI_uniformsTypes"+_unitLevelString,[]];
_backpacks = missionNamespace getVariable ["A3EAI_backpacksTypes"+_unitLevelString,[]];
_vests = missionNamespace getVariable ["A3EAI_vestsTypes"+_unitLevelString,[]];
_headgears = missionNamespace getVariable ["A3EAI_headgearsTypes"+_unitLevelString,[]];
_magazine = getArray (configFile >> "CfgWeapons" >> _weaponSelected >> "magazines") select 0;

if !(_uniforms isEqualTo []) then {
	_uniformItem = _uniforms call A3EAI_selectRandom;
	_unit forceAddUniform _uniformItem;
};
if !(_backpacks isEqualTo []) then {
	_backpackItem = _backpacks call A3EAI_selectRandom;
	_unit addBackpack _backpackItem; 
	clearAllItemsFromBackpack _unit;
};
if !(_vests isEqualTo []) then {
	_vestItem = _vests call A3EAI_selectRandom;
	_unit addVest _vestItem;
};
if !(_headgears isEqualTo []) then {
	_headgearItem = _headgears call A3EAI_selectRandom;
	_unit addHeadgear _headgearItem;
};

_unit addMagazine _magazine;
_unit addWeapon _weaponSelected;
_unit selectWeapon _weaponSelected;
(_loadout select 0) pushBack _weaponSelected;
(_loadout select 1) pushBack _magazine;
if ((getNumber (configFile >> "CfgMagazines" >> _magazine >> "count")) < 6) then {
	_unit setVariable ["extraMag",true];
	_unit addMagazine _magazine;
};

//Grenades
_useGL = if !(A3EAI_GLRequirement isEqualTo -1) then {_unitLevel >= A3EAI_GLRequirement} else {false};
if (_useGL) then {
	_weaponMuzzles = getArray(configFile >> "cfgWeapons" >> _weaponSelected >> "muzzles");
	if ((count _weaponMuzzles) > 1) then {
		_GLWeapon = _weaponMuzzles select 1;
		_GLMagazines = (getArray (configFile >> "CfgWeapons" >> _weaponSelected >> _GLWeapon >> "magazines"));
		if ("3Rnd_HE_Grenade_shell" in _GLMagazines) then {
			_unit addMagazine "3Rnd_HE_Grenade_shell";
			(_loadout select 0) pushBack _GLWeapon;
			(_loadout select 1) pushBack "3Rnd_HE_Grenade_shell";
			if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Modified unit %1 loadout to %2.",_unit,_loadout];};
		} else {
			if ("1Rnd_HE_Grenade_shell" in _GLMagazines) then {
				_unit addMagazine "1Rnd_HE_Grenade_shell";
				(_loadout select 0) pushBack _GLWeapon;
				(_loadout select 1) pushBack "1Rnd_HE_Grenade_shell";
				if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Modified unit %1 loadout to %2.",_unit,_loadout];};
			}
		};
	};
};

//Select weapon optics
_isRifle = ((getNumber (configFile >> "CfgWeapons" >> _weaponSelected >> "type")) isEqualTo 1);
if ((missionNamespace getVariable [("A3EAI_opticsChance"+_unitLevelString),3]) call A3EAI_chance) then {
	_opticsList = getArray (configFile >> "CfgWeapons" >> _weaponSelected >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems");
	if !(_opticsList isEqualTo []) then {
		_opticsType = A3EAI_weaponOpticsList call A3EAI_selectRandom;
		if (_opticsType in _opticsList) then {
			if (_isRifle) then {_unit addPrimaryWeaponItem _opticsType} else {_unit addHandGunItem _opticsType};
		};
	};
};

//Select weapon pointer
if ((missionNamespace getVariable [("A3EAI_pointerChance"+_unitLevelString),3]) call A3EAI_chance) then {
	_pointersList = getArray (configFile >> "CfgWeapons" >> _weaponSelected >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems");
	if !(_pointersList isEqualTo []) then {
		_pointerType = _pointersList call A3EAI_selectRandom;
		if (_isRifle) then {_unit addPrimaryWeaponItem _pointerType} else {_unit addHandGunItem _pointerType};
		//diag_log format ["DEBUG :: Added pointer item %1 to unit %2.",_pointerType,_unit];
	};
};

//Select weapon muzzle
if ((missionNamespace getVariable [("A3EAI_muzzleChance"+_unitLevelString),3]) call A3EAI_chance) then {
	_muzzlesList = getArray (configFile >> "CfgWeapons" >> _weaponSelected >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");
	if !(_muzzlesList isEqualTo []) then {
		_muzzleType = _muzzlesList call A3EAI_selectRandom;
		if (_isRifle) then {_unit addPrimaryWeaponItem _muzzleType} else {_unit addHandGunItem _muzzleType};
		//diag_log format ["DEBUG :: Added muzzle item %1 to unit %2.",_muzzleType,_unit];
	};
};

//Select weapon muzzle
if ((missionNamespace getVariable [("A3EAI_underbarrelChance"+_unitLevelString),3]) call A3EAI_chance) then {
	_underbarrelList = getArray (configFile >> "CfgWeapons" >> _weaponSelected >> "WeaponSlotsInfo" >> "UnderBarrelSlot" >> "compatibleItems");
	if !(_underbarrelList isEqualTo []) then {
		_underbarrelType = _underbarrelList call A3EAI_selectRandom;
		if (_isRifle) then {_unit addPrimaryWeaponItem _underbarrelType} else {_unit addHandGunItem _underbarrelType};
		//diag_log format ["DEBUG :: Added underbarrel item %1 to unit %2.",_underbarrelType,_unit];
	};
};

_gadgetsArray = missionNamespace getVariable ["A3EAI_gadgets"+_unitLevelString,[]];
for "_i" from 0 to ((count _gadgetsArray) - 1) do {
	if (((_gadgetsArray select _i) select 1) call A3EAI_chance) then {
		_gadget = ((_gadgetsArray select _i) select 0);
		_unit addWeapon _gadget;
	};
};

//If unit was not given NVGs, give the unit temporary NVGs which will be removed at death.
if (A3EAI_tempNVGs && {sunOrMoon < 1}) then {
	_unit call A3EAI_addTempNVG;
};

//Give unit temporary first aid kits to allow self-healing (unit level 1+)
if (A3EAI_enableHealing) then {
	for "_i" from 1 to (_unitLevel min 3) do {
		[_unit,"FirstAidKit"] call A3EAI_addItem;
	};
};

_unit setVariable ["loadout",_loadout];
if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Created loadout for unit %1 (unitLevel: %2): %3.",_unit,_unitLevel,_loadout];};

true
