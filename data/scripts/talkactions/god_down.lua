local god_down = TalkAction("/down")

TA_HELPER.registeredTalkActions["Teleport Floor Down"] = {
	commandExamples = {"/down"},
	otherInfo = "",
	limitation = "GameMaster and above"
}
function god_down.onSay(player, words, param)
	if not TA_HELPER.checkAccessRights(player, ACCOUNT_TYPE_GAMEMASTER) then
		return true
	end
  	TA_HELPER.logCommand(player, words, param)

	local position = player:getPosition()
	position.z = position.z + 1
	player:teleportTo(position)
	return false
end

god_down:register()