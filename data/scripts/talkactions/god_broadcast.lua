local god_broadcast = TalkAction("/B", "/broadcast")

Helpers.registeredTalkActions["Broadcast Message"] = {
	commandExamples = {"/B message", "/broadcast message"},
	otherInfo = "No restriction on characters in message.",
	limitation = "Gamemaster and above + Can Broadcast flag"
}

function god_broadcast.onSay(player, words, param)
	if Helpers.checkIfFlagNotFound(player, PlayerFlag_CanBroadcast) then
		return true
	end	
	if not Helpers.checkAccessRights(player, ACCOUNT_TYPE_GAMEMASTER) then
		return true
	end

  	Helpers.logCommand(player, words, param)
	print("> " .. player:getName() .. " broadcasted: \"" .. param .. "\".")
	DiscordHelper.sendMessage("**" .. param .. "**", Discord.channelTypes.BROADCAST)
	Game.broadcastMessage(param, TALKTYPE_BROADCAST)
	return false
end

god_broadcast:separator(" ")
god_broadcast:register()