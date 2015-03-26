private ["_unitGroup", "_vehicle", "_unitsAlive", "_unitLevel", "_trigger", "_rearm" ,"_pos"];
	
_unitGroup = _this select 0;
_vehicle = _this select 1;

_pos = getPosATL _vehicle;
_pos set [2,0];
_unitsAlive = {alive _x} count (units _unitGroup);
_unitLevel = _unitGroup getVariable ["unitLevel",1];

_trigger = createTrigger ["EmptyDetector",_pos];
_trigger enableSimulationGlobal false;
_trigger setTriggerArea [600, 600, 0, false];
_trigger setTriggerActivation ["ANY", "PRESENT", true];
_trigger setTriggerTimeout [5, 5, 5, true];
_trigger setTriggerText (format ["AI Vehicle Group %1",mapGridPosition _vehicle]);
_trigger setTriggerStatements ["{if (isPlayer _x) exitWith {1}} count thisList != 0;","","0 = [thisTrigger] spawn A3EAI_despawn_static;"];
_trigger setVariable ["isCleaning",false];
_trigger setVariable ["GroupArray",[_unitGroup]];
_trigger setVariable ["unitLevel",_unitLevel];
_trigger setVariable ["maxUnits",[_unitsAlive,0]];
_trigger setVariable ["respawn",false]; 					//landed AI units should never respawn
_trigger setVariable ["permadelete",true]; 	//units should be permanently despawned
_trigger setVariable ["spawnType","static"];

_unitGroup setVariable ["GroupSize",_unitsAlive];
_unitGroup setVariable ["unitType","static"];
_unitGroup setVariable ["trigger",_trigger];

[_trigger,"A3EAI_staticTriggerArray"] call A3EAI_updateSpawnCount;
0 = [_trigger] spawn A3EAI_despawn_static;

if !(A3EAI_HCObjectOwnerID isEqualTo 0) then {
	A3EAI_sendGroupTriggerVars_PVC = [[_unitGroup,_trigger],[_unitGroup],75,1,1,[_unitsAlive,0],0,"static",false,true];
	A3EAI_HCObjectOwnerID publicVariableClient "A3EAI_sendGroupTriggerVars_PVC";
};

_trigger enableSimulation true;

true