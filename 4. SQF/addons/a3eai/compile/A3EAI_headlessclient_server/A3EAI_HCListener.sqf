#include "\A3EAI\globaldefines.hpp"

private ["_HCObject","_versionHC","_compatibleVersions","_positionHC","_useRemoteConfigs"];
_HCObject = _this select 0;
_versionHC = _this select 1;
_useRemoteConfigs = _this select 2;

A3EAI_HC_serverResponse = false;
if (((owner A3EAI_HCObject) isEqualTo 0) && {(typeOf _HCObject) isEqualTo "HeadlessClient_F"}) then {
	_compatibleVersions = [configFile >> "CfgPatches" >> "A3EAI","compatibleHCVersions",[]] call BIS_fnc_returnConfigEntry;
	if (_versionHC in _compatibleVersions) then {
		A3EAI_HCObject = _HCObject;
		A3EAI_HCObject allowDamage false;
		A3EAI_HCObject enableSimulationGlobal false;
		A3EAI_HCObject addEventHandler ["Local",{
			if (_this select 1) then {
				private["_unit","_unitGroup"];
				A3EAI_HCIsConnected = false;
				A3EAI_HCObjectOwnerID = 0;
				A3EAI_HCObject = objNull;
				_unit = _this select 0;
				_unitGroup = (group _unit);
				_unit removeAllEventHandlers "Local";
				if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Deleting disconnected headless client unit %1.",typeOf _unit];};
				deleteVehicle _unit;
				deleteGroup _unitGroup;
			};
		}];
		A3EAI_HCObjectOwnerID = (owner A3EAI_HCObject);
		A3EAI_HCIsConnected = true;
		A3EAI_HC_serverResponse = if (_useRemoteConfigs) then {
			A3EAI_pushedHCVariables
		} else {
			true
		};
		_positionHC = getPosATL A3EAI_HCObject;
		if (({if (_positionHC in _x) exitWith {1}} count (nearestLocations [_positionHC,[BLACKLIST_OBJECT_GENERAL],BLACKLIST_AREA_HC_SIZE])) isEqualTo 0) then {
			[_positionHC,TEMP_BLACKLIST_AREA_HC_SIZE] call A3EAI_createBlackListArea;
			diag_log format ["[A3EAI] Created 750m radius blacklist area at HC position %1",_positionHC];
		};
		diag_log format ["[A3EAI] Headless client %1 (owner: %2) logged in successfully.",A3EAI_HCObject,A3EAI_HCObjectOwnerID];
	} else {
		diag_log format ["[A3EAI] Headless client %1 (owner: %2) has wrong A3EAI version %3 (Compatible versions: %4).",_HCObject,owner _HCObject,_versionHC,_compatibleVersions];
	};
} else {
	diag_log format ["[A3EAI] Rejecting connection from HC %1. A headless client is already connected: %2. Client object type: %3.",(_this select 1),!((owner A3EAI_HCObject) isEqualTo 0),typeOf _HCObject];
};

(owner _HCObject) publicVariableClient "A3EAI_HC_serverResponse";
