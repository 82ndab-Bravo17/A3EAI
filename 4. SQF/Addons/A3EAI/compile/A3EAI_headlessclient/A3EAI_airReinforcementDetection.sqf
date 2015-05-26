private ["_unitGroup", "_unitLevel", "_unitType", "_groupSize", "_vehicle"];

_unitGroup = _this select 0;
_vehicle = _this select 1;

if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Waiting for reinforcement group %1 ready state.",_unitGroup];};
waitUntil {uiSleep 10; diag_log format ["Debug: Group %1 behavior is %2",_unitGroup,(behaviour (leader _unitGroup))]; !((behaviour (leader _unitGroup)) isEqualTo "CARELESS")};
if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Group %1 has now entered ready state.",_unitGroup];};

//_endTime = diag_tickTime + A3EAI_airReinforcementDuration;
//while {(diag_tickTime < _endTime) && {(_unitGroup getVariable ["GroupSize",-1]) > 0} && {(_unitGroup getVariable ["unitType",""]) isEqualTo "air_reinforce"}} do {
while {((behaviour (leader _unitGroup)) in ["AWARE","COMBAT"]) && {(_unitGroup getVariable ["GroupSize",-1]) > 0}} do {
	if (local _unitGroup) then {
		_vehiclePos = getPosATL _vehicle;
		_vehiclePos set [2,0];
		_nearUnits = _vehiclePos nearEntities [["Epoch_Male_F","Epoch_Female_F","LandVehicle"],500];
		{
			if ((isPlayer _x) && {(_unitGroup knowsAbout _x) < 3}) then {
				_heliAimPos = aimPos _vehicle;
				_playerEyePos = eyePos _x;
				if (!(terrainIntersectASL [_heliAimPos,_playerEyePos]) && {!(lineIntersects [_heliAimPos,_playerEyePos,_vehicle,_x])} && {A3EAI_detectChance call A3EAI_chance}) then {
					_unitGroup reveal [_x,3]; 
				};
			};
		} forEach _nearUnits;
	};
	uiSleep 15;
};

if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Reinforcement state ended for group %1. Behavior: %2",_unitGroup,(behaviour (leader _unitGroup))];};
