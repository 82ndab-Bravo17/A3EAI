private ["_arrayData", "_unitGroup", "_trigger"];
_arrayData = _this;
_unitGroup = (_arrayData select 0) select 0;
_trigger = (_arrayData select 0) select 1;
_unitGroup setVariable ["trigger",_trigger]; //Link group to trigger.

//diag_log format ["Debug: Set group %1 trigger to %2.",_unitGroup,_trigger];

//Remove array headers
_arrayData deleteAt 0;

{
	_trigger setVariable [_x,_arrayData select _forEachIndex];
	//diag_log format ["Debug: Group %1 variable %2 has value %3.",_unitGroup,_x,_arrayData select _forEachIndex];
} forEach [
	"GroupArray",
	"patrolDist",
	"unitLevel",
	"unitLevelEffective",
	"maxUnits",
	"spawnChance",
	"spawnType",
	"respawn",
	"permadelete"
];
