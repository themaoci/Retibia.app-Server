local god_mccheck = TalkAction("/mc", "/mccheck")

TA_HELPER.registeredTalkActions["Multi Account Check"] = {
	commandExamples = {"/mc", "/mccheck"},
	otherInfo = "Shows every multi account player in server that is online",
	limitation = "Game Master and above"
}

function god_mccheck.onSay(player, words, param)
	if not TA_HELPER.checkAccessRights(player, ACCOUNT_TYPE_GAMEMASTER) then
		return true
	end
  	TA_HELPER.logCommand(player, words, param)
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Multiclient Check List:")

	local ipList = {}
	local players = Game.getPlayers()
	for i = 1, #players do
		local tmpPlayer = players[i]
		local ip = tmpPlayer:getIp()
		if ip ~= 0 then
			local list = ipList[ip]
			if not list then
				ipList[ip] = {}
				list = ipList[ip]
			end
			list[#list + 1] = tmpPlayer
		end
	end

	for ip, list in pairs(ipList) do
		local listLength = #list
		if listLength > 1 then
			local tmpPlayer = list[1]
			local message = ("%s: %s [%d]"):format(Game.convertIpToString(ip), tmpPlayer:getName(), tmpPlayer:getLevel())
			for i = 2, listLength do
				tmpPlayer = list[i]
				message = ("%s, %s [%d]"):format(message, tmpPlayer:getName(), tmpPlayer:getLevel())
			end
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, message .. ".")
		end
	end
	return false
end

god_mccheck:separator(" ")
god_mccheck:register()