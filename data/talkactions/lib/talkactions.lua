local logFormat = "[%s] %s %s"

function logCommand(player, words, param)
	local file = io.open("data/logs/" .. player:getName() .. " commands.log", "a")
	if not file then
		return
	end

	io.output(file)
	io.write(logFormat:format(os.date("%d/%m/%Y %H:%M"), words, param):trim() .. "\n")
	io.close(file)
end

function checkAccessRights(player, minimalRights)
	if not player:getGroup():getAccess() then
		return false
	end

	if player:getAccountType() < minimalRights then
		return false
	end

	return true
end

function checkRights(player, minimalRights)
	if player:getAccountType() < minimalRights then
		return false
	end

	return true
end