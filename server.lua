local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('business:buyBusiness', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local business = Config.Businesses[index]
    local money = Player.PlayerData.money['cash']

    if money >= business.BusinessPrice then
        Player.Functions.RemoveMoney('cash', business.BusinessPrice)
        Player.Functions.SetJob(business.BusinessJob, business.BusinessGrade)
        TriggerClientEvent('QBCore:Notify', src, "You have purchased the business and are now a " .. business.BusinessJob, 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough money to purchase this business", 'error')
    end
end)

RegisterNetEvent('business:sellBusiness', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local business = Config.Businesses[index]
    local job = Player.PlayerData.job.name

    if job == business.BusinessJob then
        local refund = business.BusinessPrice * (business.SellBackPercentage / 100)
        Player.Functions.AddMoney('cash', refund)
        Player.Functions.SetJob('unemployed', 0)
        TriggerClientEvent('QBCore:Notify', src, "You have sold the business and received $" .. refund, 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, "You do not own this business", 'error')
    end
end)
