local god_teleport_to_creature = TalkAction("/goto")

Helpers.registeredTalkActions["Teleport To Creature"] = {
	commandExamples = {"/goto name"},
	otherInfo = "Teleport you to Creature of specified name",
	limitation = "Game Master and above"
}

function god_teleport_to_creature.onSay(player, words, param)
	if not Helpers.checkAccessRights(player, ACCOUNT_TYPE_GAMEMASTER) then
		return true
	end
  	Helpers.logCommand(player, words, param)

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