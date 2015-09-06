private ["_message"];

_message = _this;
if ((typeName _message) isEqualTo "STRING") then {
	systemChat _message;
};

true