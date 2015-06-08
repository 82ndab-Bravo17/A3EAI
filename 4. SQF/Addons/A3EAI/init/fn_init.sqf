if !(isNil "Epoch_CStart") exitWith { false };
Epoch_CStart = true;

if ((hasInterface) && {!isDedicated}) then {
	call compile preprocessFileLineNumbers "\x\addons\a3_epoch_code\init\both_init.sqf";
	call compile preprocessFileLineNumbers "\x\addons\a3_epoch_code\init\client_compile.sqf";
};

true
