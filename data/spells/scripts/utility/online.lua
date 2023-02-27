local maxPlayersPerMessage = 10

function onCastSpell(creature, variant, isHotkey)
	local hasAccess = checkAccessRights(creature, ACCOUNT_TYPE_GAMEMASTER)
	local players = Game.getPlayers()
	local onlineList = {}
	-- local canUse = creature:getLevel() >= 10 or hasAccess

	-- if not canUse then
	-- 	creature:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Only players above level 10 can use this feature")
	-- end

	for _, targetPlayer in ipairs(players) do
		if hasAccess or not targetPlayer:isInGhostMode() then
			table.insert(onlineList, ("%s [%d]"):format(targetPlayer:getName(), targetPlayer:getLevel()))
		end
	end

	local playersOnline = #onlineList
	doPlayerSendTextMessage(creature,MESSAGE_STATUS_CONSOLE_BLUE,("%d players online."):format(#players))

	for i = 1, playersOnline, maxPlayersPerMessage do
		local j = math.min(i + maxPlayersPerMessage - 1, playersOnline)
		local msg = table.concat(onlineList, ", ", i, j) .. "."
		doPlayerSendTextMessage(creature,MESSAGE_STATUS_CONSOLE_BLUE,msg)
	end
	return true
end