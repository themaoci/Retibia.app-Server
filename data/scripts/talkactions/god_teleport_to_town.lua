local god_teleport_to_town = TalkAction("/town")

Helpers.registeredTalkActions["Teleport To Town"] = {
	commandExamples = {"/town name", "/town id"},
	otherInfo = "Teleport to town specified can be name or id",
	limitation = "Game Master and above"
}

function god_teleport_to_town.onSay(player, words, param)
	if not Helpers.checkAccessRights(player, ACCOUNT_TYPE_GAMEMASTER) then
		return true
	end
  	Helpers.logCommand(player, words, param)

	local town = Town(param)
	if town == nil then
		town = Town(tonumber(param))
	end

	if town == nil then
		player:sendCancelMessage("Town not found.")
		return false
	end

	player:teleportTo(town:getTemplePosition())
	return false
end

god_teleport_to_town:separator(" ")
god_teleport_to_town:register()