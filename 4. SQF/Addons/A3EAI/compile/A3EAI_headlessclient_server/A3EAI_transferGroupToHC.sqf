private ["_unitGroup", "_unitLevel", "_trigger", "_unitType", "_groupSize","_lootPool","_miscData","_groupData""_result"];
_unitGroup = _this;

if ((diag_tickTime - A3EAI_lastGroupTransfer) < 5) exitWith {false};
A3EAI_lastGroupTransfer = diag_tickTime;

_unitLevel = _unitGroup getVariable ["unitLevel",0];
_trigger = _unitGroup getVariable ["trigger",objNull];
_unitType = _unitGroup getVariable ["unitType","unknown"];
_groupSize = _unitGroup getVariable ["GroupSize",nil];
_lootPool = _unitGroup getVariable ["LootPool",[]];
_miscData = _unitGroup getVariable ["MiscData",nil];

if (_unitType in ["air","land","aircustom","landcustom","air_reinforce"]) then {_trigger = _unitGroup getVariable ["assignedVehicle",(assignedVehicle (leader _unitGroup))]};
_groupData = [_unitGroup,_unitLevel,_trigger,_unitType,_groupSize,_lootPool];
if (!isNil "_miscData") then {_groupData pushBack _miscData};
A3EAI_transferGroup_PVC = _groupData;
A3EAI_HCObjectOwnerID publicVariableClient "A3EAI_transferGroup_PVC";

_result = _unitGroup setGroupOwner A3EAI_HCObjectOwnerID;

_result