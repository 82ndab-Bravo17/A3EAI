private ["_unitGroup","_detectBase","_detectFactor","_vehicle","_canParaDrop","_detectStartPos","_searchLength"];
_unitGroup = _this select 0;

if (_unitGroup getVariable ["EnemiesIgnored",false]) then {[_unitGroup,"Behavior_Reset"] call A3EAI_forceBehavior};

_vehicle = _unitGroup getVariable ["assignedVehicle",objNull];
_searchLength = _unitGroup getVariable "SearchLength";
if (isNil "_searchLength") then {_searchLength = (waypointPosition [_unitGroup,0]) distance (waypointPosition [_unitGroup,1]);};
if (_vehicle isKindOf "Plane") then {_searchLength = _searchLength * 2;};

if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Group %1 %2 detection started with search length %3.",_unitGroup,(typeOf (_vehicle)),_searchLength];};

if (_unitGroup getVariable ["HeliDetectReady",true]) then {
	_unitGroup setVariable ["HeliDetectReady",false];
	_detectStartPos = getPosATL _vehicle;
	_canParaDrop = ((diag_tickTime - (_unitGroup getVariable ["HeliLastParaDrop",-A3EAI_paraDropCooldown])) > A3EAI_paraDropCooldown);
	_vehicle flyInHeight (60 + (random 30));
	
	while {!(_vehicle getVariable ["vehicle_disabled",false]) && {(_unitGroup getVariable ["GroupSize",-1]) > 0} && {local _unitGroup}} do {
		private ["_detected","_detectOrigin","_startPos"];
		_detected = (getPosATL _vehicle) nearEntities [["Epoch_Male_F","Epoch_Female_F","LandVehicle"],500];
		if ((count _detected) > 5) then {_detected resize 5};
		{
			if ((isPlayer _x) && {(_unitGroup knowsAbout _x) < 2}) then {
				if (_canParaDrop) then {
					_canParaDrop = false;
					_unitGroup setVariable ["HeliLastParaDrop",diag_tickTime];
					_nul = [_unitGroup,_vehicle,_x] spawn A3EAI_heliParaDrop;
				};
				_heliAimPos = aimPos _vehicle;
				_playerEyePos = eyePos _x;
				if (!(terrainIntersectASL [_heliAimPos,_playerEyePos]) && {!(lineIntersects [_heliAimPos,_playerEyePos,_vehicle,_x])} && {A3EAI_airDetectChance call A3EAI_chance}) then { //if no intersection of terrain and objects between helicopter and player, then reveal player
					_unitGroup reveal [_x,2.5]; 
					if (({if ("EpochRadio0" in (assignedItems _x)) exitWith {1}} count (crew (vehicle _x))) > 0) then {
						[_x,[31+(floor (random 5)),[name (leader _unitGroup)]]] call A3EAI_radioSend;
					};
				};
			};
			uiSleep 0.1;
		} forEach _detected;
		if (((_vehicle distance _detectStartPos) > _searchLength) or {_vehicle getVariable ["vehicle_disabled",false]}) exitWith {_unitGroup setVariable ["HeliDetectReady",true]};
		uiSleep 15;
	};
	
	_vehicle flyInHeight (125 + (random 25));
};

if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Group %1 %2 detection end.",_unitGroup,(typeOf (_vehicle))];};
