local god_server_open = TalkAction("/serveropen", "/server+")

TA_HELPER.registeredTalkActions["Open Server"] = {
	commandExamples = {"/serveropen", "/server+"},
	otherInfo = "Open server for everyone",
	limitation = "God and above"
}

function god_server_open.onSay(player, words, param)
	if not TA_HELPER.checkAccessRights(player, ACCOUNT_TYPE_GOD) then
		return true
	end
  	TA_HELPER.logCommand(player, words, param)

	Game.setGameState(GAME_STATE_NORMAL)
	DiscordHelper.sendMessage(
		"**Server is open now!. You can login into the game now.**",
		DiscordHelper.channelTypes.SERVER)
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Server is now open.")
	return false
end

god_server_open:register()