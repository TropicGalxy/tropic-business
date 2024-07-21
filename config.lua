Config = {}

Config.Target = "ox" -- Set to either "qb" or "ox"

Config.RequireBusinessLicense = true -- Set to true if a business license is required

Config.Inventory = "ox" -- Set to "qb" or "ox" based on your preference, only needed if RequireBusinessLicense = true

Config.Notify = "qb" -- currently supports: qb, okok

Config.PayOption = "cash" -- cash or bank

Config.Businesses = {
    {
        EnableBlip = true,
        BusinessName = "Burgershot", 
        BusinessPrice = 75000,
        BusinessJob = "burgershot",
        BusinessGrade = 4,
        PedCoords = vector4(-1187.4, -877.69, 12.83, 34.2), -- Set your ped coordinates here
        PedModel = "u_m_y_burgerdrug_01", -- Set your ped model here, https://docs.fivem.net/docs/game-references/ped-models/
        BlipCoords = vector3(-1189.14, -890.5, 13.89), -- Set your blip coordinates here
        BlipSprite = 106, -- Set your blip sprite here, https://docs.fivem.net/docs/game-references/blips/
        BlipColor = 1, -- Set your blip color here
        BlipName = "Burgershot", -- Set your blip name here
        SellBackPercentage = 75
    },
    {
        EnableBlip = false,
        BusinessName = "My Business 2",
        BusinessPrice = 75000,
        BusinessJob = "businessowner2",
        BusinessGrade = 4,
        PedCoords = vector4(0.0, 0.0, 0.0, 0.0), -- Set your ped coordinates here
        PedModel = "a_f_y_business_02", -- Set your ped model here
        BlipCoords = vector3(0.0, 0.0, 0.0), -- Set your blip coordinates here
        BlipSprite = 475, -- Set your blip sprite here
        BlipColor = 2, -- Set your blip color here
        BlipName = "Business 2", -- Set your blip name here
        SellBackPercentage = 40
    }
    -- Add more businesses as needed
}
