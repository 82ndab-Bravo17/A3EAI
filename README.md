A3EAI - Current Version: 0.8.1
=====

---
Introduction
---
A3EAI is an AI spawning manger addon designed for ArmA 3 Epoch Mod (http://epochmod.com). It was developed from a heavily modified version of DZAI (AI addon for DayZ Mod). The DZAI project began in late 2012 and has undergone continuous development since then. Today, this project focuses specifically on the ArmA 3 Epoch Mod under the codename 'A3EAI'.

if you would like to support development of A3EAI, you can contribute to A3EAI with a donation by clicking on the Donate Icon below. Thank you for your support!

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=9PESMPV4SQFDJ)

---
Installing A3EAI
---
1. Download the latest A3EAI release from the A3EAI Releases page: https://github.com/dayzai/A3EAI/releases
2. Locate the .zip file you downloaded and extract it to a folder.
3. Open the extracted folder and open the Installation Package folder. Copy the contents of this folder (Addons, A3EAI_config.sqf, A3EAI_custom_defs.sqf)
4. Navigate to your server's Arma 3 folder and open the @EpochHive folder.
5. Paste the contents copied from Step 3 into this directory. When prompted to merge the "Addons" folder, click Yes. Note: No Epoch files are being replaced or modified. This step merges the two Addon folders. 
6. (Optional) Configure A3EAI settings by editing A3EAI_config.sqf. 

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
4. Air and land vehicle AI: AI patrol in vehicles around the map, looking for players to hunt down. Cars and trucks may roam the road, and helicopters (or jets) search the skies for players. Helicopters with available cargo space may also occasionally deploy an AI group by parachute. Dynamic AI may also sometimes summon an air vehicle to their location for support.
5. Custom AI spawns: Users may also define custom infantry and vehicle AI spawns at specified locations.
6. Adaptive classname system: A3EAI reads Epoch's loot tables to find items that AI can use, such as weapons and equipment. Users may also choose to manually specify classnames to use instead.
7. Error-checking ability: A3EAI checks config files for errors upon startup. If errors are found, A3EAI will use backup settings and continue operating as normal.
8. Classname verification: A3EAI filters out invalid or banned classnames and prevents them from being used by AI.
9. Universal map support: A3EAI supports any and every map for Arma 3 without changing any settings.
10. Plug-and-play installation: Installing and upgrading A3EAI is a simple copy and paste job and does not require modifying any Epoch files.
11. Easy configuration: A single configuration file contains all settings for A3EAI. This config file is external to the A3EAI pbo, so configuration changes can be made without ever having to unpack or repack the pbo file. 


<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.