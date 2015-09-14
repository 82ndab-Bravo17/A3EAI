#define PLAYER_UNITS "Epoch_Male_F","Epoch_Female_F"
#define LOOT_HOLDER_CLASS "WH_Loot"

private ["_unitGroup","_searchRange","_searchType","_searchPoints","_posBetween","_trigger","_radius"];
_unitGroup = _this select 0;

if ((count (waypoints _unitGroup)) > 9) exitWith {};

_searchPoints = call {
	_trigger = _unitGroup getVariable "trigger";
	if (isNil "_trigger") exitWith {[]};
	_radius = (_trigger getVariable ["patrolDist",100])/2;
	_posBetween = [leader _unitGroup,_trigger] call A3EAI_getPosBetween;
	_searchType = floor (random 2);
	if (_searchType isEqualTo 0) exitWith {
		_objects = _posBetween nearObjects [LOOT_HOLDER_CLASS,_radius];
		_objects
	};
	if (_searchType isEqualTo 1) exitWith {
		_objects = _posBetween nearEntities [[PLAYER_UNITS,"LandVehicle"],_radius];
		_objects
	};
	[]
};

{
	if ((count (waypoints _unitGroup)) > 9) exitWith {};
	_waypoint = [_unitGroup,getPosATL _x] call A3EAI_addTemporaryWaypoint;
} forEach _searchPoints;

true
