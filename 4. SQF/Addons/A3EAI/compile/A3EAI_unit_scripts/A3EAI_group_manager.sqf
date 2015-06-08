private ["_unitGroup","_unitLevel","_vehicle","_lastRearmTime","_useLaunchers","_marker","_groupWPMarker","_antistuckTime","_antistuckPos","_lootPool","_pullChance","_pullRate","_antistuckObj","_updateServerLoot","_managerStartTime"];

_unitGroup = _this select 0;
_unitLevel = _this select 1;

if (_unitGroup getVariable ["isManaged",false]) exitWith {};
_unitGroup setVariable ["isManaged",true];

_unitType = (_unitGroup getVariable ["unitType",""]);
_vehicle = if (_unitType in ["air","land","aircustom","landcustom","air_reinforce"]) then {_unitGroup getVariable ["assignedVehicle",(assignedVehicle (leader _unitGroup))]} else {objNull};

_useLaunchers = if !(A3EAI_launcherLevelReq isEqualTo -1) then {((count A3EAI_launcherTypes) > 0) && {(_unitLevel >= A3EAI_launcherLevelReq)}} else {false};
_antistuckPos = (getWPPos [_unitGroup,(currentWaypoint _unitGroup)]);
if (isNil {_unitGroup getVariable "GroupSize"}) then {_unitGroup setVariable ["GroupSize",(count (units _unitGroup))]};
_stuckCheckTime = call {
	if (_unitType in ["static","staticcustom","vehiclecrew","aircustom","landcustom"]) exitWith {300};
	if (_unitType isEqualTo "air") exitWith {300};
	if (_unitType isEqualTo "land") exitWith {450};
	300
};

//set up debug variables
_groupLeadMarker = "";
_groupWPMarker = "";

//Set up timer variables
_managerStartTime = diag_tickTime;
_lastRearmTime = diag_tickTime;
_antistuckTime = diag_tickTime + 900;
_lootGenTime = diag_tickTime;

//Setup loot variables
_updateServerLoot = (A3EAI_enableHC && {!isDedicated});
_pullChance = missionNamespace getVariable [format ["A3EAI_lootPullChance%1",_unitLevel],0.40];
_pullRate = 60;
if (_unitType in ["dynamic","randomspawn"]) then {_pullRate = ((_pullRate/2) max 30)};

if (isDedicated) then {
	_unitGroup setVariable ["LootPool",[]];
	_lootGenerate = _unitGroup spawn A3EAI_generateLootPool;

	//Air units only: Replace backpack with parachute
	if (_unitType in ["air","aircustom"]) then {
		{
			if !((backpack _x) isEqualTo "B_Parachute") then {
				_x addBackpack "B_Parachute";
			};
		} forEach (units _unitGroup);
		if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Unit backpacks replaced with B_Parachute for %1 group %2.",_unitType,_unitGroup]};
	};

	//Set up individual group units
	{
		_loadout = _x getVariable "loadout";
		if (isNil "_loadout") then {
			_weapon = primaryWeapon _x;
			_magazine = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines") select 0;
			_loadout = [[_weapon],[_magazine]];
			_x setVariable ["loadout",_loadout];
		};
		
		if (_useLaunchers) then {
			_maxLaunchers = (A3EAI_launchersPerGroup min _unitLevel);
			if (_forEachIndex < _maxLaunchers) then {
				_launchWeapon = A3EAI_launcherTypes call BIS_fnc_selectRandom2;
				_launchAmmo = getArray (configFile >> "CfgWeapons" >> _launchWeapon >> "magazines") select 0;
				_x addMagazine _launchAmmo; 
				_x addWeapon _launchWeapon; 
				(_loadout select 1) pushBack _launchAmmo;
				(_loadout select 0) pushBack _launchWeapon;
				if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Modified unit %1 loadout to %2.",_x,_loadout];};
			};
		};

		if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Unit %1 loadout: %2. unitLevel %3.",_x,_x getVariable ["loadout",[]],_unitLevel];};
	} forEach (units _unitGroup);

	if (A3EAI_debugMarkersEnabled) then {
		_groupLeadMarker = format ["%1_Lead",_unitGroup];
		if (_groupLeadMarker in allMapMarkers) then {deleteMarker _groupLeadMarker; uiSleep 0.5};	//Delete the previous marker if it wasn't deleted for some reason.
		_groupLeadMarker = createMarker [_groupLeadMarker,getPosATL (leader _unitGroup)];
		_groupLeadMarker setMarkerType "mil_warning";
		_groupLeadMarker setMarkerBrush "Solid";
		_groupLeadMarker setMarkerColor "ColorBlack";
		
		if (isNull _vehicle) then {
			_groupLeadMarker setMarkerText format ["%1 (AI L%2)",_unitGroup,_unitLevel];
		} else {
			_groupLeadMarker setMarkerText format ["%1 (AI L%2 %3)",_unitGroup,_unitLevel,(typeOf (vehicle (leader _unitGroup)))];
		};
		
		_groupWPMarker = (format ["%1_WP",_unitGroup]);
		if (_groupWPMarker in allMapMarkers) then {deleteMarker _groupWPMarker; uiSleep 0.5;};	//Delete the previous marker if it wasn't deleted for some reason.
		_groupWPMarker = createMarker [_groupWPMarker,(getWPPos [_unitGroup,(currentWaypoint _unitGroup)])];
		_groupWPMarker setMarkerText format ["%1 Waypoint",_unitGroup];
		_groupWPMarker setMarkerType "Waypoint";
		_groupWPMarker setMarkerColor "ColorBlue";
		_groupWPMarker setMarkerBrush "Solid";
		
		[_unitGroup] spawn {
			_unitGroup = _this select 0;
			{
				_markname = str(_x);
				if (_markname in allMapMarkers) then {deleteMarker _markname; uiSleep 0.5};
				_mark = createMarker [_markname,getPosATL _x];
				_mark setMarkerShape "ELLIPSE";
				_mark setMarkerType "Dot";
				_mark setMarkerColor "ColorRed";
				_mark setMarkerBrush "SolidBorder";
				_nul = _x spawn {
					_markername = str (_this);
					_unitGroup = group _this;
					while {alive _this} do {
						if (local _this) then {
							_unitPos = getPosATL _this;
							if ((leader _unitGroup) isEqualTo _this) then {
								(format ["%1_Lead",_unitGroup]) setMarkerPos _unitPos;
								(format ["%1_WP",_unitGroup]) setMarkerPos (getWPPos [_unitGroup,(currentWaypoint _unitGroup)]);
							};
							_markername setMarkerPos _unitPos;
						};
						uiSleep 10;
					};
					deleteMarker _markername;
				};
			} forEach (units _unitGroup);
		};
	};
	
} else {
	waitUntil {uiSleep 0.25; (local _unitGroup)};
	
	_useGL = if !(A3EAI_GLRequirement isEqualTo -1) then {_unitLevel >= A3EAI_GLRequirement} else {false};
	{
		_x setVariable ["loadout",[[],[]]];
		_loadout = _x getVariable "loadout";
		_primaryWeapon = primaryWeapon _x;
		_secondaryWeapon = secondaryWeapon _x;
		_handgunWeapon = handgunWeapon _x;
		
		if !(_primaryWeapon isEqualTo "") then {
			(_loadout select 0) pushBack _primaryWeapon;
			_primaryWeaponMagazine = getArray (configFile >> "CfgWeapons" >> _primaryWeapon >> "magazines") select 0;
			(_loadout select 1) pushBack _primaryWeaponMagazine;
		} else {
			if !(_handgunWeapon isEqualTo "") then {
				(_loadout select 0) pushBack _handgunWeapon;
				_handgunWeaponMagazine = getArray (configFile >> "CfgWeapons" >> _handgunWeapon >> "magazines") select 0;
				(_loadout select 1) pushBack _handgunWeaponMagazine;
			};
		};
		
		if !(_secondaryWeapon isEqualTo "") then {
			(_loadout select 0) pushBack _secondaryWeapon;
			_secondaryWeaponMagazine = getArray (configFile >> "CfgWeapons" >> _secondaryWeapon >> "magazines") select 0;
			(_loadout select 1) pushBack _secondaryWeaponMagazine;
		};
		
		if ((getNumber (configFile >> "CfgMagazines" >> ((_loadout select 1) select 0) >> "count")) < 6) then {_x setVariable ["extraMag",true]};
	
		if (_useGL) then {
			_weaponMuzzles = getArray(configFile >> "cfgWeapons" >> ((_loadout select 0) select 0) >> "muzzles");
			if ((count _weaponMuzzles) > 1) then {
				_GLWeapon = _weaponMuzzles select 1;
				_GLMagazines = (getArray (configFile >> "CfgWeapons" >> ((_loadout select 0) select 0) >> _GLWeapon >> "magazines"));
				if ("3Rnd_HE_Grenade_shell" in _GLMagazines) then {
					_x addMagazine "3Rnd_HE_Grenade_shell";
					(_loadout select 0) pushBack _GLWeapon;
					(_loadout select 1) pushBack "3Rnd_HE_Grenade_shell";
					if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Modified unit %1 loadout to %2.",_x,_loadout];};
				} else {
					if ("1Rnd_HE_Grenade_shell" in _GLMagazines) then {
						_x addMagazine "1Rnd_HE_Grenade_shell";
						(_loadout select 0) pushBack _GLWeapon;
						(_loadout select 1) pushBack "1Rnd_HE_Grenade_shell";
						if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Modified unit %1 loadout to %2.",_x,_loadout];};
					}
				};
			};
		};
		
		if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Unit %1 loadout: %2. unitLevel %3.",_x,_x getVariable ["loadout",[]],_unitLevel];};
	} forEach (units _unitGroup);
	
	if (A3EAI_debugMarkersEnabled) then {
		{
			_nul = _x spawn {
				waitUntil {sleep 5; ((local _this) or {!(alive _this)})};
				_unitMarker = str (_this);
				_unitGroup = group _this;
				while {alive _this} do {
					if (local _this) then {
						_unitPos = getPosATL _this;
						if ((leader _unitGroup) isEqualTo _this) then {
							(format ["%1_Lead",_unitGroup]) setMarkerPos _unitPos;
							(format ["%1_WP",_unitGroup]) setMarkerPos (getWPPos [_unitGroup,(currentWaypoint _unitGroup)]);
						};
						_unitMarker setMarkerPos _unitPos;
					};
					uiSleep 10;
				};
			};
		} forEach (units _unitGroup);
	};

	if (A3EAI_debugLevel > 1) then {
		_lootPool = _unitGroup getVariable ["LootPool",[]];
		//diag_log format ["Debug: Found loot pool for group %1 from server: %2",_unitGroup,_lootPool];
	};
};

//Main loop
while {(!isNull _unitGroup) && {(_unitGroup getVariable ["GroupSize",-1]) > 0}} do {
	_unitType = (_unitGroup getVariable ["unitType",""]);

	call {
		//If any units have left vehicle then allow re-entry
		if (_unitType in ["land","landcustom"]) exitWith {
			if (alive _vehicle) then {
				if (_unitGroup getVariable ["regrouped",true]) then {
					if (({if ((_x distance _vehicle) > 175) exitWith {1}} count (assignedCargo _vehicle)) > 0) then {
						_unitGroup setVariable ["regrouped",false];
						[_unitGroup,_vehicle] call A3EAI_vehCrewRegroup;
					};
				};
			};
		};
	};
	
	{
		//Check infantry-type units
		if (((vehicle _x) isEqualTo _x) && {_x getVariable ["canCheckUnit",true]} && {local _x}) then {
			_x setVariable ["canCheckUnit",false];
			_nul = _x spawn {
				if (!alive _this) exitWith {};
				_unit = _this;
				_loadout = _unit getVariable "loadout";
				if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Unpacked unit manager for unit %1. Loadout found: %2.",_unit,_loadout];};
				if (!isNil "_loadout") then {
					while {(alive _unit) && {(vehicle _unit) isEqualTo _unit} && {local _unit}} do {
						_currentMagazines = (magazines _unit);
						for "_i" from 0 to ((count (_loadout select 0)) - 1) do {
							_magazine = ((_loadout select 1) select _i);
							if (((_unit ammo ((_loadout select 0) select _i)) isEqualTo 0) || {!((_magazine in _currentMagazines))}) then {
								_unit removeMagazines _magazine;
								[_unit,_magazine] call A3EAI_addItem;
								if ((_i isEqualTo 0) && {_unit getVariable ["extraMag",false]}) then {
									[_unit,_magazine] call A3EAI_addItem;
								};
							};
						};
						//diag_log format ["Rearm loop running for unit %1",_unit];
						if (alive _unit) then {uiSleep 15};
					};
				};
				if (alive _unit) then {
					_unit setVariable ["canCheckUnit",true];
					if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Repacking unit manager for unit %1.",_unit];};
				};
			};
		};
		uiSleep 0.1;
	} forEach (units _unitGroup);

	//Generate loot
	if ((diag_tickTime - _lootGenTime) > _pullRate) then {
		_lootPool = _unitGroup getVariable ["LootPool",[]];
		if !(_lootPool isEqualTo []) then {
			if (_pullChance call A3EAI_chance) then {
				_lootUnit = (units _unitGroup) call BIS_fnc_selectRandom2;
				_lootIndex = floor (random (count _lootPool));
				_loot = _lootPool select _lootIndex;
				if (alive _lootUnit) then {
					if ([_lootUnit,_loot] call A3EAI_addItem) then {
						_lootPool deleteAt _lootIndex;
						if (_updateServerLoot) then {
							[_unitGroup,_lootIndex] call A3EAI_updateServerLoot;
						};
						if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Pulled %1 from %2 loot pool (%3 items remain).",_loot,_unitGroup,(count _lootPool)];};
					};
				};
			};
		};
		_lootGenTime = diag_tickTime;
	};
	
	//Vehicle ammo/fuel check
	if ((alive _vehicle) && {(diag_tickTime - _lastRearmTime) > 180}) then {	//If _vehicle is objNull (if no vehicle was assigned to the group) then nothing in this bracket should be executed
		_result = _vehicle call A3EAI_reloadVehicleTurrets; //Rearms vehicle weapons/turrets individually
		if ((A3EAI_debugLevel > 0) && {_result}) then {diag_log format ["A3EAI Debug: Reloaded ammo for %1 %2 weapons.",_unitGroup,(typeOf _vehicle)];};
		if ((fuel _vehicle) < 0.50) then {_vehicle setFuel 1};
		_lastRearmTime = diag_tickTime;
	};
	
	//Antistuck 
	if ((diag_tickTime - _antistuckTime) > _stuckCheckTime) then {
		_unitType = (_unitGroup getVariable ["unitType",""]);
		call {
			if (_unitType in ["static","landcustom","staticcustom","vehiclecrew"]) exitWith {
				//Static and custom land vehicle patrol anti stuck routine
				_checkPos = (getPosATL (leader _unitGroup));
				_allWP = (waypoints _unitGroup);
				if ((count _allWP) > 1) then {
					if ((_antistuckPos distance _checkPos) < 5) then {
						_currentWP = (currentWaypoint _unitGroup);
						_nextWP = _currentWP + 1;
						if ((count _allWP) isEqualTo _nextWP) then {_nextWP = 0}; //Cycle back to first waypoint if group is currently on last waypoint.
						[_unitGroup] call A3EAI_fixStuckGroup;
						_unitGroup setCurrentWaypoint [_unitGroup,_nextWP];
						if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Antistuck triggered for AI group %1. Forcing next waypoint.",_unitGroup];};
						_antistuckTime = diag_tickTime + (_stuckCheckTime/2);
					} else {
						_antistuckPos = _checkPos;
						_antistuckTime = diag_tickTime;
					};
				};
			};
			if ((_unitType isEqualTo "air") && {!isNull _vehicle}) exitWith {
				_checkPos = (getWPPos [_unitGroup,(currentWaypoint _unitGroup)]);
				if ((_checkPos isEqualTo _antistuckPos) && {canMove _vehicle}) then {
					_tooClose = true;
					_wpSelect = [];
					while {_tooClose} do {
						_wpSelect = (A3EAI_locations call BIS_fnc_selectRandom2) select 1;
						if (((waypointPosition [_unitGroup,0]) distance _wpSelect) < 300) then {
							_tooClose = false;
						} else {
							uiSleep 0.1;
						};
					};
					_wpSelect = [_wpSelect,50+(random 900),(random 360),1] call SHK_pos;
					[_unitGroup,0] setWPPos _wpSelect;
					[_unitGroup,1] setWPPos _wpSelect;
					[_unitGroup,"IgnoreEnemies"] call A3EAI_forceBehavior;
					//_vehicle doMove _wpSelect;
					_antistuckPos = _wpSelect;
					if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Antistuck triggered for AI air vehicle %1 (Group: %2). Forcing next waypoint.",(typeOf _vehicle),_unitGroup];};
					_antistuckTime = diag_tickTime + (_stuckCheckTime/2);
				} else {
					_antistuckPos = _checkPos;
					_antistuckTime = diag_tickTime;
				};
			};
			if ((_unitType isEqualTo "land") && {!isNull _vehicle}) exitWith {
				//Mapwide land vehicle patrol anti stuck routine
				_currentPos = (getPosATL _vehicle);
				if ((_antistuckPos distance _currentPos) < 100) then {
					if (canMove _vehicle) then {
						[_unitGroup] call A3EAI_fixStuckGroup;
						if ((count (waypoints _unitGroup)) isEqualTo 1) then {
							_tooClose = true;
							_wpSelect = [];
							while {_tooClose} do {
								_wpSelect = (A3EAI_locationsLand call BIS_fnc_selectRandom2) select 1;
								if (((waypointPosition [_unitGroup,0]) distance _wpSelect) < 300) then {
									_tooClose = false;
								} else {
									uiSleep 0.1;
								};
							};
							_wpSelect = [_wpSelect,random(300),random(360),0,[1,300]] call SHK_pos;
							[_unitGroup,0] setWPPos _wpSelect;
							if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Antistuck triggered for AI land vehicle %1 (Group: %2). Forcing next waypoint.",(typeOf _vehicle),_unitGroup];};
						};
						_antistuckPos = _currentPos;
						_antistuckTime = diag_tickTime + (_stuckCheckTime/2);
					} else {
						if (!(_vehicle getVariable ["vehicle_disabled",false])) then {
							[_vehicle] call A3EAI_vehDestroyed;
							if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: AI vehicle %1 (Group: %2) is immobilized. Respawning vehicle patrol group.",(typeOf _vehicle),_unitGroup];};
						};
					};
				} else {
					_antistuckPos = _currentPos;
					_antistuckTime = diag_tickTime;
				};
			};
			if ((_unitType isEqualTo "aircustom") && {!isNull _vehicle}) exitWith {
				_checkPos = (getWPPos [_unitGroup,(currentWaypoint _unitGroup)]);
				if ((_checkPos isEqualTo _antistuckPos) && {canMove _vehicle}) then {
					_currentWP = (currentWaypoint _unitGroup);
					_allWP = (waypoints _unitGroup);
					_nextWP = _currentWP + 1;
					if ((count _allWP) isEqualTo _nextWP) then {_nextWP = 1}; //Cycle back to first added waypoint if group is currently on last waypoint.
					_unitGroup setCurrentWaypoint [_unitGroup,_nextWP];
					if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Antistuck triggered for AI air (custom) group %1. Forcing next waypoint.",_unitGroup];};
					_antistuckTime = diag_tickTime + (_stuckCheckTime/2);
				} else {
					_antistuckTime = diag_tickTime;
				};
			};
		};
	};

	if (A3EAI_HCIsConnected && {_unitGroup getVariable ["HC_Ready",false]} && {(diag_tickTime - _managerStartTime) > 30}) then {
		private ["_result"];
		_result = _unitGroup call A3EAI_transferGroupToHC;
		if (_result) then {
			waitUntil {sleep 1.5; (!(local _unitGroup) or {isNull _unitGroup})};
			if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Transferred ownership of group %1 to HC %2.",_unitGroup,A3EAI_HCObjectOwnerID];};
			waitUntil {sleep 15; ((local _unitGroup) or {isNull _unitGroup})};
			if ((_unitGroup getVariable ["GroupSize",-1]) > 0) then {
				_lastRearmTime = diag_tickTime;	//Update all timestamps to current time
				_antistuckTime = diag_tickTime;
				_lootGenTime = diag_tickTime;
			};
			if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Group %1 ownership was returned to server.",_unitGroup];};
		} else {
			if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Waiting to transfer Group %1 ownership to headless client (ID: %2).",_unitGroup,A3EAI_HCObjectOwnerID];};
		};
	};

	//diag_log format ["DEBUG: Group Manager cycle time for group %1: %2 seconds.",_unitGroup,(diag_tickTime - _debugStartTime)];
	if ((_unitGroup getVariable ["GroupSize",0]) > 0) then {uiSleep 15};
};

_unitGroup setVariable ["isManaged",false]; //allow group manager to run again on group respawn.

if !(isDedicated) exitWith {
	A3EAI_transferGroup_PVS = _unitGroup;
	publicVariableServer "A3EAI_transferGroup_PVS";	//Return ownership to server.
	A3EAI_HCGroupsCount = A3EAI_HCGroupsCount - 1;
	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Returned ownership of AI group %1 to server.",_unitGroup];};
};

if !(isNull _vehicle) then {
	if (isEngineOn _vehicle) then {_vehicle engineOn false;};
	if (isNil {_vehicle getVariable "A3EAI_deathTime"}) then {_vehicle setVariable ["A3EAI_deathTime",diag_tickTime];};
};

if (A3EAI_debugMarkersEnabled) then {
	deleteMarker _groupLeadMarker;
	deleteMarker _groupWPMarker;
};

while {(_unitGroup getVariable ["GroupSize",-1]) isEqualTo 0} do {	//Wait until group is either respawned or marked for deletion. A dummy unit should be created to preserve group.
	uiSleep 5;
};

if ((_unitGroup getVariable ["GroupSize",-1]) isEqualTo -1) then {	//GroupSize value of -1 marks group for deletion
	if (!isNull _unitGroup) then {
		if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Deleting %2 group %1.",_unitGroup,(_unitGroup getVariable ["unitType","unknown"])]};
		_unitGroup call A3EAI_deleteGroup;
	};
};
