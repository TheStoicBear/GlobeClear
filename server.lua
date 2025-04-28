-- Grabs the player’s Discord identifier (discord:USERID)
local function getDiscordId(src)
  for i = 0, GetNumPlayerIdentifiers(src) - 1 do
      local id = GetPlayerIdentifier(src, i)
      if id:sub(1,8) == "discord:" then
          return id:sub(9) -- strip off "discord:"
      end
  end
  return nil
end

RegisterCommand('worldclear', function(src, args, raw)
  -- always allow the console
  if src == 0 then
      print('^2[WorldClear]^7 Triggered by console, clearing world for all clients…')
      return TriggerClientEvent('worldclear:clientClear', -1)
  end

  -- find their Discord user ID
  local discordId = getDiscordId(src)
  if not discordId then
      print('^1[WorldClear]^7 Could not find your Discord identifier; make sure you have Discord linked.')
      return
  end

  -- query Discord API for guild member
  local url = string.format(
    'https://discord.com/api/v10/guilds/%s/members/%s',
    Config.DiscordGuildId,
    discordId
  )

  PerformHttpRequest(url, function(status, body, headers)
      if status == 200 then
          local member = json.decode(body)
          for _, roleId in ipairs(member.roles) do
              if roleId == Config.AllowedDiscordRoleId then
                  print('^2[WorldClear]^7 Permission granted, clearing world…')
                  return TriggerClientEvent('worldclear:clientClear', -1)
              end
          end
          print('^1[WorldClear]^7 You do not have the required role to run this command.')
      elseif status == 404 then
          print('^1[WorldClear]^7 You are not a member of that Discord server.')
      else
          print(('^1[WorldClear]^7 Discord API error (HTTP %d)'):format(status))
      end
  end, 'GET', '', {
      ['Authorization'] = 'Bot ' .. Config.DiscordToken,
      ['Content-Type']  = 'application/json'
  })
end, false)
