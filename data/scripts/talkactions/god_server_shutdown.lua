local god_server_shutdown = TalkAction("/reset")

TA_HELPER.registeredTalkActions["Restart Server"] = {
	commandExamples = {"/reset"},
	otherInfo = "Completly stops the server and starts it again from a linux service script",
	limitation = "God and above"
}

function god_server_shutdown.onSay(player, words, param)
	if not TA_HELPER.checkAccessRights(player, ACCOUNT_TYPE_GOD) then
		return true
	end
  	TA_HELPER.logCommand(player, words, param)

	Game.setGameState(GAME_STATE_SHUTDOWN)
	DiscordHelper.sendMessage(
		"**Server got restarted by Administrator. Should be up and ready for login in few seconds.**",
		DiscordHelper.channelTypes.SERVER)
	return false
end

god_server_shutdown:register()