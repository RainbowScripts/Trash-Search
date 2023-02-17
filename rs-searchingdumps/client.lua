local cooldown = false



if Config.Framework == 'esx' then 
    ESX = nil


    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(0)
        end
    end)
elseif Config.Framework == 'qbcore' then
    local QBCore = exports['qb-core']:GetCoreObject()
end


CreateThread(function()

    local dumps = {
        'prop_dumpster_01a',
        'prop_dumpster_02b',
        'prop_dumpster_02a',
        'prop_dumpster_4b',
        'prop_dumpster_4a',
        'prop_bin_01a',
        'prop_bin_06a',
    
    
    
    }


exports[Config.target]:AddTargetModel(dumps, {
	options = {
		{
            action = function()
                searchitems()
            end,
			icon = "fas fa-hand-rock",
			label = "Przeszukaj Śmietnik",
			canInteract = function()
				return not cooldown 
			end,
		},
	},
	distance = 2.0
})

end)





function searchitems()
    cooldown = true
      RequestAnimDict("amb@prop_human_bum_bin@base")
      while not HasAnimDictLoaded("amb@prop_human_bum_bin@base") do
          Citizen.Wait(100)
      end
      RequestAnimDict('anim@move_m@trash')
      while not HasAnimDictLoaded('anim@move_m@trash') do
          Citizen.Wait(100)
      end
      local playerPed = PlayerPedId()
      FreezeEntityPosition(playerPed, true)
      TaskPlayAnim(playerPed, 'amb@prop_human_bum_bin@base', 'base', 1.0, 1.0, -1, 1, 0, 0, 0, 0)
      Wait(5000)
      ClearPedTasks(playerPed)
      Wait(500)
      TaskPlayAnim(playerPed, 'anim@move_m@trash', 'pickup', 1.0, 1.0, -1, 50, 0, 0, 0, 0)
      FreezeEntityPosition(playerPed, false)
      Wait(2000)
      ClearPedTasks(playerPed)
      if Config.Framework == 'esx' then 
      TriggerServerEvent('rs-additem:random')
      elseif Config.Framework == 'qbcore' then 
      TriggerServerEvent('qb-rs-additem:random')
      end
      Wait(Config.Cooldown*60000)
      cooldown = false
      
end


function exchangeitems(id)
    if id == 1 then
    if Config.Framework == 'esx' then 
        TriggerServerEvent('rs-exchange:items', 1)
        elseif Config.Framework == 'qbcore' then 
            TriggerServerEvent('qb-rs:exchangeitems', 1)
    end
  end
  if id == 2 then
    if Config.Framework == 'esx' then 
        TriggerServerEvent('rs-exchange:items', 2)
        elseif Config.Framework == 'qbcore' then 
            TriggerServerEvent('qb-rs:exchangeitems', 2)
    end
  end

  if id == 3 then
    if Config.Framework == 'esx' then 
        TriggerServerEvent('rs-exchange:items', 3)
        elseif Config.Framework == 'qbcore' then 
        TriggerServerEvent('qb-rs:exchangeitems', 3)
    end
  end


end

------------------
-- Ped
------------------
Citizen.CreateThread(function()
    for k,v in pairs(Config.Pedy)do
    RequestModel(GetHashKey(v.Pos.ped))
    while not HasModelLoaded(GetHashKey(v.Pos.ped)) do
      Citizen.Wait(200)
    end
      local tobacofactory =  CreatePed(4, v.Pos.ped, v.Pos.x, v.Pos.y, v.Pos.z-0.1, v.Pos.h, false, true)
      SetEntityHeading(tobacofactory, v.Pos.h)
      FreezeEntityPosition(tobacofactory, true)
      SetEntityInvincible(tobacofactory, true)
      SetBlockingOfNonTemporaryEvents(tobacofactory, true)



exports[Config.target]:AddBoxZone("Ped1", vector3(v.Pos.x, v.Pos.y, v.Pos.z), 0.7, 0.7, {  --Nazwa Locala ALbo Hash Peda
name="Ped1",
heading=v.Pos.h,
--debugPoly=true,
minZ=v.Pos.z-2,
maxZ=v.Pos.z+2    
    }, {
    options = {
        {
            action = function(id)
                exchangeitems(1)
            end,
            icon = "fa-solid fa-handshake", -- ikonka na targecie mozna wziac ja z https://fontawesome.com 
            label = "Wymień Przedmiot Zwykły", -- Nazwa na targecie
            num = 1
        },
        {
            action = function(id)
                exchangeitems(2)
            end,
            icon = "fa-solid fa-handshake", -- ikonka na targecie mozna wziac ja z https://fontawesome.com 
            label = "Wymień Przedmioty Rzadki", -- Nazwa na targecie
            num = 2
        },
        {
            action = function(id)
                exchangeitems(3)
            end,
            icon = "fa-solid fa-handshake", -- ikonka na targecie mozna wziac ja z https://fontawesome.com 
            label = "Wymień Przedmioty Legendarny", -- Nazwa na targecie
            num = 3
        },
    },
    distance = 1.5 -- dystans
    })


end    

end)