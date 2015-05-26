private ["_unitGroup", "_assignedVehicle", "_isInfantry", "_vehicle", "_nearEntities", "_vehiclePos", "_nearPlayers", "_leaderPos", "_newPos"];

_unitGroup = _this select 0;

_assignedVehicle = (_unitGroup getVariable ["assignedVehicle",objNull]);
_isInfantry = (isNull _assignedVehicle);
_vehicle = if (_isInfantry) then {leader _unitGroup} else {_assignedVehicle};

_vehiclePos = getPosATL _vehicle;
_nearEntities = _vehiclePos nearEntities [["Epoch_Male_F","Epoch_Female_F","AllVehicles"],300];
_nearPlayers = ({isPlayer _x} count _nearEntities);

if (_nearPlayers isEqualTo 0) then {
	_leaderPos = getPosATL (leader _unitGroup);
	_newPos = [_leaderPos,5 + random(25),random(360),0,[0,0],[25,_vehicle]] call SHK_pos;
	_newPos set [2,0];
	if (_isInfantry) then {
		{
			_x setPosATL _newPos;
		} forEach (units _unitGroup);
	} else {
		_vehicle setPosATL _newPos;
		_vehicle setVelocity [0,0,0.25];
	};
	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Relocated stuck group %1 (%2) to new location %3m away.",_unitGroup,(_unitGroup getVariable ["unitType","unknown"]),(_leaderPos distance _newPos)];};
	true
} else {
	if (_isInfantry) then {
		if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Players nearby. Unable to relocate stuck group %1 (%2).",_unitGroup,(_unitGroup getVariable ["unitType","unknown"])];};
	} else {
		if ((speed _vehicle) < 1) then {
			_vehicle setVelocity [0,0,1];
		};
	};
	false
};