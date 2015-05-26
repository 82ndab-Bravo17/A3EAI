private ["_unitGroup","_detectBase","_detectFactor","_vehicle","_canParaDrop","_detectStartPos"];
_unitGroup = _this select 0;

if (_unitGroup getVariable ["EnemiesIgnored",false]) then {[_unitGroup,"Behavior_Reset"] call A3EAI_forceBehavior};

_vehicle = vehicle (leader _unitGroup);
uiSleep 2;

if (_unitGroup getVariable ["HeliDetectReady",true]) then {
	_unitGroup setVariable ["HeliDetectReady",false];
	_detectStartPos = getPosASL _vehicle;
	_detectStartPos set [2,0];
	_canParaDrop = ((_unitGroup getVariable ["HeliReinforceOrdered",false]) or {(A3EAI_paraDropChance call A3EAI_chance) && {(diag_tickTime - (_unitGroup getVariable ["HeliLastParaDrop",-A3EAI_paraDropCooldown])) > A3EAI_paraDropCooldown}});
	while {!(_vehicle getVariable ["vehicle_disabled",false]) && {(_unitGroup getVariable ["GroupSize",-1]) > 0} && {local _unitGroup}} do {
		private ["_detected","_detectOrigin","_startPos"];
		//diag_log format ["DEBUG: Group %1 AI %2 is beginning detection sweep...",_unitGroup,(typeOf _vehicle)];
		_startPos = getPosATL _vehicle;
		_detectOrigin = [_startPos,0,getDir _vehicle,1] call SHK_pos;
		_detectOrigin set [2,0];
		_detected = _detectOrigin nearEntities [["Epoch_Male_F","Epoch_Female_F","LandVehicle"],500];
		if ((count _detected) > 10) then {_detected resize 10};
		//diag_log format ["DEBUG: Group %1 AI %2 has paradrop available: %3",_unitGroup,(typeOf _vehicle),((diag_tickTime - (_unitGroup getVariable ["HeliLastParaDrop",diag_tickTime])) > 1800)];
		{
			if ((isPlayer _x) && {(_unitGroup knowsAbout _x) < 4}) then {
				if (_canParaDrop) then {
					if (_unitGroup getVariable ["HeliReinforceOrdered",false]) then {
						_unitGroup setVariable ["HeliReinforceOrdered",false];
					} else {
						_unitGroup setVariable ["HeliLastParaDrop",diag_tickTime];
					};
					_nul = [_unitGroup,_vehicle,_x] spawn A3EAI_heliParaDrop;
					if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: %1 group %2 is deploying paradrop reinforcements at %3.",(typeOf _vehicle),_unitGroup,_detectOrigin];};
				};
				//diag_log format ["DEBUG: Group %1 AI %2 is checking LOS with player %3...",_unitGroup,(typeOf _vehicle),_x];
				_heliAimPos = aimPos _vehicle;
				_playerEyePos = eyePos _x;
				if (!(terrainIntersectASL [_heliAimPos,_playerEyePos]) && {!(lineIntersects [_heliAimPos,_playerEyePos,_vehicle,_x])} && {A3EAI_detectChance call A3EAI_chance}) then { //if no intersection of terrain and objects between helicopter and player, then reveal player
					_unitGroup reveal [_x,2]; 
				};
				_canParaDrop = false;
			};
			uiSleep 0.1;
		} forEach _detected;
		if (((_vehicle distance _detectStartPos) > 600) or {_vehicle getVariable ["vehicle_disabled",false]}) exitWith {_unitGroup setVariable ["HeliDetectReady",true]};
		uiSleep 15;
	};
};
