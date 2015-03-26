private ["_vehicle","_reloadedTurrets","_vehicleTurrets"];

_vehicle = _this;

_reloadedTurrets = false;

_vehicleWeapons = (weapons _vehicle);
{
	_cursorAim = [configFile >> "CfgWeapons" >> _x,"cursorAim",""] call BIS_fnc_returnConfigEntry;
	if ((toLower _cursorAim) in ["mg","missile","rocket"]) then {
		_weaponMagazines = [configFile >> "CfgWeapons" >> _x,"magazines",[]] call BIS_fnc_returnConfigEntry;
		if !(_weaponMagazines isEqualTo []) then {
			if ((_vehicle ammo _x) isEqualTo 0) then {
				_weaponMagazine = _weaponMagazines select 0;
				_vehicle removeMagazines _weaponMagazine;
				_vehicle addMagazine _weaponMagazine;
				if !(_reloadedTurrets) then {_reloadedTurrets = true};
			};
		};
	};
} forEach _vehicleWeapons;

_vehicleTurrets = allTurrets [_vehicle,false];
{
	private ["_turretWeapons","_turretMagazine","_turretAmmoCount"];
	_turretWeapons = _vehicle weaponsTurret _x;
	if !(_turretWeapons isEqualTo []) then {
		_turretMagazine = (_vehicle magazinesTurret _x) select 0;
		_turretAmmoCount = _vehicle magazineTurretAmmo [_turretMagazine,_x];
		if (_turretAmmoCount isEqualTo 0) then {
			_vehicle removeMagazinesTurret [_turretMagazine, _x];
			_vehicle addMagazineTurret [_turretMagazine, _x];
			if !(_reloadedTurrets) then {_reloadedTurrets = true};
		};
	};
} forEach _vehicleTurrets;

_reloadedTurrets