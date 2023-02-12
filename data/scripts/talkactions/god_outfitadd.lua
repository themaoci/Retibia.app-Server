local god_outfit = TalkAction("/outfit")

TA_HELPER.registeredTalkActions["Add Outfit"] = {
	commandExamples = {"/outfir typeId"},
	otherInfo = "Adds an outfit to your player character",
	limitation = "God and above"
}

function god_outfit.onSay(player, words, param)
	if not TA_HELPER.checkAccessRights(player, ACCOUNT_TYPE_GOD) then
		return true
	end
  	TA_HELPER.logCommand(player, words, param)

	local params = param.split(param, ",")
	local playerSex = player:getSex()
	
	if params[1] == "help" then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Usage:\n/outfit add{del,showall},PnayerName,OutfitName")
		return
	end
	if params[1] == "add" then
		local outfitName = params[3]
		local foundOutfit = nil
		local target = Player(params[2])
		if(target == nil) then 
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Wrong player specified, unable to find " .. params[2])
			return
		end
		for i = 1, #GameConfig.Outfits do
			if GameConfig.Outfits[i].name == outfitName then
				if GameConfig.Outfits[i].sex == playerSex then
					foundOutfit = GameConfig.Outfits[i]
				end
			end
		end
		if foundOutfit == nil then 
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Outfit not found, unable to find " .. outfitName)
			return 
		end
		target:addOutfitAddon(foundOutfit.id, 3)
		target:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Outfit " .. foundOutfit.name .. " has been added to your character.")
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You added outfit " .. foundOutfit.name .. " to player " .. target:getName())
		return 
	end
	if params[1] == "del" or params[1] == "remove" then
		local outfitName = params[3]
		local foundOutfit = nil
		local target = Player(params[2])
		if(target == nil) then 
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Wrong player specified, unable to find " .. params[2])
			return
		end
		for i = 1, #GameConfig.Outfits do
			if GameConfig.Outfits[i].name == outfitName then
				if GameConfig.Outfits[i].sex == playerSex then
					foundOutfit = GameConfig.Outfits[i]
				end
			end
		end
		if foundOutfit == nil then 
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Outfit not found, unable to find " .. outfitName)
			return 
		end
		target:removeOutfit(foundOutfit.id)
		target:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Outfit " .. foundOutfit.name .. " has been removed from your character.")
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You removed outfit " .. foundOutfit.name .. " from player " .. target:getName())
		return 
	end
	if params[1] == "showall" then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Outfit List:")
		local from = tonumber(params[2]) or 1
		local to = tonumber(params[3]) or #GameConfig.Outfits
		local intex = 1
		for i = 1, #GameConfig.Outfits do
			if GameConfig.Outfits[i].sex == playerSex then
				if intex >= from and intex <= to then
					player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, GameConfig.Outfits[i].name)
					foundOutfit = GameConfig.Outfits[i]
				end
				intex = intex + 1
			end
		end
		return
	end
end

god_outfit:separator(" ")
god_outfit:register()
