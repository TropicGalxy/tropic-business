local QBCore = exports['qb-core']:GetCoreObject()
local businesses = {}

-- Load business ownership data from a file on server start
local function loadBusinesses()
    local file = LoadResourceFile(GetCurrentResourceName(), 'businesses.json')
    if file then
        businesses = json.decode(file) or {}
    else
        businesses = {} -- Initialize as empty if the file doesn't exist
    end
end

-- Save business ownership data to a file
local function saveBusinesses()
    local jsonData = json.encode(businesses)
    SaveResourceFile(GetCurrentResourceName(), 'businesses.json', jsonData, -1)
end

-- Initialize the businesses JSON based on the Config
local function initializeBusinesses()
    for index, business in ipairs(Config.Businesses) do
        if not businesses[index] then
            businesses[index] = { owner = nil, job = nil } -- Start as null for each business
        end
    end
    saveBusinesses() -- Save the initialized structure
end

-- Load businesses when the server starts
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        loadBusinesses()
        initializeBusinesses() -- Ensure all businesses are initialized
    end
end)

RegisterNetEvent('business:buyBusiness', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local business = Config.Businesses[index]
    local money = Player.PlayerData.money['cash']

    -- Check if business license is required
    if Config.RequireBusinessLicense then
        local hasLicense = false

        if Config.Inventory == "qb" then
            -- Check for business license in qb-inventory
            hasLicense = Player.Functions.HasItem('business_license', 1)
        elseif Config.Inventory == "ox" then
            -- Check for business license in ox-inventory
            hasLicense = Player.Functions.GetItemByName('business_license') and Player.Functions.GetItemByName('business_license').amount > 0
        end

        if not hasLicense then
            if Config.Notify == "qb" then
                TriggerClientEvent('QBCore:Notify', src, "You need a business license to purchase this", 'error')
            elseif Config.Notify == "okok" then
                TriggerClientEvent('okokNotify:Alert', src, 'Error', 'You need a business license to purchase this', 1000, 'error', false)
            else
                print("There is no valid notify script enabled")
            end
            return
        end
    end

    -- Existing purchase logic
    if businesses[index] and businesses[index].owner == Player.PlayerData.citizenid then
        if Config.Notify == "qb" then
            TriggerClientEvent('QBCore:Notify', src, "You already own this business", 'error')
        elseif Config.Notify == "okok" then
            TriggerClientEvent('okokNotify:Alert', src, 'Error', 'You already own this business', 1000, 'error', false)
        else
            print("There is no valid notify script enabled")
        end
        return
    end

    if money >= business.BusinessPrice then
        Player.Functions.RemoveMoney('cash', business.BusinessPrice)
        Player.Functions.SetJob(business.BusinessJob, business.BusinessGrade)

        -- Set ownership in the businesses table
        businesses[index] = {
            owner = Player.PlayerData.citizenid,
            job = business.BusinessJob
        }

        saveBusinesses() -- Save ownership data
        if Config.Notify == "qb" then
            TriggerClientEvent('QBCore:Notify', src, "You have purchased the business and are now the owner of " .. business.BusinessJob, 'success')
        elseif Config.Notify == "okok" then
            TriggerClientEvent('okokNotify:Alert', src, 'Success', "You have purchased the business and are now the owner of " .. business.BusinessJob, 1000, 'success', false)
        else
            print("There is no valid notify script enabled")
        end
    else
        if Config.Notify == "qb" then
            TriggerClientEvent('QBCore:Notify', src, "You don't have enough money", 'error')
        elseif Config.Notify == "okok" then
            TriggerClientEvent('okokNotify:Alert', src, 'Error', "You don't have enough money", 1000, 'error', false)
        else
            print("There is no valid notify script enabled")
        end
    end
end)

RegisterNetEvent('business:sellBusiness', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local business = Config.Businesses[index]
    local job = Player.PlayerData.job.name

    -- Check if the player owns the business
    if businesses[index] and businesses[index].owner == Player.PlayerData.citizenid then
        local refund = business.BusinessPrice * (business.SellBackPercentage / 100)
        Player.Functions.AddMoney('cash', refund)
        Player.Functions.SetJob('unemployed', 0)

        -- Remove ownership
        businesses[index] = { owner = nil, job = nil } -- Reset to null
        saveBusinesses() -- Save updated ownership data
        if Config.Notify == "qb" then
            TriggerClientEvent('QBCore:Notify', src, "You have sold the business and received $" .. refund, 'success')
        elseif Config.Notify == "okok" then
            TriggerClientEvent('okokNotify:Alert', src, 'Success', "You have sold the business and received $" .. refund, 1000, 'success', false)
        else
            print("There is no valid notify script enabled")
        end
    else
        if Config.Notify == "qb" then
            TriggerClientEvent('QBCore:Notify', src, "You don't own this business", 'error')
        elseif Config.Notify == "okok" then
            TriggerClientEvent('okokNotify:Alert', src, 'Error', "You don't own this business", 1000, 'error', false)
        else
            print("There is no valid notify script enabled")
        end
    end
end)

RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    -- Give ownership back to players if they own a business
    for index, data in pairs(businesses) do
        if data.owner == Player.PlayerData.citizenid then
            Player.Functions.SetJob(data.job, Config.Businesses[index].BusinessGrade)
        end
    end
end)
