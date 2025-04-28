# GlobeClear – World Cleanup System for FiveM

![Stoic-2025-04-28_18-23-20-680fc7987b453](https://github.com/user-attachments/assets/fc0b1d24-bdb0-4cb1-bb5a-f4e2c62e2909)


## Overview 🌍
**GlobeClear** is a lightweight world cleanup system for FiveM servers.  
It allows server administrators to trigger a full server-side cleanup of peds, vehicles, and objects after a countdown, notifying players with a smooth UI experience.  
Optional Discord role-based permissions let you restrict who can execute the cleanup.

## Features ✨
- 30-second pre-cleanup countdown with customizable title & message
- Automatic removal of:
  - Non-player Peds
  - Empty Vehicles
  - World Objects
- Clear "World Cleared!" final message with short countdown
- Optimized entity enumeration to prevent crashes
- Discord ACL: restrict command usage by role ID

## Installation 📦
1. Move the `GlobeClear` resource folder into your server's `resources/` directory.
2. Add `ensure GlobeClear` to your `server.cfg`.  
   *(Alternatively, refresh and then `ensure GlobeClear`, but note: permissions may not work correctly this way.)*

## Configuration ⚙️
Configure behavior inside `config.lua`:

```lua
Config.ClearPeds         = true
Config.ClearVehicles     = true
Config.ClearObjects      = true

Config.Notification = {
  title      = "WorldClear",
  startText  = "Cleanup starting…",
  finishText = "Cleanup complete!"
}

-- Discord ACL settings
Config.DiscordToken         = "YOUR_BOT_TOKEN_HERE"       -- Bot token (prefixed with "Bot ")
Config.DiscordGuildId       = "YOUR_GUILD_ID_HERE"         -- Discord server (guild) ID
Config.AllowedDiscordRoleId = "123456789012345678"         -- Role ID allowed to run /worldclear
