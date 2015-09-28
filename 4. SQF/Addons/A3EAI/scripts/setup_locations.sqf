#include "\A3EAI\globaldefines.hpp"

/*
	Reads from CfgWorlds config and extracts information about city/town names, positions, and types.

	Used to generate waypoint positions for AI vehicle patrols.
*/

private ["_cfgWorldName","_startTime","_allPlaces","_telePositions","_allLocations"];

_startTime = diag_tickTime;
_allPlaces = [];
_telePositions = [];
_allLocations = [];
_cfgWorldName = configFile >> "CfgWorlds" >> worldName >> "Names";

for "_i" from 0 to ((count _cfgWorldName) -1) do {
	_allPlaces set [(count _allPlaces),configName (_cfgWorldName select _i)];
	//diag_log format ["DEBUG :: Added location %1 to allPlaces array.",configName (_cfgWorldName select _i)];
};

//Add user-specified blacklist areas
{
	A3EAI_waypointBlacklistAir set [_forEachIndex,(toLower _x)]; //Ensure case-insensitivity
	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Created AI vehicle waypoint blacklist at %1.",_x];};
	if ((_forEachIndex % 3) isEqualTo 0) then {uiSleep 0.05};
} forEach A3EAI_waypointBlacklistAir;

{
	A3EAI_waypointBlacklistLand set [_forEachIndex,(toLower _x)]; //Ensure case-insensitivity
	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Created AI vehicle waypoint blacklist at %1.",_x];};
	if ((_forEachIndex % 3) isEqualTo 0) then {uiSleep 0.05};
} forEach A3EAI_waypointBlacklistLand;

//Set up trader city blacklist areas
{
	if ((nearestLocations [_x select 3,[BLACKLIST_OBJECT_GENERAL],30]) isEqualTo []) then {
		_location = [_x select 3,BLACKLIST_AREA_SIZE] call A3EAI_createBlackListArea;
		_telePositions pushBack (_x select 3);
		if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Created %1m radius blacklist area at %2 teleport destination (%3).",BLACKLIST_AREA_SIZE,_x select 0,_x select 3];};
	};
	if ((nearestLocations [_x select 3,[BLACKLIST_OBJECT_NOAGGRO],30]) isEqualTo []) then {
		_location = [_x select 3,NO_AGGRO_AREA_SIZE] call A3EAI_createNoAggroArea;
		if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Created %1m radius no-aggro area at %2 teleport destination (%3).",NO_AGGRO_AREA_SIZE,_x select 0,_x select 3];};
	};
	if ((_forEachIndex % 3) isEqualTo 0) then {uiSleep 0.05};
} forEach ([configFile >> "CfgEpoch" >> worldName,"telePos",[]] call BIS_fnc_returnConfigEntry);

{
	_placeType = toLower (getText (_cfgWorldName >> _x >> "type"));
	if (_placeType in ["namecitycapital","namecity","namevillage","namelocal"]) then {
		_placeName = getText (_cfgWorldName >> _x >> "name");
		_placePos = [] + getArray (_cfgWorldName >> _x >> "position");
		_isAllowedPos = (((_placePos distance2D (getMarkerPos "respawn_west")) > BLACKLIST_AREA_SIZE) && {({(_x distance2D _placePos) < BLACKLIST_AREA_SIZE} count _telePositions) isEqualTo 0});
		if (_isAllowedPos) then {
			A3EAI_locations pushBack [_placeName,_placePos,_placeType];
			if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Added location %1 (type: %2, pos: %3) to location list.",_placeName,_placeType,_placePos];};
			if !(_placeName in A3EAI_waypointBlacklistAir) then {A3EAI_locationsAir pushBack [_placeName,_placePos,_placeType];};
			if !((_placeName in A3EAI_waypointBlacklistLand) && {!(surfaceIsWater _placePos)}) then {A3EAI_locationsLand pushBack [_placeName,_placePos,_placeType];};
		} else {
			if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: %1 not in allowed position. Blacklist (Air): %2, Blacklist (Land): %3, respawn_west: %4, telepos: %5.",_placeName,!((toLower _placeName) in A3EAI_waypointBlacklistAir),!((toLower _placeName) in A3EAI_waypointBlacklistLand),(_placePos distance2D (getMarkerPos "respawn_west")) > BLACKLIST_AREA_SIZE,({(_x distance2D _placePos) < BLACKLIST_AREA_SIZE} count _telePositions) isEqualTo 0];};
		};
		_allLocations pushBack [_placeName,_placePos,_placeType];
	};
	if ((_forEachIndex % 10) isEqualTo 0) then {uiSleep 0.05};
} forEach _allPlaces;

//Auto-adjust random spawn limit
if (isDedicated && {A3EAI_maxRandomSpawns isEqualTo -1}) then {
	A3EAI_maxRandomSpawns = ((round (0.10 * (count _allLocations)) min 15) max 5);
	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Adjusted random spawn limit to %1",A3EAI_maxRandomSpawns];};
};

if (A3EAI_locations isEqualTo []) then {
	A3EAI_locations = +_allLocations;
	if (A3EAI_debugLevel > 1) then {diag_log "A3EAI Debug: A3EAI_locations is empty, using _allLocations array instead.";};
};

if (A3EAI_locationsAir isEqualTo []) then {
	A3EAI_locationsAir = +_allLocations;
	if (A3EAI_debugLevel > 1) then {diag_log "A3EAI Debug: A3EAI_locationsAir is empty, using _allLocations array instead.";};
};

if (A3EAI_locationsLand isEqualTo []) then {
	A3EAI_locationsLand = +_allLocations;
	if (A3EAI_debugLevel > 1) then {diag_log "A3EAI Debug: A3EAI_locationsLand is empty, using _allLocations array instead.";};
};

A3EAI_locations_ready = true;

if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Location configuration completed with %1 locations found in %2 seconds.",(count A3EAI_locations),(diag_tickTime - _startTime)]};
