Helpers = {}
Helpers.registeredTalkActions = {}
Helpers.drawAllAdminCommands = function(player)
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "> Admin command list:")
	for name, data in pairs(Helpers.registeredTalkActions) do
		local description = "--- " .. tostring(name) .. " ---\n" .. "Info: " .. tostring(data.otherInfo) .. "\nRestriction:" .. tostring(data.limitation)
		for _, text in ipairs(data.commandExamples) do
			description = description .. "\n" .. tostring(text)
		end
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, description)
	end
end

Helpers.checkAccessRights = function(player, minimalRights)
	if not player:getGroup():getAccess() then
		return false
	end
	if player:getAccountType() < minimalRights then
		return false
	end

	return true
end

Helpers.checkRights = function(player, minimalRights)
	if player:getAccountType() < minimalRights then
		return false
	end

	return true
end

--returns true if flag was not found good for if statements
Helpers.checkIfFlagNotFound = function(player, flag)
	return not getPlayerFlagValue(player, flag)
end

Helpers.logCommand = function(player, words, param)
  local logFormat = "[%s] %s %s"
  local file = io.open("data/logs/player/" .. player:getName() .. " commands.log", "a")
	if not file then
		return
	end

	io.output(file)
	io.write(logFormat:format(os.date("%d/%m/%Y %H:%M"), words, param):trim() .. "\n")
	io.close(file)
	return
end