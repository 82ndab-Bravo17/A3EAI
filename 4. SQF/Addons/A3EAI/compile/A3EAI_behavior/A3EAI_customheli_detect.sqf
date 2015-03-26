private ["_detectOrigin", "_vehicle", "_detected", "_unitGroup", "_heliAimPos", "_playerAimPos"];

_vehicle = _this select 0;
_unitGroup = _this select 1;

if (_unitGroup getVariable ["IsDetecting",false]) exitWith {};
_unitGroup setVariable ["IsDetecting",true];

uiSleep (round (random 20));

if (!(_vehicle getVariable ["heli_disabled",false]) && {(_unitGroup getVariable ["GroupSize",-1]) > 0} && {local _unitGroup}) then{
	_detectOrigin = [getPosATL _vehicle,0,getDir _vehicle,1] call SHK_pos;
	_detectOrigin set [2,0];
	_detected = _detectOrigin nearEntities [["Epoch_Male_F","Epoch_Female_F"],500];
	if ((count _detected) > 10) then {_detected resize 10};
	{
		if ((isPlayer _x) && {(_unitGroup knowsAbout _x) < 1.5}) then {
			_heliAimPos = aimPos _vehicle;
			_playerAimPos = aimPos _x;
			if (!(terrainIntersectASL [_heliAimPos,_playerAimPos]) && {!(lineIntersects [_heliAimPos,_playerAimPos,_vehicle,_x])} && {A3EAI_detectChance call A3EAI_chance}) then { //if no intersection of terrain and objects between helicopter and player, then reveal player
				_unitGroup reveal [_x,2];
			};
		};
		uiSleep 0.1;
	} forEach _detected;
};

_unitGroup setVariable ["IsDetecting",false];
