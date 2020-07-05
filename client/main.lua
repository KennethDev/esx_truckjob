--[[ ESX Data and Functions ]]--

ESX              	= nil
local PlayerData  = nil


local isTrucker = false
local isWorking = false
local blips     = {}

local deposit = -1

local jobTruck  = nil
local contract  = nil

local availableTrucks = {}

local mt = "default"
local ma = "bottom-right"

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
  PlayerData = playerData
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  if (PlayerData == nil) then
    PlayerData = ESX.GetPlayerData()
  end
  PlayerData.job = job
end)

RegisterNetEvent('esx_truckjob:Notification')
AddEventHandler('esx_truckjob:Notification', function(text)
  ESX.ShowNotification(text)
end)

RegisterNetEvent('esx_truckjob:SpawnTruck')
AddEventHandler('esx_truckjob:SpawnTruck', function(model, location, locationIndex, depositA)
  if Config.TruckRentalLocations[location] == nil then
    ESX.ShowNotification(_("error_location"))
    return
  end
  if Config.TruckRentalLocations[location].spawns[locationIndex] == nil then
    ESX.ShowNotification(_("error_locindex"))
    return
  end
  deposit = depositA
  local pos = Config.TruckRentalLocations[location].spawns[locationIndex]
  
  jobTruck = SpawnVehicle(model, pos)
  SetVehicleNumberPlateText(jobTruck, "WRK " .. math.random(0,9) .. math.random(0,9) .. math.random(0,9) .. math.random(0,9))
end)

RegisterNetEvent("esx_truckjob:ReturnAccepted")
AddEventHandler("esx_truckjob:ReturnAccepted", function()
  local ped = PlayerPedId()
  if IsPedInVehicle(ped, jobTruck, false) then
    TaskLeaveVehicle(ped, jobTruck, 0)
    Citizen.Wait(2750) -- just enough time to get out of the truck :D
  end
  DeleteVehicle(jobTruck)
  jobTruck = nil
  EndContract()
end)

Citizen.CreateThread(function()
  while ESX == nil do Citizen.Wait(0) end
  while PlayerData == nil do
    PlayerData = ESX.GetPlayerData()
    Citizen.Wait(0)
  end
  for i = 1, #Config.Trucks, 1 do
    if Config.Trucks[i].deposit ~= -1 then
      table.insert(availableTrucks, {label = _(Config.Trucks[i].model) .. " - $" .. Config.Trucks[i].deposit, value = Config.Trucks[i].model})
    end
  end
  while true do
    if not (PlayerData.job == nil or PlayerData.job.name == nil) then
      if PlayerData.job.name == "trucker" and not isTrucker then
        DoHireFunctions()
        isTrucker = true
      end
      if PlayerData.job.name ~= "trucker" and isTrucker then
        DoQuitFunctions()
        isTrucker = false
      end
    end
    Citizen.Wait(100)
  end
end)

--[[ Job Functions ]]--

Citizen.CreateThread(function()
  while true do
    if not isTrucker then
      Citizen.Wait(500)
    else
      local ped			= PlayerPedId()
      local pos			= GetEntityCoords(ped)
      local onFoot	= IsPedOnFoot(ped)
      for i = 1, #Config.TruckRentalLocations, 1 do
        HandleLockerMarker(i, pos, ped, onFoot)
        HandleTruckSpawnMarker(i, pos, ped, onFoot)
        HandleTruckReturnMarker(i, pos, ped, onFoot)
      end
      if jobTruck ~= nil then
        HandleJobTick()
      end
      --DoDebugFunctions() -- debug
      Citizen.Wait(0)
    end
  end
end)

function HandleJobTick()
  local ped = PlayerPedId()
  local veh = GetVehiclePedIsIn(ped, true)
  if veh ~= jobTruck or veh == 0 then return end
  local pos = GetEntityCoords(veh)
  if IsControlJustReleased(0, 51) and contract == nil then
    StartContract(math.random(1, #Config.ContractCompanies), 1)
    return
  end
  if contract ~= nil then
    if contract.startLoc ~= nil then
      local tpos = contract.spot.spawn
      local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, tpos.x, tpos.y, tpos.z, true)

      if dist < 100 then
        ESX.ShowHelpNotification(_R(_("pick_up"), {"_location_"}, {contract.spot.name}))
        if contract.trailer == nil then
          local spot = contract.spot
          ClearAreaOfVehicles(spot.spawn.x, spot.spawn.y, spot.spawn.z, 15, false, false, false, false, false)
          contract.trailer = SpawnVehicle(contract.spot.model, contract.spot.spawn)
          SetVehicleLivery(contract.trailer, contract.spot.livery)
          SetVehicleNumberPlateText(contract.trailer, "WRK TRAIL")
        else
          local unused, trailer = GetVehicleTrailerVehicle(veh)
          if trailer == contract.trailer then
            contract.startLoc = nil
            local spot = contract.endLoc.spots[math.random(1, #contract.endLoc.spots)]
            contract.spot = spot
            SetBlipRoute(contract.blip, false)
            RemoveBlip(contract.blip)
            contract.blip = CreateRoute(_("drop_off_loc"), contract.spot.spawn)
            contract.dist = GetGpsBlipRouteLength() / 1609
            ESX.ShowNotification(_R(_("travel_to_contract"), {"_location_", "_area_", "_distance_"}, {contract.endLoc.name, contract.endLoc.area, contract.dist}))
          end
        end
      end
    elseif contract.startLoc == nil and contract.endLoc ~= nil then
      local tpos = contract.spot.spawn
      local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, tpos.x, tpos.y, tpos.z, true)
      if dist < 100 then
        local spot = contract.spot

        local front = GetOffsetFromEntityInWorldCoords(contract.trailer, 0.0, 4.75, -1.75)
        local back = GetOffsetFromEntityInWorldCoords(contract.trailer, 0.0, -6.0, -1.75)

        local frontDist = GetDistanceBetweenCoords(front.x, front.y, front.z, spot.front.x, spot.front.y, spot.front.z)
        local backDist = GetDistanceBetweenCoords(back.x, back.y, back.z, spot.back.x, spot.back.y, spot.back.z)
        
        local colorRed = {red = 255, green = 0, blue = 0, alpha = 100}
        local colorGreen = {red = 0, green = 255, blue = 0, alpha = 100}
        local scale = vector3(6.0, 6.0, 1.0)

        local color = colorRed
        if frontDist < 6 then
          color = colorGreen
        end
        DisplayMarker(1, contract.spot.front, color, scale, false)

        color = colorRed
        if backDist < 6 then
          color = colorGreen
        end
        DisplayMarker(1, contract.spot.back, color, scale, false)

        if frontDist < 6 and backDist < 6 then
          DisableControlAction(0, 51)
          ESX.ShowHelpNotification(_("drop_off_confirm"))
          if IsDisabledControlJustReleased(0, 51) then
            ESX.ShowNotification("You drove a " .. contract.dist .. " mile job!")
            DeleteVehicle(contract.trailer)
            RemoveBlip(contract.blip)
            contract = nil
          end
        else
          ESX.ShowHelpNotification(_R(_("drop_off"), {"_location_"}, {contract.spot.name}))
        end
      end
    else
      -- Should never get here
      ESX.ShowNotification(_("error_invalid_state"))
      ClearContract()
    end
  end
end

function StartContract(companyId, startLocationId)
  local company = Config.ContractCompanies[companyId]
  if company == nil then
    ESX.ShowNotification(_("error_company_dne"))
    return
  end

  local startLocation = company.locations[startLocationId]
  if startLocation == nil then
    ESX.ShowNotification(_("error_start_dne"))
    return
  end

  local endLocationId = -1
  while endLocationId == -1 do
    endLocationId = math.random(1, #company.locations)
    if endLocationId == startLocationId then endLocationId = -1 end
  end

  local endLocation = company.locations[endLocationId]
  if endLocation == nil then
    ESX.ShowNotification(_("error_end_dne"))
    return
  end

  local spot = startLocation.spots[math.random(1, #startLocation.spots)]

  contract = {
    company = company,
    startLoc = startLocation,
    endLoc = endLocation,
    spot = spot,
    dist = nil,
    blip = CreateRoute(_("pick_up_loc"), spot.spawn),
    trailer = nil
  }
  ESX.ShowNotification(_R(_("contract_start"), {"_company_"}, {contract.company.name}))
  ESX.ShowNotification(_R(_("travel_to"), {"_location_", "_area_"}, {contract.startLoc.name, contract.startLoc.area}))
end

function EndContract()
  ClearContract()
end

function ClearContract()
  if contract ~= nil then RemoveBlip(contract.blip) end
  contract = nil
end

function DoDebugFunctions()
  if not IsPedInAnyVehicle(PlayerPedId(), false) then return end
  local b, jobTrailer = GetVehicleTrailerVehicle(GetVehiclePedIsIn(PlayerPedId()))
  if jobTrailer ~= 0 then
    local ped = PlayerPedId()

    -- Marker
    local type = 0
    local scale = vector3(1.0, 1.0, 1.0)
    local face = false
    -- /Marker

    -- Colors
    local red = {red = 255, green = 0, blue = 0, alpha = 255}
    local green = {red = 0, green = 255, blue = 0, alpha = 255}
    local blue = {red = 0, green = 0, blue = 255, alpha = 255}
    -- /Colors

    local front = GetOffsetFromEntityInWorldCoords(jobTrailer, 0.0, 4.75, -1.75)
    local center = GetOffsetFromEntityInWorldCoords(jobTrailer, 0.0, 0.0, -1.75)
    local centerN = GetOffsetFromEntityInWorldCoords(jobTrailer, 0.0, 0.0, 0.0)
    local centerH = GetEntityHeading(jobTrailer)
    local back = GetOffsetFromEntityInWorldCoords(jobTrailer, 0.0, -6.0, -1.75)
    DisplayMarker(type, front, green, scale, face)
    DrawText("vector3(" .. round(front.x, 4) ..", " .. round(front.y, 4) .. ", " .. round(front.z, 4) ..")", 325, 650, green)
    DisplayMarker(type, center, red, scale, face)
    DrawText("vector4(" .. round(centerN.x, 4) ..", " .. round(centerN.y, 4) .. ", " .. round(centerN.z, 4) ..", " .. round(centerH, 4) .. ")", 325, 670, red)
    DisplayMarker(type, back, blue, scale, face)
    DrawText("vector3(" .. round(back.x, 4) ..", " .. round(back.y, 4) .. ", " .. round(back.z, 4) ..")", 325, 690, blue)

    DisableControlAction(0, 81)
    DisableControlAction(0, 82)
    if IsDisabledControlJustReleased(0, 81) then
      local spot = {
        name = "spotname",
        spawn = vector4(center.x, center.y, center.z, centerH),
        back = vector3(back.x, back.y, back.z),
        front = vector3(front.x, front.y, front.z),
        model = "trailers2",
        livery = 1
      }
      TriggerServerEvent("esx_truckjob:SpotPrint", spot)
    end
    if IsDisabledControlJustPressed(0, 82) then
      DeleteVehicle(jobTrailer)
    end

    for i = 1, #Config.ContractCompanies, 1 do
      local company = Config.ContractCompanies[i]
      for j = 1, #company.locations, 1 do
        local location = company.locations[j]
        for k = 1, #location.spots do
          local pos1 = location.spots[k].spawn
          local pos2 = center
          local dist = GetDistanceBetweenCoords(pos1.x, pos1.y, pos1.z, pos2.x, pos2.y, pos2.z)
          if dist < 50 then
            ESX.Game.Utils.DrawText3D(pos1, location.spots[k].name)
            DisplayMarker(20, pos1, blue, vector3(1.0, 1.0, 1.0), true)
          end
        end
      end
    end
  end
end

function DoHireFunctions()
  for i = 1, #Config.TruckRentalLocations, 1 do
    local bp = Config.BlipProperties
    local blip = Config.TruckRentalLocations[i].blip
    table.insert(blips, CreateBlip(bp.name, bp.sprite, bp.color, blip, bp.short))
  end
  jobTruck = nil
  ClearContract()
end

function DoQuitFunctions()
  for i = 1, #blips, 1 do
    RemoveBlip(blips[i])
  end
  blips = {}
  jobTruck = nil
  ClearContract()
end

function HandleLockerMarker(i, pos, ped, onFoot)
  if jobTruck ~= nil then return end
  local loc = Config.TruckRentalLocations[i].locker
  local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, loc.x, loc.y, loc.z, true)
  if dist <= Config.LockerMarkerProperties.distance and onFoot then
    DisplayMarker(Config.LockerMarkerProperties.type, loc, Config.LockerMarkerProperties.color, Config.LockerMarkerProperties.scale, false)
    if dist <= Config.LockerMarkerProperties.scale.x then
      if not ESX.UI.Menu.IsOpen(mt, GetCurrentResourceName(), "lockerroom") then
        ESX.ShowHelpNotification(_("prompt_lockerroom"))
        if IsControlJustReleased(0, 51) then
          ESX.UI.Menu.Open(mt, GetCurrentResourceName(), "lockerroom", {
            title = _("ui_lockerroom"),
            align = ma,
            elements = {
              {label = _("lockerroom_uniform"), value = "uniform"},
              {label = _("lockerroom_regular"), value = "regular"}
            }
          },
          function(data, menu)
            if data.current.value == "uniform" then
              isWorking = true
              ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                if skin.sex == 0 then
                  TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
                else
                  TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
                end
              end)
            elseif data.current.value == "regular" then
              isWorking = false
              ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
              end)
            end
            menu.close()
          end,
          function(data, menu)
            menu.close()
          end)
        end
      end
    elseif ESX.UI.Menu.IsOpen(mt, GetCurrentResourceName(), "lockerroom") then
      ESX.UI.Menu.Close(mt, GetCurrentResourceName(), "lockerroom")
    end
  end
end

function HandleTruckSpawnMarker(i, pos, ped, onFoot)
  if jobTruck ~= nil or not isWorking then return end
  local loc = Config.TruckRentalLocations[i].computer
  local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, loc.x, loc.y, loc.z, true)
  if dist <= Config.SpawnMarkerProperties.distance and onFoot then
    DisplayMarker(Config.SpawnMarkerProperties.type, loc, Config.SpawnMarkerProperties.color, Config.SpawnMarkerProperties.scale, false)
    if dist <= Config.SpawnMarkerProperties.scale.x then
      if not ESX.UI.Menu.IsOpen(mt, GetCurrentResourceName(), "rental") then
        ESX.ShowHelpNotification(_("prompt_rental"))
        if IsControlJustReleased(0, 51) then
          ESX.UI.Menu.Open(mt, GetCurrentResourceName(), "rental", {
            title = _("ui_rental"),
            align = ma,
            elements = availableTrucks
          },
          function(data, menu)
            TriggerServerEvent("esx_truckjob:RequestVehicle", i, data.current.value)
            menu.close()
          end,
          function(data, menu)
            menu.close()
          end)
        end
      end
    elseif ESX.UI.Menu.IsOpen(mt, GetCurrentResourceName(), "rental") then
      ESX.UI.Menu.Close(mt, GetCurrentResourceName(), "rental")
    end
  end
end

function HandleTruckReturnMarker(i, pos, ped, onFoot)
  if jobTruck == nil or not isWorking or contract ~= nil then return end
  local loc = Config.TruckRentalLocations[i].despawn
  local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, loc.x, loc.y, loc.z, true)
  if dist <= Config.ReturnMarkerProperties.distance and not onFoot and IsPedInVehicle(ped, jobTruck, false) then
    DisplayMarker(Config.ReturnMarkerProperties.type, loc, Config.ReturnMarkerProperties.color, Config.ReturnMarkerProperties.scale, false)
    if dist <= Config.ReturnMarkerProperties.scale.x then
      ESX.ShowHelpNotification(_("prompt_return"))
      if IsControlJustReleased(0, 51) then
        local veh = jobTruck
        local ped = PlayerPedId()
        if (GetVehiclePedIsIn(ped, false) ~=  veh) then return end
        local health = GetVehicleBodyHealth(veh)
        local damagePercentage = ((1000 - health)/(1000 - Config.DamageThreshold)) * 100
        local returnAmount = deposit
        if 1000 - health > Config.DamageThreshold then
          ESX.ShowNotification(_("damaged_veh"))
          local depositDeduction = (Config.DeductionMultiplier * damagePercentage) / 100
          returnAmount = round(deposit - (deposit * depositDeduction), 0)
          if returnAmount < 0 then returnAmount = 0 end
        end
        TriggerServerEvent("esx_truckjob:ReturnVehicle", returnAmount)
      end
    end
  end
end

function RemoveContractBlip()
  if contract == nil or contract.blip == nil then return end
  RemoveBlip(contract.blip)
  contract.blip = nil
end

--[[ Helper Functions ]]--
function CreateBlip(name, sprite, color, position, short)
  local blip = AddBlipForCoord(position.x, position.y, position.z)
  SetBlipSprite(blip, sprite)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName(name)
  EndTextCommandSetBlipName(blip)
  SetBlipColour(blip, color)
  SetBlipAsShortRange(blip, short)
  return blip
end

function CreateRoute(name, position)
  local blip = CreateBlip(name, 1, 5, position, false)
  SetBlipRouteColour(blip, 5)
  SetBlipRoute(blip, true)
  return blip
end

function DisplayMarker(type, pos, color, scale, face)
  DrawMarker(type, pos.x, pos.y, pos.z, 0, 0, 0, 0, 0, 0, scale.x, scale.y, scale.z, color.red, color.green, color.blue, color.alpha, false, face, 2, nil, nil, nil, false)
end

function DrawText(text, x, y, color)
  local resX, resY = GetScreenResolution()

  SetTextFont(0)
  SetTextScale(0.4, 0.4)
  SetTextProportional(true)
  SetTextColour(color.red, color.green, color.blue, color.alpha)
  SetTextCentre(false)
  SetTextDropShadow(2, 0, 0, 0, 150)
  BeginTextCommandDisplayText("STRING")
  AddTextComponentSubstringPlayerName(text)
  EndTextCommandDisplayText((x / 1.5) / resX, (y - 6.0 / 1.5) / resY)
end

function SpawnVehicle(model, position)
  RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(500)
	end

  local veh = CreateVehicle(model, position.x, position.y, position.z, position.w, true, false)

  SetModelAsNoLongerNeeded(model)
  
  return veh
end

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function _R(text, keys, values)
  if #keys ~= #values then
    return text
  end
  for i = 1, #keys, 1 do
    text = string.gsub(text, keys[i], values[i])
  end
  return text
end