local error = "~r~Error~w~: "

Locales['en'] = {
  -- Prompts
  ['prompt_lockerroom'] = "~INPUT_CONTEXT~ Open Locker Room",
  ['prompt_rental'] = "~INPUT_CONTEXT~ Choose Rental Truck",
  ['prompt_return'] = "~INPUT_CONTEXT~ Return Rental Truck",
  -- UI Components
  ['ui_lockerroom'] = "Locker Room",
  ['ui_rental'] = "Available Trucks",
  -- Features
  ['blip_name'] = "Truck Rental",
  -- Lockerroom
  ['lockerroom_uniform'] = "Trucker Uniform",
  ['lockerroom_regular'] = "Regular Clothes",
  -- Vehicles
  ['hauler'] = "Hauler",
  ['phantom'] = "Phantom",
  ['phantom3'] = "Phantom Custom",
  ['packer'] = "Packer",
  -- Messages
  ['deposit_return'] = "You were refunded ~g~${AMOUNT} ~w~from your ~g~${DEPOSIT} ~y~deposit~w~.",
  ['deposit_taken'] = "You paid a ~y~deposit ~w~of ~g~${DEPOSIT}~w~. You will get it back upon returning the rental.",
  ['damaged_veh'] = "~r~You damaged the rental truck!",
  -- Errors
  ['error_veh'] = error .. "The vehicle you tried to rent does not exist. (PLEASE REPORT THIS)",
  ['error_money'] = error .. "You can not afford the ~y~deposit ~w~of",
  ['error_location'] = error .. "The location the server tried to spawn a vehicle at doesn't exist. (PLEASE REPORT THIS)",
  ['error_locindex'] = error .. "The location index the server tried to spawn a vehicle at doesn't exist. (PLEASE REPORT THIS)",
  ['error_deposit'] = error .. "You did not have a ~y~deposit ~w~down. (PLEASE REPORT THIS)",
  ['error_invalid_deposit'] = error .. "The ~y~deposit ~w~was invalid. (PLEASE REPORT THIS)",

  -- Contract Related Messages
  ['contract_start'] = "You are starting your contract with ~y~_company_~w~.",
  ['travel_to'] = "Drive to ~y~_location_ ~w~in ~y~_area_~w~.",
  ['travel_to_contract'] = "Drive to ~y~_location_ ~w~in ~y~_area_~w~. Paid Distance: ~y~_distance_~w~ miles.",
  ['pick_up'] = "Go to ~y~_location_ ~w~and pick up the trailer.",
  ['drop_off'] = "Go to ~y~_location_ ~w~and drop off the trailer.",
  ['drop_off_confirm'] = "~INPUT_CONTEXT~ Drop Off Trailer",
  
  ['pick_up_loc'] = "Pickup Location",
  ['drop_off_loc'] = "Dropoff Location",

  ['error_company_dne'] = error .. "The company you tried to work for does not exist.",
  ['error_start_dne'] = error .. "The location you tried to start at for your contract does not exist.",
  ['error_end_dne'] = error .. "The location you tried to end at for your contract does not exist.",

  ['error_invalid_state'] = error .. "Your contract is in an invalid state. Clearing it now."
}