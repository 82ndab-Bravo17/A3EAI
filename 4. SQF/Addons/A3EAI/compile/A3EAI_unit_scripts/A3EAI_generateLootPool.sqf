#define FIRST_AID_ITEM_PLAYER "FAK"

private ["_lootPool", "_groupSize", "_unitType", "_lootUnit", "_unitGroup", "_lootItem"];

_unitGroup = _this;

_lootPool = _unitGroup getVariable ["LootPool",[]];
_groupSize = _unitGroup getVariable ["GroupSize",0];
_unitType = _unitGroup getVariable ["unitType",""];

if (_unitType != "dynamic") then {
	for "_j" from 1 to _groupSize do {
		//Add first aid kit to loot list
		if (A3EAI_chanceFirstAidKit call A3EAI_chance) then {
			_lootPool pushBack FIRST_AID_ITEM_PLAYER;
		};

		//Add food to loot list
		for "_i" from 1 to A3EAI_foodLootCount do {
			if (A3EAI_chanceFoodLoot call A3EAI_chance) then {
				_lootPool pushBack (A3EAI_foodLoot call A3EAI_selectRandom);
			};
		};

		//Add items to loot list
		for "_i" from 1 to A3EAI_miscLootCount1 do {
			if (A3EAI_chanceMiscLoot1 call A3EAI_chance) then {
				_lootPool pushBack (A3EAI_MiscLoot1 call A3EAI_selectRandom);
			};
		};

		//Add items to loot list
		for "_i" from 1 to A3EAI_miscLootCount2 do {
			if (A3EAI_chanceMiscLoot2 call A3EAI_chance) then {
				_lootPool pushBack (A3EAI_MiscLoot2 call A3EAI_selectRandom);
			};
		};
		
		sleep 0.5;
	};
} else {
	//Generate loot all at once for dynamic AI
	for "_i" from 1 to _groupSize do {
		//Add first aid kit to loot list
		if (A3EAI_chanceFirstAidKit call A3EAI_chance) then {
			_lootUnit = (units _unitGroup) call A3EAI_selectRandom;
			[_lootUnit,A3EAI_chanceFirstAidKit] call A3EAI_addItem;
		};

		//Add food to loot list
		for "_i" from 1 to A3EAI_foodLootCount do {
			if (A3EAI_chanceFoodLoot call A3EAI_chance) then {
				_lootUnit = (units _unitGroup) call A3EAI_selectRandom;
				_lootItem = (A3EAI_foodLoot call A3EAI_selectRandom);
				[_lootUnit,_lootItem] call A3EAI_addItem;
			};
		};

		//Add items to loot list
		for "_i" from 1 to A3EAI_miscLootCount1 do {
			if (A3EAI_chanceMiscLoot1 call A3EAI_chance) then {
				_lootUnit = (units _unitGroup) call A3EAI_selectRandom;
				_lootItem = (A3EAI_MiscLoot1 call A3EAI_selectRandom);
				[_lootUnit,_lootItem] call A3EAI_addItem;
			};
		};

		//Add items to loot list
		for "_i" from 1 to A3EAI_miscLootCount2 do {
			if (A3EAI_chanceMiscLoot2 call A3EAI_chance) then {
				_lootUnit = (units _unitGroup) call A3EAI_selectRandom;
				_lootItem = (A3EAI_MiscLoot2 call A3EAI_selectRandom);
				[_lootUnit,_lootItem] call A3EAI_addItem;
			};
		};
		
		sleep 0.5;
	};
};


//Update local group loot pool
_unitGroup setVariable ["LootPool",_lootPool];

true