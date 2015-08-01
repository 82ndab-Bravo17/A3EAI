class CfgPatches {
	class A3EAI {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		A3EAIVersion = "0.8.2";
		A3EAICompatibleHCVersions[] = {"8"};
		requiredAddons[] = {"a3_epoch_code"};
	};
	class A3EAI_HC {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		A3EAI_HCVersion = "8";
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
