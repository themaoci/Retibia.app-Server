local specialQuests = {
}

local questsExperience = {
	[7105] = 100,
}

local questLog = {
}

local tutorialIds = {
}
local canPickupLater = {
	[7104] = 86400, -- allowed for second pickup after 24h
	[7101] = 86400, -- allowed for second pickup after 24h
	[7102] = 86400, -- allowed for second pickup after 24h
	[7103] = 86400, -- allowed for second pickup after 24h
	[7106] = 86400,
	[7107] = 86400,
	[7119] = 86400,
}
-- list of items that will be spawned in containers with UID and item/quest name
-- 7101 - Stealth Ring (Mino Tower Desert)
-- 7102 - Protection Amulet
-- 7103 - Piece of broken amulet (bring 5 pieces to get special amulet?)
-- 7104 - Life Ring (Dragon Corpse)
-- 7105 - leather pants
-- 7106 - arrow x40, poisin arrow x40
-- 7107 - letter + salomon x4 + salomon x4 + salomon x4
-- 7108 - ambers notebook
-- 7109 - Goblin Temple left chest
-- 7110 - Goblin Temple right chest
-- 7111 - Bear Room Brass Helmet
-- 7112 - Bear Room Chain Armor
-- 7113 - Bear Room Bag (arrow + gold)
-- 7114 - Bag with Present
-- 7115 - Rapier
-- 7117 - Katana
-- 7118 - Viking Helmet
-- 7119 - Starting items - Torch x2
-- 7120 - Carlin Sword
-- 7121 - Spike Sword
-- 7122 - Fishing Rod
-- 7123 - Dragon Corpse - Legion Helmet + Brass shield
-- 7124 - Combat Knife
-- 7125 - Reward after mino mage room
-- 7126 - Brown mushrooms x5
-- 7127 - Scroll (12572)
-- 7128 - salomon x2
-- 9127 - Damaged Steel Helmet
-- 12511 - Stolen Golden Goblet


function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local storage = specialQuests[item.actionid]
	if not storage then
		storage = item.uid
		if storage > 65535 then
			return false
		end
	end
	local storageValue = player:getStorageValue(storage)
	if storageValue == 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'The ' .. ItemType(item.itemid):getName() .. ' is empty.')
		return true
	else if storageValue > 1 and storageValue > os.time() then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'The ' .. ItemType(item.itemid):getName() .. ' is still empty.')
		return true
	end

	local items, reward = {}
	local size = item:isContainer() and item:getSize() or 0
	if size == 0 then
		reward = item:clone()
	else
		local container = Container(item.uid)
		for i = 0, container:getSize() - 1 do
			items[#items + 1] = container:getItem(i):clone()
		end
	end

	size = #items
	if size == 1 then
		reward = items[1]:clone()
	end

	local result = ''
	if reward then
		local ret = ItemType(reward.itemid)
		if ret:isRune() then
			result = ret:getArticle() .. ' ' ..  ret:getName() .. ' (' .. reward.type .. ' charges)'
		elseif ret:isStackable() and reward:getCount() > 1 then
			result = reward:getCount() .. ' ' .. ret:getPluralName()
		elseif ret:getArticle() ~= '' then
			result = ret:getArticle() .. ' ' .. ret:getName()
		else
			result = ret:getName()
		end
	else
		if size > 20 then
			reward = Game.createItem(item.itemid, 1)
		elseif size > 8 then
			reward = Game.createItem(1988, 1)
		else
			reward = Game.createItem(1987, 1)
		end

		for i = 1, size do
			local tmp = items[i]
			if reward:addItemEx(tmp) ~= RETURNVALUE_NOERROR then
				print('[Warning] QuestSystem:', 'Could not add quest reward to container')
			end
		end
		local ret = ItemType(reward.itemid)
		result = ret:getArticle() .. ' ' .. ret:getName()
	end

	if player:addItemEx(reward) ~= RETURNVALUE_NOERROR then
		local weight = reward:getWeight()
		if player:getFreeCapacity() < weight then
			player:sendCancelMessage(string.format('You have found %s weighing %.2f oz. You have no capacity.', result, (weight / 100)))
		else
			player:sendCancelMessage('You have found ' .. result .. ', but you have no room to take it.')
		end
		return true
	end

	if questsExperience[storage] then
		player:addExperience(questsExperience[storage], true)
	end

	if questLog[storage] then
		player:setStorageValue(questLog[storage], 1)
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have found ' .. result .. '.')
	
	if canPickupLater[storage] then
		player:setStorageValue(storage, os.time() + canPickupLater[storage])
		return true
	end

	player:setStorageValue(storage, 1)
	return true
end
end