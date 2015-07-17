private ["_unitGroup", "_assignedVehicle", "_isInfantry", "_vehicle", "_vehiclePos", "_nearPlayers", "_leaderPos", "_newPosEmpty"];

_unitGroup = _this select 0;

_assignedVehicle = (_unitGroup getVariable ["assignedVehicle",objNull]);
_isInfantry = (isNull _assignedVehicle);
_vehicle = if (_isInfantry) then {leader _unitGroup} else {_assignedVehicle};

_vehiclePos = getPosATL _vehicle;

_leaderPos = getPosATL (leader _unitGroup);
_newPosEmpty = _leaderPos findEmptyPosition [0.5,30,"Land_Coil_F"];

if !(_newPosEmpty isEqualTo []) then {
	_newPosEmpty = _newPosEmpty isFlatEmpty [0,0,0.75,5,0,false,objNull];
};

if (_newPosEmpty isEqualTo []) then {
	_newPosEmpty = [_leaderPos,10 + random(25),random(360),0,[0,0],[25,"Land_Coil_F"]] call SHK_pos;
};

_newPosEmpty set [2,0];

if (_isInfantry) then {
	{
		_x setPosATL _newPosEmpty;
		_x setVelocity [0,0,0.25];
	} forEach (units _unitGroup);
} else {
	if (_vehicle isKindOf "Land") then {
		_vehicle setPosATL _newPosEmpty;
		_vehicle setVelocity [0,0,0.25];
	};
	{
		if (((vehicle _x) isEqualTo _x) && {(_x distance _vehicle) > 100}) then {
			_newUnitPos = [_vehicle,25 + random(25),random(360),0,[0,0],[25,"i_survivor_F"]] call SHK_pos;
			_x setPosATL _newUnitPos;
			_x setVelocity [0,0,0.25];
		};
	} forEach (units _unitGroup);
};
if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Relocated stuck group %1 (%2) to new location %3m away.",_unitGroup,(_unitGroup getVariable ["unitType","unknown"]),(_leaderPos distance _newPosEmpty)];};

true