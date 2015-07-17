#define TRANSMIT_RANGE 50 //distance to broadcast radio text around target player (target player will also recieve messages)
#define SEEK_RANGE 450 //distance to chase player from initial group spawn location

private ["_unitGroup", "_targetPlayer", "_waypoint", "_leader", "_nearbyUnits", "_index", "_radioSpeech", "_searchPos","_triggerPos"];

_unitGroup = _this;

_triggerPos = getPosATL (_unitGroup getVariable ["trigger",objNull]);
_targetPlayer = _unitGroup getVariable ["targetplayer",objNull];

if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Hunter group %1 has target player %2 and anchor pos %3.",_unitGroup,_targetPlayer,_triggerPos];};

if (
	(isPlayer _targetPlayer) && 
	{(vehicle _targetPlayer) isKindOf "Land"} &&
	{(_targetPlayer distance _triggerPos) < SEEK_RANGE}
) then {
	_waypoint = [_unitGroup,0];
	if (((getWPPos _waypoint) distance _targetPlayer) > 20) then {
		_waypoint setWPPos (getPosATL _targetPlayer);
		//diag_log format ["Debug: Hunter group %1 is seeking player %2 (position: %3).",_unitGroup,_targetPlayer,(getPosATL _targetPlayer)];
	} else {
		_searchPos = [(getWPPos _waypoint),50+(random 50),(random 360),0] call SHK_pos;
		_waypoint setWPPos _searchPos;
	};
	
	if ((_unitGroup knowsAbout _targetPlayer) < 4) then {_unitGroup reveal [_targetPlayer,4]};
	_unitGroup setCurrentWaypoint _waypoint;
	
	if (A3EAI_radioMsgs) then {
		_leader = (leader _unitGroup);
		if ((_leader distance _targetPlayer) < 250) then {
			_nearbyUnits = (getPosATL _targetPlayer) nearEntities [["LandVehicle","Epoch_Male_F","Epoch_Female_F"],TRANSMIT_RANGE];
			if !(_nearbyUnits isEqualTo []) then {
				if ((count _nearbyUnits) > 10) then {_nearbyUnits resize 10;};
				if ((_unitGroup getVariable ["GroupSize",0]) > 1) then {
					_index = (floor (random 4));
					_radioSpeech = call {
						if (_index isEqualTo 0) exitWith {[11,[(name _leader),(name _targetPlayer)]]};
						if (_index isEqualTo 1) exitWith {[12,[(name _leader),(getText (configFile >> "CfgVehicles" >> (typeOf _targetPlayer) >> "displayName"))]]};
						if (_index isEqualTo 2) exitWith {[13,[(name _leader),round (_leader distance _targetPlayer)]]};
						if (_index > 2) exitWith {[0,[]]};
						[0,[]]
					};
					{
						if ((isPlayer _x) && {({if ("EpochRadio0" in (assignedItems _x)) exitWith {1}} count (crew (vehicle _x))) > 0}) then {
							[_x,_radioSpeech] call A3EAI_radioSend;
						};
					} count _nearbyUnits;
				} else {
					{
						if ((isPlayer _x) && {({if ("EpochRadio0" in (assignedItems _x)) exitWith {1}} count (crew (vehicle _x))) > 0}) then {
							[_x,[0,[]]] call A3EAI_radioSend;
						};
					} count _nearbyUnits;
				};
			};
		};
	};
	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Dynamic group %1 has located player %2.",_unitGroup,_targetPlayer];};
} else {
	[_unitGroup,0] setWaypointStatements ["true","if (local this) then {if ((random 1) < 0.50) then { group this setCurrentWaypoint [(group this), (floor (random (count (waypoints (group this)))))];};};"];
	0 = [_unitGroup,_triggerPos,150] spawn A3EAI_BIN_taskPatrol;
	{_x enableFatigue true;} count (units _unitGroup);
	_unitGroup setSpeedMode "NORMAL";
	if (A3EAI_enableHC && {isDedicated}) then {_unitGroup setVariable ["MiscData",nil];};
	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Dynamic group %1 is patrolling area.",_unitGroup];};
};
