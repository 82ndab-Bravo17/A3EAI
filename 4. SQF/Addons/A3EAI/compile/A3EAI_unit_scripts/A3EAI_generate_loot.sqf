private ["_unit", "_unitLevel", "_weaponLoot", "_loot", "_toolLoot", "_pistol", "_magazine", "_kryptoAmountMax", "_kryptoAmount", "_kryptoPos", "_kryptoDevice", "_toolsArray", "_item"];

_unit = _this select 0;
_unitLevel = _this select 1;

if (_unit getVariable ["LootGenerated",false]) exitWith {};
_unit setVariable ["LootGenerated",true];

if (A3EAI_debugLevel > 1) then {diag_log format["A3EAI Extended Debug: Generating loot for AI unit with unitLevel %2.",_unit,_unitLevel];};

_weaponLoot = [];
_loot = [];
_toolLoot = [];

//Generate a pistol if one wasn't assigned with loadout script.
if !((primaryWeapon _unit) isEqualTo "") then {
	_pistol = A3EAI_pistolList call BIS_fnc_selectRandom2;
	_magazine = getArray (configFile >> "CfgWeapons" >> _pistol >> "magazines") select 0;
	_unit addMagazine _magazine;	
	_unit addWeapon _pistol;
	if (A3EAI_debugLevel > 1) then {
		_weaponLoot pushBack _pistol;
		_weaponLoot pushBack _magazine
	};
};

//Generate Krypto
_kryptoAmountMax = missionNamespace getVariable ["A3EAI_kryptoAmount"+str(_unitLevel),0];
_kryptoAmount = floor (random (_kryptoAmountMax + 1));
if(_kryptoAmount > 0) then {
	_kryptoPos = getPosATL _unit;
	_kryptoDevice = createVehicle ["Land_MPS_EPOCH",_kryptoPos,[],1.5,"CAN_COLLIDE"];
	_kryptoDevice setVariable ["Crypto",_kryptoAmount,true];
	_unit setVariable ["KryptoDevice",_kryptoDevice];
	_kryptoPosEmpty = _kryptoPos findEmptyPosition [0.5,1.5,"Land_MPS_EPOCH"];
	if !(_kryptoPosEmpty isEqualTo []) then {
		_kryptoDevice setPosATL _kryptoPosEmpty;
	};
};

//Add tool items
_toolsArray = missionNamespace getVariable ["A3EAI_tools"+str(_unitLevel),[]];
{
	_item = _x select 0;
	if (((_x select 1) call A3EAI_chance) && {[_item,"weapon"] call A3EAI_checkClassname}) then {
		_unit addWeapon _item;
		if (A3EAI_debugLevel > 1) then {
			_toolLoot pushBack _item;
		};
	}
} forEach _toolsArray;

if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Generated loot for AI death: %1,%2,%3. Krypto: %4.",_weaponLoot,_loot,_toolLoot,_kryptoAmount];};
