class CfgPatches {
	class A3EAI {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		A3EAIVersion = "0.5.6 Alpha";
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
