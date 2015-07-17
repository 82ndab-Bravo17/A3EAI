private ["_unit","radio"];
_unit = _this;
_radio = {if ((_x find "EpochRadio") > -1) exitWith {1}} count (assignedItems _unit);

(_radio isEqualTo 1)