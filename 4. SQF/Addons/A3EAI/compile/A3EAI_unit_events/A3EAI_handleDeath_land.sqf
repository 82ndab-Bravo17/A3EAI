private ["_victim","_vehicle","_unitGroup","_groupIsEmpty"];

_victim = _this select 0;
_unitGroup = _this select 1;
_groupIsEmpty = _this select 2;

_vehicle = _unitGroup getVariable ["assignedVehicle",objNull];

//diag_log format ["Debug: Victim: %1. Group: %2. Empty Group: %3. Vehicle: %4. LandVehicle: %5.",_victim,_unitGroup,_groupIsEmpty,_vehicle,_vehicle isKindOf "LandVehicle"];

//diag_log format ["Land group %1 has vehicle %2. Group Empty: %3",_unitGroup,_vehicle,_groupIsEmpty];
if (_groupIsEmpty) then {
	if (_vehicle isKindOf "LandVehicle") then {
		{_vehicle removeAllEventHandlers _x} count ["HandleDamage","Killed"];
		_vehicle call A3EAI_respawnAIVehicle;
		if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: AI vehicle patrol destroyed, adding vehicle %1 to cleanup queue.",(typeOf _vehicle)];};
	};
	_unitGroup setVariable ["GroupSize",-1];
	if !(isDedicated) then {
		A3EAI_updateGroupSize_PVS = [_unitGroup,-1];
		publicVariableServer "A3EAI_updateGroupSize_PVS";
	};
} else {
	if (_victim getVariable ["isDriver",false]) then {
		_dummyUnit = _unitGroup getVariable ["dummyUnit",objNull];
		_groupUnits = (units _unitGroup) - [_victim,_dummyUnit];
		if !(_groupUnits isEqualTo []) then {
			_newDriver = _groupUnits call BIS_fnc_selectRandom2;	//Find another unit to serve as driver
			_nul = [_newDriver,_vehicle] spawn {
				private ["_newDriver","_vehicle"];
				_newDriver = _this select 0;
				_vehicle = _this select 1;
				unassignVehicle _newDriver;
				_newDriver assignAsDriver _vehicle;
				if (_newDriver in _vehicle) then {
					_newDriver moveInDriver _vehicle;
				};
				[_newDriver] orderGetIn true;
				_newDriver setVariable ["isDriver",true];
				if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Replaced driver unit for group %1 vehicle %2.",(group _newDriver),(typeOf _vehicle)];};
			};
		};
	};
};

true
