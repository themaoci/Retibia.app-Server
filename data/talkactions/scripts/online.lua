local maxPlayersPerMessage = 10

function onSay(player, words, param)
	local hasAccess = checkAccessRights(player, ACCOUNT_TYPE_GAMEMASTER)
	local players = Game.getPlayers()
	local onlineList = {}
	local canUse = player:getLevel() >= 10 or hasAccess

	if not canUse then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Only players above level 10 can use this feature")
	end

	for _, targetPlayer in ipairs(players) do
		if hasAccess or not targetPlayer:isInGhostMode() then
			table.insert(onlineList, ("%s [%d]"):format(targetPlayer:getName(), targetPlayer:getLevel()))
		end
	end

	local playersOnline = #onlineList
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, ("%d players online."):format(#players))

	for i = 1, playersOnline, maxPlayersPerMessage do
		local j = math.min(i + maxPlayersPerMessage - 1, playersOnline)
		local msg = table.concat(onlineList, ", ", i, j) .. "."
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, msg)
	end
	return false
end
