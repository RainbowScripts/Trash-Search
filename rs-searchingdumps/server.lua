if Config.Framework == 'esx' then 
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
RegisterNetEvent('rs-additem:random', function()
    for k,v in pairs(Config.Items)do
    local xPlayer = ESX.GetPlayerFromId(source)
    local _source = source
    local randonitem = math.random(1, 100)
    local rarerandomitem = math.random(1, 100)
    local legendaryrandomitem = math.random(1, 100)
    if randonitem <= v.CommonItem.Chance then 
        print(randonitem.. 'common') 
        xPlayer.addInventoryItem(v.CommonItem.name, v.CommonItem.count)  
    end
   
    if legendaryrandomitem == v.Legendaryitem.Chance then 
        print(legendaryrandomitem.. 'legendary') 
        xPlayer.addInventoryItem(v.Legendaryitem.name, v.Legendaryitem.count)
    end

    if rarerandomitem >= v.RareItem.Chance then 
        print(rarerandomitem.. 'rare') 
        xPlayer.addInventoryItem(v.RareItem.name, v.Legendaryitem.count)
    end
   end
end)

   RegisterNetEvent('rs-exchange:items', function(id)
    for k,v in pairs(Config.Items)do
    local xPlayer = ESX.GetPlayerFromId(source)
    local _source = source

    if id == 1 then 
        local requestitem1 = xPlayer.getInventoryItem(v.CommonItem.name)
     if requestitem1.count >= v.CommonItem.exchangeacount then 
        print('udane')
        xPlayer.removeInventoryItem(v.CommonItem.name, v.CommonItem.count)
        xPlayer.addInventoryItem(v.CommonReward.name, v.CommonReward.count)
     else
     TriggerClientEvent('esx:showNotification', _source, 'Nie Posiadasz Wystarczającej ilości Przedmiotu')

     end
    end

    if id == 2 then 
        local requestitem2 = xPlayer.getInventoryItem(v.RareItem.name)
        if requestitem2.count >= v.RareItem.exchangeacount then 
           xPlayer.removeInventoryItem(v.RareItem.name, v.RareItem.count)
           xPlayer.addInventoryItem(v.RareReward.name, v.RareReward.count)
        else
           TriggerClientEvent('esx:showNotification', _source, 'Nie Posiadasz Wystarczającej ilości Przedmiotu')
        end
    end

    if id == 3 then 
        local requestitem3 = xPlayer.getInventoryItem(v.Legendaryitem.name)
        if requestitem3.count >= v.Legendaryitem.exchangeacount then 
           xPlayer.removeInventoryItem(v.Legendaryitem.name, v.Legendaryitem.count)
           xPlayer.addInventoryItem(v.LegendaryReward.name, v.LegendaryReward.count)
        else
           TriggerClientEvent('esx:showNotification', _source, 'Nie Posiadasz Wystarczającej ilości Przedmiotu')
        end
    end
end

end)

elseif Config.Framework == 'qbcore' then 
    local QBCore = exports['qb-core']:GetCoreObject()
    RegisterNetEvent('qb-rs-additem:random', function()
        for k,v in pairs(Config.Items) do
            local src = source
            local Player = QBCore.Functions.GetPlayer(src)
        local randonitem = math.random(1, 100)
        local rarerandomitem = math.random(1, 100)
        local legendaryrandomitem = math.random(1, 100)
        if randonitem <= v.CommonItem.Chance then 
            print(randonitem.. 'common') 
            Player.Functions.AddItem(v.CommonItem.name, v.CommonItem.count)  
        end
       
        if legendaryrandomitem == v.Legendaryitem.Chance then 
            print(legendaryrandomitem.. 'legendary') 
            Player.Functions.AddItem(v.Legendaryitem.name, v.Legendaryitem.count)
        end
    
        if rarerandomitem >= v.RareItem.Chance then 
            print(rarerandomitem.. 'rare') 
            Player.Functions.AddItem(v.RareItem.name, v.Legendaryitem.count)
        end
       end
    end)
    RegisterServerEvent('qb-rs:exchangeitems')
    AddEventHandler('qb-rs:exchangeitems', function(id)
  
    for k,v in pairs(Config.Items) do
            local src = source
            local Player = QBCore.Functions.GetPlayer(src)
        if id == 1 then 
                local item = v.CommonItem.name
                local checkCommonItem = Player.Functions.GetItemByName(item)
                if checkCommonItem ~= nil then 
                 if checkCommonItem.amount >= 1 then
                Player.Functions.RemoveItem(v.CommonItem.name, v.CommonItem.exchangeacount)
                Player.Functions.AddItem(v.CommonReward.name, v.CommonReward.count)
                TriggerClientEvent('QBCore:Notify', src, "Otrzymano Nowe Przedmioty.", 'success')
                else 
                    TriggerClientEvent('QBCore:Notify', src, "Nie Posiadasz odpowiednich Przedmiotów.", 'error')
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "Nie Posiadasz odpowiednich Przedmiotów.", 'error')
            end        
        elseif id == 2 then
                local item = v.RareItem.name
                local checkRareItem = Player.Functions.GetItemByName(item)
            if checkRareItem ~= nil then  
                if checkRareItem.amount >= v.RareItem.exchangeacount then 
                Player.Functions.RemoveItem(v.RareItem.name, v.RareItem.exchangeacount)
                Player.Functions.AddItem(v.RareReward.name, v.RareReward.count)
                TriggerClientEvent('QBCore:Notify', src, "Otrzymano Nowe Przedmioty.", 'success')
                else 
                    TriggerClientEvent('QBCore:Notify', src, "Nie Posiadasz odpowiednich Przedmiotów.", 'error')
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "Nie Posiadasz odpowiednich Przedmiotów.", 'error')
            end
        elseif id == 3 then 
                local item = v.Legendaryitem.name
                local checkLegendaryitem = Player.Functions.GetItemByName(item)
            if checkLegendaryitem ~= nil then  
                if checkLegendaryitem.amount >= v.Legendaryitem.exchangeacount then 
                Player.Functions.RemoveItem(v.Legendaryitem.name, v.Legendaryitem.exchangeacount)
                Player.Functions.AddItem(v.LegendaryReward.name, v.LegendaryReward.count)
                TriggerClientEvent('QBCore:Notify', src, "Otrzymano Nowe Przedmioty.", 'success')
                else 
                    TriggerClientEvent('QBCore:Notify', src, "Nie Posiadasz odpowiednich Przedmiotów.", 'error')
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "Nie Posiadasz odpowiednich Przedmiotów.", 'error')
            end
        end
    end
    end)



end