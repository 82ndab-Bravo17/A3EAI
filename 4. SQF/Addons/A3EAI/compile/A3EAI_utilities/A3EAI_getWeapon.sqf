#include "\A3EAI\globaldefines.hpp"

private ["_unitLevel", "_weaponIndices", "_weaponList", "_weaponsList", "_weaponSelected"];

_unitLevel = _this;

_weaponIndices = missionNamespace getVariable ["A3EAI_weaponTypeIndices"+str(_unitLevel),[0,1,2,3]];
_weaponList = ["A3EAI_pistolList","A3EAI_rifleList","A3EAI_machinegunList","A3EAI_sniperList"] select (_weaponIndices call A3EAI_selectRandom);
_weaponsList = missionNamespace getVariable [_weaponList,A3EAI_rifleList];
_weaponSelected = _weaponsList call A3EAI_selectRandom;

_weaponSelected