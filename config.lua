Config              = {}
Config.Locale        = 'en'

--[[
  24%-27% for employees, 83%-87% for owner-operators
  percentage is out of total job pay
]]

--[[
  Amount (out of 1000.0) of damage that can be caused to the truck
  body before deductions apply to the deposit
]]
Config.DamageThreshold = 6.0

--[[
  Multiplier to apply to the percentage of damage past the damage threshold
]]
Config.DeductionMultiplier = 2.0

--[[
  List of Trucks that can be used with the script
  model    = the in-game model for the vehicle
  deposit  = the price to rent this truck from the logistics company
          : if price is set to -1, the truck can be used but not rented
            (use case: players can purchase their own trucks to use on jobs)
]]
Config.Trucks = {
  {model = "hauler", deposit = 500},
  {model = "phantom", deposit = 1000},
  {model = "phantom3", deposit = 5000},
  {model = "packer", deposit = -1}
}

--[[
  locker = location to get in and out of uniform
  computer = location for player to go to spawn a truck
  spawns = vector4 (x, y, z, w) is used to include headings, where w is heading
  despawn = location to provide the truck return marker
]]
Config.TruckRentalLocations = {
  {
    blip = vector3(156.1242, -3200.096, 6.021922),
    locker = vector3(145.8869, -3218.66, 4.9),
    computer = vector3(152.9294, -3211.702, 4.95),
    spawns = {
      vector4(146.4333, -3204.093, 5.925346, 269.9644),
      vector4(125.6823, -3212.811, 5.975893, 359.4013),
      vector4(126.1741, -3196.659, 5.979477, 270.1207),
      vector4(137.2964, -3187.17, 5.92463, 180.5098)
    },
    despawn = vector3(162.4647, -3196.618, 5.0)
  }
}

--[[
  Properties to apply to the Truck Rental blip
  short = true if blip should only be rendered on radar when you are nearby

  Alternate sprites and colors can be found at https://docs.fivem.net/docs/game-references/blips/
]]
Config.BlipProperties = {
  name		= _U("blip_name"),
  sprite	= 477,
  color		= 5,
  short		= true
}

--[[
  Properties to apply to the markers
  distance = distance to start drawing marker from

  Alternate marker types can be found at https://docs.fivem.net/docs/game-references/markers/
]]
Config.LockerMarkerProperties = {
  type			= 25,
  distance	= 50,
  color			= {red = 255, green = 255, blue = 0, alpha = 150},
  scale			= vector3(1.5, 1.5, 1.5)
}

Config.SpawnMarkerProperties = {
  type			= 25,
  distance	= 10,
  color			= {red = 0, green = 255, blue = 0, alpha = 150},
  scale			= vector3(1.5, 1.5, 1.5)
}

Config.ReturnMarkerProperties = {
  type			= 1,
  distance	= 10,
  color			= {red = 255, green = 0, blue = 0, alpha = 150},
  scale			= vector3(3.5, 3.5, 1.5)
}

Config.ContractCompanies = {
  {
    name = "Post OP",
    pay = 50, -- per mile
    locations = {
      {
        name = "Post OP Warehouse",
        area = "Port of Los Santos",
        spots = {
          {
            name = "Bay 11",
            spawn = vector4(-446.0666, -2790.1118, 6.4200, 46.8816),
            back = vector3(-441.7129, -2794.1892, 6.1178),
            front = vector3(-449.5576, -2786.8423, 6.3264),
            model = "trailers2",
            livery = 1
          },
          {
            name = "Bay 12",
            spawn = vector4(-455.0634, -2799.4194, 6.4200, 45.3021),
            back = vector3(-450.8139, -2803.6252, 6.0854),
            front = vector3(-458.4544, -2796.0642, 6.2125),
            model = "trailers2",
            livery = 1
          },
          {
            name = "Bay 13",
            spawn = vector4(-464.1743, -2808.0352, 6.4200, 46.2233),
            back = vector3(-459.8551, -2812.1685, 6.081),
            front = vector3(-467.6163, -2804.7314, 6.2119),
            model = "trailers2",
            livery = 1
          },
          {
            name = "Bay 15",
            spawn = vector4(-481.8604, -2826.0928, 6.4200, 45.6194),
            back = vector3(-477.701, -2830.2051, 6.0881),
            front = vector3(-485.3572, -2822.6599, 6.2129),
            model = "trailers2",
            livery = 1
          },
          {
            name = "Bay 17",
            spawn = vector4(-499.8685, -2843.9341, 6.4200, 45.6311),
            back = vector3(-495.5972, -2848.1184, 6.087),
            front = vector3(-503.281, -2840.6013, 6.2119),
            model = "trailers2",
            livery = 1
          },
          {
            name = "Bay 18",
            spawn = vector4(-509.0766, -2853.0903, 6.4200, 45.7418),
            back = vector3(-504.8009, -2857.2502, 6.1227),
            front = vector3(-512.4982, -2849.7488, 6.3286),
            model = "trailers2",
            livery = 1
          }
        }
      },
      {
        name = "Blaine County Depot",
        area = "Paleto Bay",
        spots = {
          {
            name = "The Loading Bay",
            spawn = vector4(-435.7895, 6140.9414, 33.382, 215.3127),
            back = vector3(-439.2447, 6145.8198, 31.5584),
            front = vector3(-433.0316, 6137.0483, 31.6905),
            model = "trailers2",
            livery = 1
          }
        }
      }
    }
  },
  {
    name = "Jetsam",
    pay = 50,
    locations = {
      {
        name = "Jetsam Shipyard",
        area = "Port of Los Santos",
        spots = {
          {
            name = "Section E5",
            spawn = vector4(1055.5402832031, -3048.0419921875, 6.0404100418091, 269.61163330078),
            back = vector3(1049.5405273438, -3048.0014648438, 5.9936437606812),
            front = vector3(1060.2900390625, -3048.07421875, 6.0774335861206),
            model = "trailers4",
            livery = 1
          },
          {
            name = "Spot J8",
            spawn = vector4(1017.6062011719, -3129.1879882813, 6.0546822547913, 0.80831301212311),
            back = vector3(1017.6915283203, -3135.1870117188, 5.9811477661133),
            front = vector3(1017.5386962891, -3124.4389648438, 6.1128969192505),
            model = "trailers2",
            livery = 1
          },
          {
            name = "Spot K14",
            spawn = vector4(945.69622802734, -3154.8347167969, 6.0572395324707, 180.52844238281),
            back = vector3(945.64086914063, -3148.8352050781, 5.9865441322327),
            front = vector3(945.74011230469, -3159.583984375, 6.1132068634033),
            model = "trailers2",
            livery = 1
          },
          {
            name = "Spot O9",
            spawn = vector4(925.17767333984, -3209.3815917969, 6.0581679344177, 180.99816894531),
            back = vector3(925.07257080078, -3203.3830566406, 5.9886293411255),
            front = vector3(925.26092529297, -3214.1306152344, 6.1132197380066),
            model = "trailers4",
            livery = 1
          },
          {
            name = "Bay 5",
            spawn = vector4(1201.3822021484, -3184.5986328125, 5.9890332221985, 179.58030700684),
            back = vector3(1201.4266357422, -3178.6071777344, 5.6708927154541),
            front = vector3(1201.3470458984, -3189.341796875, 6.2408938407898),
            model = "trailers2",
            livery = 1
          },
          {
            name = "Bay 2",
            spawn = vector4(1178.3049316406, -3142.208984375, 5.83664894104, 89.965362548828),
            back = vector3(1184.2982177734, -3142.2126464844, 5.5524740219116),
            front = vector3(1173.5603027344, -3142.2060546875, 6.0616207122803),
            model = "trailers2",
            livery = 1
          },
          {
            name = "Bay 3",
            spawn = vector4(1178.3049316406, -3142.208984375, 5.83664894104, 89.965362548828),
            back = vector3(1184.2982177734, -3142.2126464844, 5.5524740219116),
            front = vector3(1173.5603027344, -3142.2060546875, 6.0616207122803),
            model = "trailers2",
            livery = 1
          },
          {
            name = "A Parking Space",
            spawn = vector4(866.06231689453, -2990.6457519531, 6.0554637908936, 270.43569946289),
            back = vector3(860.06292724609, -2990.69140625, 5.9836311340332),
            front = vector3(870.81182861328, -2990.6096191406, 6.1123313903809),
            model = "trailers2",
            livery = 1
          }
        }
      },
      {
        name = "Jetsam Warehouse",
        area = "LSIA",
        spots = {
          {
            name = "Bay 1",
            spawn = vector4(-767.66925048828, -2607.8098144531, 13.999462127686, 240.39855957031),
            back = vector3(-772.88586425781, -2604.8461914063, 13.94711971283),
            front = vector3(-763.53936767578, -2610.15625, 14.040900230408),
            model = "trailers2",
            livery = 1
          },
          {
            name = "Bay 2",
            spawn = vector4(-765.43133544922, -2603.4677734375, 14.000980377197, 240.52447509766),
            back = vector3(-770.65447998047, -2600.5153808594, 13.951086044312),
            front = vector3(-761.29632568359, -2605.8049316406, 14.040479660034),
            model = "trailers2",
            livery = 1
          },
          {
            name = "Bay 3",
            spawn = vector4(-762.99163818359, -2599.0505371094, 14.001836776733, 242.43124389648),
            back = vector3(-768.31024169922, -2596.2739257813, 13.952548980713),
            front = vector3(-758.78100585938, -2601.2487792969, 14.040855407715),
            model = "trailers2",
            livery = 1
          },
          {
            name = "Bay 4",
            spawn = vector4(-760.00927734375, -2595.1555175781, 14.000918388367, 237.83978271484),
            back = vector3(-765.08837890625, -2591.9616699219, 13.94989490509),
            front = vector3(-755.98828125, -2597.6838378906, 14.041311264038),
            model = "trailers2",
            livery = 1
          },
          {
            name = "Bay 5",
            spawn = vector4(-757.68121337891, -2590.2722167969, 14.005218505859, 240.43786621094),
            back = vector3(-762.89996337891, -2587.3120117188, 13.959509849548),
            front = vector3(-753.54974365234, -2592.6157226563, 14.041404724121),
            model = "trailers2",
            livery = 1
          },
          {
            name = "Bay 6",
            spawn = vector4(-755.03924560547, -2585.7524414063, 14.010103225708, 241.52438354492),
            back = vector3(-760.31323242188, -2582.8916015625, 13.968686103821),
            front = vector3(-750.86401367188, -2588.0170898438, 14.04289150238),
            model = "trailers2",
            livery = 1
          },
          {
            name = "Bay 7",
            spawn = vector4(-752.96765136719, -2581.6298828125, 14.011939048767, 239.37646484375),
            back = vector3(-758.13073730469, -2578.5734863281, 13.975427627563),
            front = vector3(-748.88024902344, -2584.0495605469, 14.040843963623),
            model = "trailers2",
            livery = 1
          },
          {
            name = "Bay 8",
            spawn = vector4(-749.99542236328, -2576.6728515625, 14.013181686401, 240.94491577148),
            back = vector3(-755.24029541016, -2573.7590332031, 13.978757858276),
            front = vector3(-745.84326171875, -2578.9797363281, 14.040433883667),
            model = "trailers2",
            livery = 1
          },
          {
            name = "Bay 9",
            spawn = vector4(-747.19091796875, -2572.2763671875, 14.01210308075, 239.7272644043),
            back = vector3(-752.37261962891, -2569.2517089844, 13.976373672485),
            front = vector3(-743.08874511719, -2574.6708984375, 14.040389060974),
            model = "trailers2",
            livery = 1
          },
          {
            name = "Bay 10",
            spawn = vector4(-744.99713134766, -2568.2485351563, 14.017521858215, 239.25984191895),
            back = vector3(-750.15405273438, -2565.181640625, 13.987983703613),
            front = vector3(-740.91455078125, -2570.6762695313, 14.040905952454),
            model = "trailers2",
            livery = 1
          }
        }
      },
      {
        name = "Jetsam Office",
        area = "Paleto Bay",
        spots = {
          {
            name = "The Loading Bay",
            spawn = vector4(-274.93566894531, 6171.9086914063, 31.621936798096, 302.72680664063),
            back = vector3(-279.98318481445, 6168.6650390625, 31.591682434082),
            front = vector3(-270.93975830078, 6174.4770507813, 31.645887374878),
            model = "trailers2",
            livery = 1
          }
        }
      }
    }
  },
  {
    name = "Pißwasser",
    pay = 50,
    locations = {
      {
        name = "Pißwasser Factory",
        area = "Cypress Flats",
        spots = {
          {
            name = "Bay 5",
            spawn = vector4(838.03784179688, -1933.1962890625, 29.125179290771, 176.47756958008),
            back = vector3(838.40704345703, -1927.2080078125, 29.056232452393),
            front = vector3(837.74554443359, -1937.9370117188, 29.179761886597),
            model = "trailers2",
            livery = 2
          },
          {
            name = "A Bay",
            spawn = vector4(836.46276855469, -1986.7723388672, 29.457187652588, 333.13687133789),
            back = vector3(833.75115966797, -1992.1242675781, 29.387031555176),
            front = vector3(838.609375, -1982.5355224609, 29.512729644775),
            model = "trailers2",
            livery = 2
          },
          {
            name = "A Bay",
            spawn = vector4(845.30786132813, -1987.6466064453, 29.455238342285, 10.866944313049),
            back = vector3(846.43896484375, -1993.5385742188, 29.382513046265),
            front = vector3(844.41241455078, -1982.9821777344, 29.512811660767),
            model = "trailers2",
            livery = 2
          }
        }
      },
      {
        name = "Vanilla Unicorn",
        area = "Strawberry",
        spots = {
          {
            name = "The Back Door",
            spawn = vector4(93.722068786621, -1278.4387207031, 29.264141082764, 98.764312744141),
            back = vector3(99.651420593262, -1277.5261230469, 29.164192199707),
            front = vector3(89.027992248535, -1279.1611328125, 29.343267440796)
          },
          {
            name = "The Front Door",
            spawn = vector4(122.84719085693, -1309.2622070313, 29.369066238403, 299.63653564453),
            back = vector3(117.63236999512, -1312.2287597656, 29.29677772522),
            front = vector3(126.97559356689, -1306.9136962891, 29.426296234131)
          }
        }
      },
      {
        name = "Tequi-La-La",
        area = "West Vinewood",
        spots = {
          {
            name = "The Back Loading Bay",
            spawn = vector4(-558.93524169922, 302.4326171875, 83.34952545166, 269.62072753906),
            back = vector3(-564.93414306641, 302.47229003906, 83.243194580078),
            front = vector3(-554.18609619141, 302.40118408203, 83.433708190918),
            model = "trailers2",
            livery = 1
          }
        }
      },
      {
        name = "Rob's Liqour",
        area = "Vespucci Canals",
        spots = {
          {
            name = "The Curb",
            spawn = vector4(-1237.5692138672, -901.31982421875, 12.036988258362, 305.67501831055),
            back = vector3(-1242.4388427734, -904.81420898438, 11.761910438538),
            front = vector3(-1233.7141113281, -898.55340576172, 12.254757881165)
          }
        }
      },
      {
        name = "24/7 Rest Stop",
        area = "Palamino Freeway",
        spots = {
          {
            name = "A Parking Spot",
            spawn = vector4(2554.0827636719, 415.12893676758, 108.60945129395, 313.74826049805),
            back = vector3(2549.7487792969, 410.98016357422, 108.53658294678),
            front = vector3(2557.513671875, 418.4133605957, 108.667137146),
            model = "trailers2",
            livery = 2
          }
        }
      },
      {
        name = "Yellow Jack Inn",
        area = "Sandy Shores",
        spots = {
          {
            name = "The Back Lot",
            spawn = vector4(1982.6605224609, 3034.8120117188, 47.210670471191, 55.653686523438),
            back = vector3(1987.6138916016, 3031.4270019531, 47.135890960693),
            front = vector3(1978.7391357422, 3037.4919433594, 47.269870758057),
            model = "trailers2",
            livery = 2
          }
        }
      },
      {
        name = "Liquor Ace",
        area = "Sandy Shores",
        spots = {
          {
            name = "Loading Bay",
            spawn = vector4(1413.5491943359, 3614.3952636719, 35.096912384033, 206.05581665039),
            back = vector3(1410.9140625, 3619.7844238281, 34.978897094727),
            front = vector3(1415.6353759766, 3610.12890625, 35.190341949463),
            model = "trailers2",
            livery = 2
          },
          {
            name = "Loading Bay",
            spawn = vector4(1381.1854248047, 3600.4431152344, 35.037300109863, 196.57650756836),
            back = vector3(1379.4741210938, 3606.1931152344, 34.955959320068),
            front = vector3(1382.5402832031, 3595.8908691406, 35.101696014404),
            model = "trailers2",
            livery = 2
          }
        }
      },
      {
        name = "Liquor Store",
        area = "Sandy Shores",
        spots = {
          {
            name = "The Parking Lot",
            spawn = vector4(1959.0676269531, 3844.9326171875, 32.152008056641, 210.16307067871),
            back = vector3(1956.0534667969, 3850.1201171875, 32.078887939453),
            front = vector3(1961.4537353516, 3840.8259277344, 32.209892272949),
            model = "trailers2",
            livery = 2
          }
        }
      }
    }
  }
}