class CfgPatches {
	class A3EAI {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		A3EAIVersion = "0.9.2";
		A3EAICompatibleHCVersions[] = {"14"};
		requiredAddons[] = {"a3_epoch_code"};
	};
	class A3EAI_HC {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		A3EAI_HCVersion = "14";
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
	
	class A3E {
		class Client {
			file = "\A3EAI\init";
			
			class init {
				preInit = 1;
			};
			
			class postinit {
				postInit = 1;
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
