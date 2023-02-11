function onSay(player, words, param)
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Server Info:"
		.. "\nMax server players limit: " .. configManager.getNumber(configKeys.MAX_PLAYERS)
		.. "\nYour current Exp ratio: " .. Game.getExperienceStage(player:getLevel())
		.. "\nSkill ratio: " .. configManager.getNumber(configKeys.RATE_SKILL)
		.. "\nMagic ratio: " .. configManager.getNumber(configKeys.RATE_MAGIC)
		.. "\nLoot ratio: " .. configManager.getNumber(configKeys.RATE_LOOT)
		.. "\nKills for Red skull: " .. configManager.getNumber(configKeys.KILLS_TO_RED)
		.. "\nKills for Black skull: " .. configManager.getNumber(configKeys.KILLS_TO_BLACK)
		.. "\nFrag decrease time: " .. configManager.getNumber(configKeys.FRAG_TIME) .. "seconds"
		.. "\nWhite scull time: " .. configManager.getNumber(configKeys.WHITE_SKULL_TIME) .. "seconds"
	)
	return false
end
