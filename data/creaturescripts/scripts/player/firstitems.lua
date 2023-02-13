-- auto loaded items from gameconfig file
function onLogin(player)
	if player:getLastLoginSaved() == 0 then
				for i = 1, #GameConfig.StartItems.items do
			player:addItem(GameConfig.StartItems.items[i][1], GameConfig.StartItems.items[i][2])
		end
	
		local backpack = player:getVocation():getId() == 0 and player:addItem(1987) or player:addItem(1988)
		if not backpack then
			return true
		end
	
		for i = 1, #GameConfig.StartItems.container do
			backpack:addItem(GameConfig.StartItems.container[i][1], GameConfig.StartItems.container[i][2])
		end
	end
	return true
end
