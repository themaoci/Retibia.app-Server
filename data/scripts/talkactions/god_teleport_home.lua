local god_teleport_home = TalkAction("/t")

TA_HELPER.registeredTalkActions["Teleport Home"] = {
	commandExamples = {"/t"},
	otherInfo = "Teleport your saved town temple",
	limitation = "Game Master and above"
}

function god_teleport_home.onSay(player, words, param)
	if not TA_HELPER.checkAccessRights(player, ACCOUNT_TYPE_GAMEMASTER) then
		return true
	end
  	TA_HELPER.logCommand(player, words, param)

	player:teleportTo(player:getTown():getTemplePosition())
	return false
end

god_teleport_home:register()