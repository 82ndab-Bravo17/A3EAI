if ((typeName _this) != "OBJECT") exitWith {};

private ["_vehicleWeapons","_cursorAim","_missileMags","_vehicleMags","_vehicleTurrets"];

_vehicleWeapons = +(weapons _this);
_vehicleMags = +(magazines _this);
_vehicleTurrets = allTurrets [_this,false];
if !([-1] in _vehicleTurrets) then {_vehicleTurrets pushBack [-1];};
//diag_log format ["DEBUG VEHICLE TURRETS: %1",_vehicleTurrets];

{
	_cursorAim = [configFile >> "CfgWeapons" >> _x,"cursorAim",""] call BIS_fnc_returnConfigEntry;
	if ((toLower _cursorAim) in ["missile","rocket"]) then {
		_missileMags = [configFile >> "CfgWeapons" >> _x,"magazines",[]] call BIS_fnc_returnConfigEntry;
		{ if (_x in _vehicleMags) then { _this removeMagazines _x; }; } count _missileMags;
		_this removeWeapon _x;
		if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Removed missile/rocket weapon %1 from vehicle %2.",_x,(typeOf _this)];};
	};
} forEach _vehicleWeapons;

{
	private ["_currentTurret","_turretWeapons"];
	_turretWeapons = _this weaponsTurret _x;
	//diag_log format ["DEBUG WEAPONS: %1",_turretWeapons];
	_currentTurret = _x;
	{
		private ["_currentTurretWeapon"];
		//diag_log format ["DEBUG CURRENT WEAPON: %1 (%2)",_x,_currentTurret];
		_cursorAim = [configFile >> "CfgWeapons" >> _x,"cursorAim",""] call BIS_fnc_returnConfigEntry;
		//diag_log format ["DEBUG CURSOR: %1",_cursorAim];
		_currentTurretWeapon = _x;
		if ((toLower _cursorAim) in ["missile","rocket"]) then {
			_turretMags = _this magazinesTurret _currentTurret;
			//diag_log format ["DEBUG: Weapon %1, Magazines %2",_currentTurretWeapon,_x];
			_missileMags = [configFile >> "CfgWeapons" >> _currentTurretWeapon,"magazines",[]] call BIS_fnc_returnConfigEntry;
			{ if (_x in _turretMags) then { _this removeMagazinesTurret [_x,_currentTurret]; }; } count _missileMags;
			_this removeWeaponTurret [_x,_currentTurret];
			if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Removed missile/rocket weapon %1 from vehicle %2.",_x,(typeOf _this)];};
		};
	} forEach _turretWeapons;
} forEach _vehicleTurrets;

true