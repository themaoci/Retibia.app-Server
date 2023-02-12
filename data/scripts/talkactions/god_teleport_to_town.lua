local god_teleport_to_town = TalkAction("/town")

TA_HELPER.registeredTalkActions["Teleport To Town"] = {
	commandExamples = {"/town name", "/town id"},
	otherInfo = "Teleport to town specified can be name or id",
	limitation = "Game Master and above"
}

function god_teleport_to_town.onSay(player, words, param)
	if not TA_HELPER.checkAccessRights(player, ACCOUNT_TYPE_GAMEMASTER) then
		return true
	end

	if param == "help" then
		for i, town in ipairs(Game.getTowns()) do
			local position = town:getTemplePosition()
			player:sendTextMessage(MESSAGE_INFO_DESCR, town:getId() .. " -> " .. db.escapeString(town:getName()) .. " || Where you will be teleported to: X:" .. position.x .. ", Y:" .. position.y .. ", Z:" .. position.z)
		end
	end

  	TA_HELPER.logCommand(player, words, param)

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