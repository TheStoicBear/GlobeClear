-- client.lua
-- Handles the 30s countdown UI, then clears entities, then 3s “cleared!” UI.

-- Entity enumerators:
local function EnumerateEntities(init, move, dispose)
    return coroutine.wrap(function()
        local handle, ent = init()
        if not handle or handle == -1 then dispose(handle); return end
        local ok = true
        while ok and ent do
            coroutine.yield(ent)
            ok, ent = move(handle)
        end
        dispose(handle)
    end)
end

local function EnumeratePeds()    return EnumerateEntities(FindFirstPed,    FindNextPed,    EndFindPed)    end
local function EnumerateVehicles()return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle) end
local function EnumerateObjects() return EnumerateEntities(FindFirstObject,  FindNextObject,  EndFindObject)  end

-- Main handler from server.lua
RegisterNetEvent('worldclear:clientClear', function()
    -- 1) Kick off the 30s “get ready” countdown UI
    SendNUIMessage({
      action  = 'startCountdown',
      title   = Config.Notification.title,
      message = 'World will be cleared in:'
    })

    -- 2) Wait full 30 seconds
    Citizen.Wait(30000)

    -- 3) Perform the actual clear
    if Config.ClearPeds then
      for ped in EnumeratePeds() do
        if DoesEntityExist(ped) and not IsPedAPlayer(ped) then
          DeleteEntity(ped)
        end
      end
    end

    if Config.ClearVehicles then
      for veh in EnumerateVehicles() do
        if DoesEntityExist(veh) then
          local drv = GetPedInVehicleSeat(veh, -1)
          if not IsPedAPlayer(drv) then
            SetEntityAsMissionEntity(veh, false, false)
            DeleteEntity(veh)
          end
        end
      end
    end

    if Config.ClearObjects then
      for obj in EnumerateObjects() do
        if DoesEntityExist(obj) then
          DeleteEntity(obj)
        end
      end
    end

    -- 4) Show final “World has been cleared” + 3,2,1 UI
    SendNUIMessage({
      action  = 'clearDone',
      title   = Config.Notification.title,
      message = 'World has been cleared'
    })
end)
