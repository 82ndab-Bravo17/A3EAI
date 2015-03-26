private ["_unitGroup", "_unitLevel", "_trigger", "_unitType", "_groupSize","_lootPool","_miscData","_groupData"];
_unitGroup = _this select 0;

_unitLevel = _unitGroup getVariable ["unitLevel",0];
_trigger = _unitGroup getVariable ["trigger",objNull];
_unitType = _unitGroup getVariable ["unitType","unknown"];
_groupSize = _unitGroup getVariable ["GroupSize",nil];
_lootPool = _unitGroup getVariable ["LootPool",[]];
_miscData = _unitGroup getVariable ["MiscData",nil];

_groupData = [_unitGroup,_unitLevel,_trigger,_unitType,_groupSize,_lootPool];
if (!isNil "_miscData") then {_groupData pushBack _miscData};
A3EAI_transferGroup_PVC = _groupData;
A3EAI_HCObjectOwnerID publicVariableClient "A3EAI_transferGroup_PVC";

true