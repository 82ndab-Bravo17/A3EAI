A3EAI - Current Version: 1.0.0
=====

---
Introduction
---
A3EAI is an AI spawning manger addon designed for ArmA 3 Epoch Mod (http://epochmod.com). It was developed from a heavily modified version of DZAI (AI addon for DayZ Mod). The DZAI project began in late 2012 and has undergone continuous development since then. Today, this project focuses specifically on the ArmA 3 Epoch Mod under the codename 'A3EAI'.


---
Installing A3EAI
---
IMPORTANT: As of A3EAI 1.0.0, the installation steps have changed. If you already have A3EAI installed (before version 0.2.0), you must remove all A3EAI files from @EpochHive.

To install A3XAI:

1. Copy @A3XAI into your server's Arma 3 directory.
2. Modify your server's startup parameters to include @A3XAI. For example: -serverMod=@ExileServer;@A3XAI;

To configure A3XAI:

1. Unpack A3XAI_config.A3EAI (Recommended to use A3EAI Manager: http://www.armaholic.com/page.php?id=16369)
2. Edit config.cpp with a text editor (Recommended to use Notepad++: https://notepad-plus-plus.org/). Make your configuration changes.
3. Repack A3XAI_config.A3EAI

---
A3EAI Wiki
---
A3EAI now has its own Wiki site! A3EAI guides and tutorials can be found here: http://a3eai.wikia.com/wiki/A3EAI_Wiki

---
A3EAI Features
---
1. Automatically-generated static AI spawns: A3EAI will spawn an AI group at various named locations on the map if players are nearby.
2. Dynamic AI spawns: A3EAI will create ambient threat in the area for each player by periodically spawning AI to create unexpected ambush encounters. These AI may occasionally seek out and hunt a player.
3. Random AI spawns: A3EAI will create spawns that are randomly placed around the map and are periodically relocated. These spawns are preferentially created in named locations, but may be also created anywhere in the world.
4. Air and land vehicle AI: AI patrol in vehicles around the map, looking for players to hunt down. Cars and trucks may roam the road, and helicopters (or jets) search the skies for players. Helicopters with available cargo space may also occasionally deploy an AI group by parachute.
5. Custom AI spawns: Users may also define custom infantry and vehicle AI spawns at specified locations.
6. Adaptive classname system: A3EAI reads Epoch's loot tables to find items that AI can use, such as weapons and equipment. Users may also choose to manually specify classnames to use instead.
7. Error-checking ability: A3EAI checks config files for errors upon startup. If errors are found, A3EAI will use backup settings and continue operating as normal.
8. Classname verification: A3EAI filters out invalid or banned classnames and prevents them from being used by AI.
9. Universal map support: A3EAI supports any and every map for Arma 3 without changing any settings.
10. Plug-and-play installation: Installing and upgrading A3EAI is a simple copy and paste job and does not require modifying any Epoch files.
11. Easy configuration: A single configuration file contains all settings for A3EAI. This config file is external to the A3EAI A3EAI, so configuration changes can be made without ever having to unpack or repack the A3EAI file. 

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.