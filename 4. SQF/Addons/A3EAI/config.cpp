class CfgPatches {
	class A3EAI {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		A3EAIVersion = "0.6.0 Alpha";
		A3EAI_requiredHCVersion = "3";
		requiredAddons[] = {"a3_epoch_code"};
	};
	class A3EAI_HC {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		A3EAI_HCVersion = "3";
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
