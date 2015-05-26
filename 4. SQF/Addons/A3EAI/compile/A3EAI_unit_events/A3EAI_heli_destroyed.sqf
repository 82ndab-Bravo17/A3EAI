private ["_vehicle","_unitGroup","_unitLevel"];

_vehicle = (_this select 0);
_unitGroup = _vehicle getVariable ["unitGroup",grpNull];

if (isNull _vehicle) exitWith {};
if (_vehicle getVariable ["vehicle_disabled",false]) exitWith {
	if ((_unitGroup getVariable ["unitType",""]) isEqualTo "air_reinforce") then {
		//diag_log format ["Debug: %1",__FILE__];
		{_vehicle removeAllEventHandlers _x} count ["HandleDamage","GetOut","Killed"];
		_unitGroup setVariable ["GroupSize",-1];
		if !(isDedicated) then {
			A3EAI_updateGroupSize_PVS = [_unitGroup,-1];
			publicVariableServer "A3EAI_updateGroupSize_PVS";
		};
	};
	false
};

{_vehicle removeAllEventHandlers _x} count ["HandleDamage","GetOut","Killed"];
_vehicle setVariable ["vehicle_disabled",true];
_vehicle call A3EAI_respawnAIVehicle;
if !(isNil {_unitGroup getVariable "dummyUnit"}) exitWith {};

if !(surfaceIsWater (getPosASL _vehicle)) then {
	_unitLevel = _unitGroup getVariable ["unitLevel",1];
	_unitGroup setVariable ["unitType","aircrashed"];	//Recategorize group as "aircrashed" to prevent AI inventory from being cleared since death is considered suicide.
	{
		if (alive _x) then {
			_x action ["eject",_vehicle];
			_nul = [_x,objNull] call A3EAI_handleDeathEvent;
			0 = [_x,_unitLevel] spawn A3EAI_generateLoot;
		};
	} count (units _unitGroup);
};

_unitGroup setVariable ["GroupSize",-1];
if !(isDedicated) then {
	A3EAI_updateGroupSize_PVS = [_unitGroup,-1];
	publicVariableServer "A3EAI_updateGroupSize_PVS";
};

if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Group %1 %2 destroyed at %3",_unitGroup,(typeOf _vehicle),mapGridPosition _vehicle];};
true
