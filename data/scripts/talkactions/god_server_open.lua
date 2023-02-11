local god_server_open = TalkAction("/serveropen", "/server+")

Helpers.registeredTalkActions["Open Server"] = {
	commandExamples = {"/serveropen", "/server+"},
	otherInfo = "Open server for everyone",
	limitation = "God and above"
}

function god_server_open.onSay(player, words, param)
	if not Helpers.checkAccessRights(player, ACCOUNT_TYPE_GOD) then
		return true
	end
  	Helpers.logCommand(player, words, param)

	Game.setGameState(GAME_STATE_NORMAL)
	DiscordHelper.sendMessage(
		"**Server is open now!. You can login into the game now.**",
		DiscordHelper.channelTypes.SERVER)
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Server is now open.")
	return false
end

god_server_open:register()