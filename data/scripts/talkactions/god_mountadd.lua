local god_mount = TalkAction("/addmount")

Helpers.registeredTalkActions["Add Mount"] = {
	commandExamples = {"/addmount typeId"},
	otherInfo = "Adds a mount to your player character",
	limitation = "God and above"
}

function god_mount.onSay(player, words, param)
	if not Helpers.checkAccessRights(player, ACCOUNT_TYPE_GOD) then
		return true
	end
  	Helpers.logCommand(player, words, param)
	local params = param.split(param, ",")
	if params[1] == "add" then
		local outfitName = params[3]
		local foundMount = nil
		local target = Player(params[2])
		if(target == nil) then 
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Wrong player specified, unable to find " .. params[2])
			return
		end
		for i = 1, #GameConfig.Mounts do
			if GameConfig.Mounts[i].name == outfitName then
				foundMount = GameConfig.Mounts[i]
			end
		end
		if foundMount == nil then 
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Outfit not found, unable to find " .. outfitName)
			return 
		end
		target:addMount(foundMount.id)
		target:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Mount " .. foundMount.name .. " has been added to your character.")
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You added mount " .. foundMount.name .. " to player " .. target:getName())
	end
	if params[1] == "del" or params[1] == "remove" then
		local outfitName = params[3]
		local foundMount = nil
		local target = Player(params[2])
		if(target == nil) then 
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Wrong player specified, unable to find " .. params[2])
			return
		end
		for i = 1, #GameConfig.Mounts do
			if GameConfig.Mounts[i].name == outfitName then
				foundMount = GameConfig.Mounts[i]
			end
		end
		if foundMount == nil then 
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Outfit not found, unable to find " .. outfitName)
			return 
		end
		target:removeMount(foundMount.id)
		target:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Mount " .. foundMount.name .. " has been removed from your character.")
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You removed mount " .. foundMount.name .. " from player " .. target:getName())
	end
	if params[1] == "showall" then
		local from = tonumber(params[2]) or 1
		local to = tonumber(params[3]) or #GameConfig.Mounts

		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Mount List:")
		for i = 1, #GameConfig.Mounts do
			if i >= from and i <= to then
				player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, GameConfig.Mounts[i].id .. " -> " ..GameConfig.Mounts[i].name)
			end
		end
	end
end

god_mount:separator(" ")
god_mount:register()
