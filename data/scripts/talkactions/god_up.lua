local god_up = TalkAction("/up")

Helpers.registeredTalkActions["Teleport Floor Up"] = {
	commandExamples = {"/up"},
	otherInfo = "",
	limitation = "GameMaster and above"
}

function god_up.onSay(player, words, param)
	if not Helpers.checkAccessRights(player, ACCOUNT_TYPE_GAMEMASTER) then
		return true
	end
  	Helpers.logCommand(player, words, param)

	local position = player:getPosition()
	position.z = position.z - 1
	player:teleportTo(position)
	return false
end

god_up:register()