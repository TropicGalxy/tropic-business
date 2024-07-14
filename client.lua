local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    print("Config.Target: " .. tostring(Config.Target))  -- Debug: Check if Config.Target is read correctly
    for i, business in ipairs(Config.Businesses) do
        -- Spawn the NPC
        local pedModel = business.PedModel
        RequestModel(pedModel)
        while not HasModelLoaded(pedModel) do
            Citizen.Wait(100)
        end
        local ped = CreatePed(4, pedModel, business.PedCoords.x, business.PedCoords.y, business.PedCoords.z, business.PedCoords.w, false, true)
        SetEntityAsMissionEntity(ped, true, true)
        SetPedFleeAttributes(ped, 0, 0)
        SetBlockingOfNonTemporaryEvents(ped, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)

        -- Add target interaction for ox_target
        if Config.Target == "ox" then
            print("Registering ox_target for business: " .. business.BusinessName)
              exports.ox_target:addLocalEntity(ped, {
        {
            name = 'business:buy',
            event = 'business:buy',
            icon = 'fas fa-shopping-cart',
            label = 'Buy Business',
            args = { index = i },
            distance = 2.5,
            onSelect = function()
                TriggerServerEvent('business:buyBusiness', i)
            end
        },
        {
            event = "business:sell",
            icon = "fas fa-dollar-sign",
            label = "Sell Business",
            args = { index = i },
            distance = 2.5,
            onSelect = function()
                TriggerServerEvent('business:sellBusiness', i)
            end
        }
    })      
         elseif Config.Target == "qb" then
           print("Registering qb-target for business: " .. business.BusinessName)
            exports['qb-target']:AddTargetEntity(ped, {
                options = {
                    {
                        event = "business:buy",
                        icon = "fas fa-shopping-cart",
                        label = "Buy Business",
                        action = function()
                            TriggerServerEvent('business:buyBusiness', i)
                        end
                    },
                    {
                        event = "business:sell",
                        icon = "fas fa-dollar-sign",
                        label = "Sell Business",
                        action = function()
                            TriggerServerEvent('business:sellBusiness', i)
                        end
                    }
                },
                distance = 2.5
            })
        else
            print("Invalid target system specified in config.")
        end

        -- Add blip if enabled
        if business.EnableBlip then
            local blip = AddBlipForCoord(business.BlipCoords.x, business.BlipCoords.y, business.BlipCoords.z)
            SetBlipSprite(blip, business.BlipSprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.75)
            SetBlipColour(blip, business.BlipColor)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(business.BlipName)
            EndTextCommandSetBlipName(blip)
        end
    end
end)

RegisterNetEvent('business:buy', function(data)
    local index = data.index
    local business = Config.Businesses[index]
    local player = PlayerPedId()
    local playerCoords = GetEntityCoords(player)
    local dist = #(playerCoords - business.PedCoords)

    if dist < 2.5 then
        TriggerServerEvent('business:buyBusiness', index)
    end
end)

RegisterNetEvent('business:sell', function(data)
    local index = data.index
    local business = Config.Businesses[index]
    local player = PlayerPedId()
    local playerCoords = GetEntityCoords(player)
    local dist = #(playerCoords - business.PedCoords)

    if dist < 2.5 then
        TriggerServerEvent('business:sellBusiness', index)
    end
end)