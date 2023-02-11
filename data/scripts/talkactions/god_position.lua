local god_position = TalkAction("/pos")

Helpers.registeredTalkActions["Teleport To Position"] = {
	commandExamples = {"/pos x,y,z"},
	otherInfo = "Teleports you to specified position",
	limitation = "Game Master and above"
}

function god_position.onSay(player, words, param)
	local hasAccess = Helpers.checkAccessRights(player, ACCOUNT_TYPE_GAMEMASTER)
	if hasAccess and param ~= "" then
		Helpers.logCommand(player, words, param)
		local split = param:split(",")
		if(split[1] ~= nil and split[2] ~= nil and split[3] ~= nil) then
			player:teleportTo(Position(split[1], split[2], split[3]))
		end
	end
	return false
end

god_position:separator(" ")
god_position:register()
