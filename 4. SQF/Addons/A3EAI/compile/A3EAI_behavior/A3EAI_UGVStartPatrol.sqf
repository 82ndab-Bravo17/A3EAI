private ["_unitGroup","_tooClose","_wpSelect"];
_unitGroup = _this select 0;

_tooClose = true;
while {_tooClose} do {
	_wpSelect = (A3EAI_locationsLand call A3EAI_selectRandom) select 1;
	if (((waypointPosition [_unitGroup,0]) distance _wpSelect) > 300) then {
		_tooClose = false;
	} else {
		uiSleep 0.1;
	};
};

_wpSelect = [_wpSelect,random(300),random(360),0,[1,300]] call SHK_pos;
[_unitGroup,0] setWPPos _wpSelect;
[_unitGroup,1] setWPPos _wpSelect;
_unitGroup setCurrentWaypoint [_unitGroup,0];
