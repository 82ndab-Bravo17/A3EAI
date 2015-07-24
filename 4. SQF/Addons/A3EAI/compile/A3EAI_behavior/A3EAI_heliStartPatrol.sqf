private ["_unitGroup","_tooClose","_detectionWaypoint","_exitWaypoint","_vehicle","_dir","_locationSelected"];
_unitGroup = _this select 0;

_vehicle = _unitGroup getVariable ["assignedVehicle",objNull];

_tooClose = true;
_locationSelected = [0,0,0];

while {_tooClose} do {
	_locationSelected = (A3EAI_locationsAir call A3EAI_selectRandom) select 1;
	if (((waypointPosition [_unitGroup,0]) distance _locationSelected) > 300) then {
		_tooClose = false;
	} else {
		uiSleep 0.1;
	};
};

_dir = [_locationSelected,_vehicle] call BIS_fnc_dirTo;
_detectionWaypoint = [_locationSelected,100+(random 700),_dir,1] call SHK_pos;
[_unitGroup,0] setWaypointPosition [_detectionWaypoint,0]; 

_dir = [_vehicle,_locationSelected] call BIS_fnc_dirTo;
_exitWaypoint = [_detectionWaypoint,600+(random 100),_dir,1] call SHK_pos;
[_unitGroup,1] setWaypointPosition [_exitWaypoint,0];
_unitGroup setCurrentWaypoint [_unitGroup,0];
