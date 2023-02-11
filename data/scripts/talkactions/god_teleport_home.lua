local god_teleport_home = TalkAction("/t")

Helpers.registeredTalkActions["Teleport Home"] = {
	commandExamples = {"/t"},
	otherInfo = "Teleport your saved town temple",
	limitation = "Game Master and above"
}

function god_teleport_home.onSay(player, words, param)
	if not Helpers.checkAccessRights(player, ACCOUNT_TYPE_GAMEMASTER) then
		return true
	end
  	Helpers.logCommand(player, words, param)

	player:teleportTo(player:getTown():getTemplePosition())
	return false
end

god_teleport_home:register()