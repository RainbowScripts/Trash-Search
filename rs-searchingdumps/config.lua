Config = {}

Config.Framework = 'esx'  -- Accessible Frameworks: esx , qbcore
Config.Cooldown = 1 -- in minutes
Config.target = 'qtarget' -- Accessible Targets: bt-target, qtarget, ox_target, qb-target
Config.Pedy = {
	Ped1 = {
		Pos   = {x = -50.3359, y = -1059.6750, z = 26.8887, h = 75.9820, ped = "s_m_y_airworker" }, -- here enter coord ped, hashped and nameped    
	},
}
Config.Items = {
     Items = {
		Legendaryitem = {Chance = 1, name = 'item-name', count = 1, exchangeacount = 1}, -- This item has a 1% to draw this item 
		LegendaryReward = {name = 'item-name', count = 1}, -- This is item if you exchange to ped 

		RareItem = {Chance = 74, name = 'item-name', count = 1, exchangeacount = 1}, -- This item has a 25% to draw this item
		RareReward = {name = 'item-name', count = 1}, -- This is item if you exchange to ped 

		CommonItem = {Chance = 24, name = 'item-name', count = 1, exchangeacount = 1}, -- This item has a 74% to draw this item
		CommonReward = {name = 'item-name', count = 1}, -- This is item if you exchange to ped 
	}
}





