Config = {}

Config.MarkerVisible = true
Config.BlipVisible = true

Config.Marker = 36
Config.MarkerDistance = 5.0
Config.MarkerColor = { r = 0, g = 255, b = 0}
Config.MarkerScale = {x = 1.0 , y = 1.0, z =1.0}

Config.Blip_Sprite = 280
Config.Blip_Display = 4
Config.Blip_Scale = 0.7
Config.Blip_Color = 2
Config.Blip_Name = "Car Rental"

Config.ListVeh = {
    Panto = {
        name = "Car Panto",
        model = "panto",
        prix = 30,
    },
    Scooter = {
        name = "Scooter Faggio",
        model = "faggio",
        prix = 500,
    },
}

Config.PosList = {
    zone = {
        {
            pos = vector3(-990.70, -2709.35, 13.83),  -- Airport
            out = {
                {pos = vector3(-988.81, -2705.39, 13.83), heading = 333.68},
            },
        },
        {
            pos = vector3(-1273.25, -1371.07, 4.30), -- Plage
            out = {
                {pos = vector3(-1270.75, -1366.83, 4.30), heading = 292.70},
            },
        },
    },
}

