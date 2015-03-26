/*
	A3EAI Client-side Addon Configuration File
	
*/


/*	A3EAI Client Addon Settings
--------------------------------------------------------------------------------------------------------------------*/	

//Enables use of client-side radio functions. A3EAI_radioMsgs must be set 'true' in A3EAI_config.sqf.
A3EAIC_radio = true;

//Enables death messages to be displayed to players who kill AI units. A3EAI_deathMessages must be set 'true' in A3EAI_config.sqf
A3EAIC_deathMessages = true;


/*	A3EAI Text String Settings
--------------------------------------------------------------------------------------------------------------------*/	

//AI kill message
A3EAIC_killMessage0 = "%1 was killed"; //%1: AI corpse name

//AI radio static message
A3EAIC_radioMessage0 = "[RADIO] Your radio is picking up a signal nearby."; //Message displayed when radio sound transmitted without AI dialogue.

//AI radio messages (AI-killer dialogue)
A3EAIC_radioMessage1 = "[RADIO] %1: %2 is in this area. Stay on alert!"; //%1: AI leader name, %2: Target player name
A3EAIC_radioMessage2 = "[RADIO] %1: Target looks like a %2. Find them!"; //%1: AI leader name, %2: Target player type
A3EAIC_radioMessage3 = "[RADIO] %1: Target's range is about %2 meters. Move in on that position!"; //%1: AI leader name, %2: Target player distance
A3EAIC_radioMessage4 = "[RADIO] %1: Lost contact with target. Breaking off pursuit."; //%1: AI leader name
A3EAIC_radioMessage5 = "[RADIO] %1: Target has been eliminated."; //%1: AI leader name

//AI radio messages (Dynamic AI hunter dialogue)
A3EAIC_radioMessage11 = "[RADIO] %1: %2 is somewhere in this location. Search the area!"; //%1: AI leader name, %2: Target player name
A3EAIC_radioMessage12 = "[RADIO] %1: Target is a %2. Stay on alert!"; //%1: AI leader name, %2: Target player type
A3EAIC_radioMessage13 = "[RADIO] %1: Target's distance is %2 meters. Move in to intercept!"; //%1: AI leader name, %2: Target player distance
A3EAIC_radioMessage14 = "[RADIO] %1: We've lost contact with the target. Let's move out."; //%1: AI leader name
A3EAIC_radioMessage15 = "[RADIO] %1: The target has been killed."; //%1: AI leader name

//AI helicopter reinforcement warning message
A3EAIC_radioMessage20 = "Warning: Hostile %1 inbound."; //%1: Helicopter type
