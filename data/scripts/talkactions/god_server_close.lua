local god_server_close = TalkAction("/serverclose", "/server-")

Helpers.registeredTalkActions["Close Server"] = {
	commandExamples = {"/serverclose", "/server-"},
	otherInfo = "Close server for players allow only staff to enter",
	limitation = "God and above"
}

function god_server_close.onSay(player, words, param)
	if not Helpers.checkAccessRights(player, ACCOUNT_TYPE_GOD) then
		return true
	end
  	Helpers.logCommand(player, words, param)

	Game.setGameState(GAME_STATE_CLOSED)
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Server is now closed.")
	DiscordHelper.sendMessage(
		"**Server has been closed now. We will notify you immidietly when server will be open again.**",
		DiscordHelper.channelTypes.SERVER)

	return false
end

god_server_close:separator(" ")
god_server_close:register()