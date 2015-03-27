if ((typeName _this) != "OBJECT") exitWith {};

private ["_vehicleWeapons","_cursorAim","_missileMags","_vehicleMags"];

_vehicleWeapons = +(weapons _this);
_vehicleMags = +(magazines _this);

{
	_cursorAim = [configFile >> "CfgWeapons" >> _x,"cursorAim",""] call BIS_fnc_returnConfigEntry;
	if ((toLower _cursorAim) in ["missile","rocket"]) then {
		_missileMags = [configFile >> "CfgWeapons" >> _x,"magazines",[]] call BIS_fnc_returnConfigEntry;
		{ if (_x in _vehicleMags) then { _this removeMagazines _x; }; } count _missileMags;
		_this removeWeapon _x;
		if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Removed missile/rocket weapon %1 from vehicle %2.",_x,(typeOf _this)];};
	};
} forEach _vehicleWeapons;

true