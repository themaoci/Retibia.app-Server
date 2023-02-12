local god_teleport_to_creature = TalkAction("/goto")

TA_HELPER.registeredTalkActions["Teleport To Creature"] = {
	commandExamples = {"/goto name"},
	otherInfo = "Teleport you to Creature of specified name",
	limitation = "Game Master and above"
}

function god_teleport_to_creature.onSay(player, words, param)
	if not TA_HELPER.checkAccessRights(player, ACCOUNT_TYPE_GAMEMASTER) then
		return true
	end
  	TA_HELPER.logCommand(player, words, param)

	local target = Creature(param)
	if target == nil then
		player:sendCancelMessage("Creature not found.")
		return false
	end

	player:teleportTo(target:getPosition())
	return false
end

god_teleport_to_creature:separator(" ")
god_teleport_to_creature:register()