ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



local lastSpawns = {}
local deposits = {}

RegisterNetEvent("esx_truckjob:RequestVehicle")
AddEventHandler("esx_truckjob:RequestVehicle", function(location, model)
  local deposit = -1
  for i,v in pairs(Config.Trucks) do
    if (v.model == model) then
      deposit = v.deposit
    end
  end
  if (deposit < 0) then
    TriggerClientEvent("esx_truckjob:Notification", source, _("error_veh"))
    return
  end
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  if (xPlayer.getMoney() < deposit) then
    TriggerClientEvent("esx_truckjob:Notification", source, _("error_money") .. " ~g~$" .. deposit)
    return
  end

  if lastSpawns[location] == nil or lastSpawns[location] == #Config.TruckRentalLocations[location].spawns then
    lastSpawns[location] = 1
  else
    lastSpawns[location] = lastSpawns[location] + 1
  end
  deposits[source] = deposit
  xPlayer.removeMoney(deposit)
  TriggerClientEvent("esx_truckjob:Notification", source, string.gsub(_("deposit_taken"), "{DEPOSIT}", deposits[source]))
  TriggerClientEvent("esx_truckjob:SpawnTruck", source, model, location, lastSpawns[location], deposit)
end)

RegisterNetEvent("esx_truckjob:ReturnVehicle")
AddEventHandler("esx_truckjob:ReturnVehicle", function(returnAmount)
  if deposits[source] == nil then
    TriggerClientEvent("esx_truckjob:Notification", source, _("error_deposit"))
    return
  end
  if returnAmount > deposits[source] then
    TriggerClientEvent("esx_truckjob:Notification", source, _("error_invalid_deposit"))
    return
  end
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  xPlayer.addMoney(returnAmount)
  TriggerClientEvent("esx_truckjob:Notification", source, string.gsub(string.gsub(_("deposit_return"), "{DEPOSIT}", deposits[source]), "{AMOUNT}", returnAmount))
  TriggerClientEvent("esx_truckjob:ReturnAccepted", source)
end)

RegisterNetEvent("esx_truckjob:SpotPrint")
AddEventHandler("esx_truckjob:SpotPrint", function(spot)
  print("{")
  print("  name = \"" .. spot.name .. "\",")
  print("  spawn = " .. _4(spot.spawn) ..",")
  print("  back = " .. _3(spot.back) ..",")
  print("  front = " .. _3(spot.front) ..",")
  print("  model = \"trailers2\",")
  print("  livery = 1")
  print("}")
  TriggerClientEvent("esx_truckjob:Notification", source, "Printed Spot")
end)

function _3(v)
  return "vector3(" .. v.x .. ", " .. v.y .. ", " .. v.z .. ")"
end

function _4(v)
  return "vector4(" .. v.x .. ", " .. v.y .. ", " .. v.z .. ", " .. v.w .. ")"
end