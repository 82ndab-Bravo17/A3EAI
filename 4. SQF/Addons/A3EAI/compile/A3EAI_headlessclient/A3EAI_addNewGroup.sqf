private ["_unitGroup", "_unitLevel", "_trigger", "_unitType", "_groupSize", "_functionCall", "_check", "_lootPool","_miscData"];
	
_unitGroup = _this select 0;
_unitLevel = _this select 1;
_trigger = _this select 2;
_unitType = _this select 3;
_groupSize = _this select 4;
_lootPool = _this select 5;
_miscData = if ((count _this) > 6) then {_this select 6};

{
	_x call A3EAI_addEH;
} forEach (units _unitGroup);

_unitGroup setVariable ["unitLevel",_unitLevel];
_unitGroup setVariable ["trigger",_trigger];
_unitGroup setVariable ["unitType",_unitType];
_unitGroup setVariable ["GroupSize",_groupSize];
if !(_lootPool isEqualTo []) then {_unitGroup setVariable ["LootPool",_lootPool];};
if !(isNil "_miscData") then {
	call {
		if (_unitType isEqualTo "dynamic") exitWith {
			_unitGroup setVariable ["targetplayer",_miscData];
			if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Dynamic group %1 has target player %2.",_unitGroup,_miscData];};
		};
	};
};

_functionCall = missionNamespace getVariable ["A3EAI_handle"+_unitType,{false}];
_check = _unitGroup call _functionCall;
//if (_check) then {diag_log format ["Debug: Function %1 call successful","A3EAI_handle"+_unitType]} else {diag_log format ["Debug: Function %1 not found.","A3EAI_handle"+_unitType]};

if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: HC received new group from server: %1. Processing new group with function %2.",_unitGroup,("A3EAI_handle"+_unitType)];};

0 = [_unitGroup,_unitLevel] spawn A3EAI_addGroupManager;

A3EAI_HCGroupsCount = A3EAI_HCGroupsCount + 1;

true