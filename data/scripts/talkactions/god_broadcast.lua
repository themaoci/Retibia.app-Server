local god_broadcast = TalkAction("/B", "/broadcast")

TA_HELPER.registeredTalkActions["Broadcast Message"] = {
	commandExamples = {"/B message", "/broadcast message"},
	otherInfo = "No restriction on characters in message.",
	limitation = "Gamemaster and above + Can Broadcast flag"
}

function god_broadcast.onSay(player, words, param)
	if TA_HELPER.checkIfFlagNotFound(player, PlayerFlag_CanBroadcast) then
		return true
	end	
	if not TA_HELPER.checkAccessRights(player, ACCOUNT_TYPE_GAMEMASTER) then
		return true
	end

  	TA_HELPER.logCommand(player, words, param)
	print("> " .. player:getName() .. " broadcasted: \"" .. param .. "\".")
	DiscordHelper.sendMessage("**" .. param .. "**", Discord.channelTypes.BROADCAST)
	Game.broadcastMessage(param, TALKTYPE_BROADCAST)
	return false
end

god_broadcast:separator(" ")
god_broadcast:register()