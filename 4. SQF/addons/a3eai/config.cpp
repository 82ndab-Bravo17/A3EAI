class CfgPatches {
	class A3EAI {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		A3EAIVersion = "1.0.1a";
		compatibleConfigVersions[] = {"1.0.0","1.0.0a","1.0.0b","1.0.0c","1.0.0d","1.0.1","1.0.1a"};
		compatibleHCVersions[] = {}; //HC not currently supported since Epoch client code execution prevention does not currently work.
		requiredAddons[] = {"a3_epoch_code"};
	};
	class A3EAI_HC {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		A3EAI_HCVersion = "Non-functional";
		requiredAddons[] = {"a3_epoch_code"};
	};
};

class CfgFunctions {
	class A3EAI {
		class A3EAI_Server {
			file = "A3EAI";
			
			class A3EAI_init {
				preInit = 1;
			};
		};
	};
};

class CfgNonAIVehicles {
	class A3EAI_EmptyDetector {
		displayName="A3EAI Trigger";
		icon = "\a3\Ui_f\data\IGUI\Cfg\IslandMap\iconSensor_ca.paa";
		model = "";
		scope = public;
		selectionFabric = "latka";
		simulation="detector";
	};
};

class CfgLocationTypes {
	class A3EAI_BlacklistedArea {
		color[] = {0.91,0,0,1};
		drawStyle = "name";
		font = "PuristaMedium";
		name = "A3EAI Blacklist Area";
		shadow = 1;
		size = 15;
		textSize = 0.05;
		texture = "";
	};
	class A3EAI_NoAggroArea {
		color[] = {0.91,0,0,1};
		drawStyle = "name";
		font = "PuristaMedium";
		name = "A3EAI No-Aggro Area";
		shadow = 1;
		size = 15;
		textSize = 0.05;
		texture = "";
	};
	class A3EAI_RandomSpawnArea {
		color[] = {0.91,0,0,1};
		drawStyle = "name";
		font = "PuristaMedium";
		name = "A3EAI Random Spawn Area";
		shadow = 1;
		size = 15;
		textSize = 0.05;
		texture = "";
	};
	class A3EAI_DynamicSpawnArea {
		color[] = {0.91,0,0,1};
		drawStyle = "name";
		font = "PuristaMedium";
		name = "A3EAI Dynamic Spawn Area";
		shadow = 1;
		size = 15;
		textSize = 0.05;
		texture = "";
	};
};
