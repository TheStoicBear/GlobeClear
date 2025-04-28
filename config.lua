-- config.lua
Config = {}

-- what to clear
Config.ClearPeds     = true
Config.ClearVehicles = true
Config.ClearObjects  = true

-- NUI notifications
Config.Notification = {
  title      = "WorldClear",
  startText  = "Cleanup starting…",
  finishText = "Cleanup complete!",
}

-- ── Discord ACL ─────────────────────────────────────────────────────────────
-- Your Discord bot token (starts with "Bot ")
Config.DiscordToken      = "YOUR_BOT_TOKEN_HERE"
-- The guild (server) your users must be in
Config.DiscordGuildId    = "YOUR_GUILD_ID_HERE"
-- The only role ID that’s allowed to run /worldclear
Config.AllowedDiscordRoleId = "123456789012345678"
