
function StaffMembersAutoGhost(player)
	if (GameConfig.autoGhostStaffMembers and player:getGroup():getId() >= 4) then
        player:setGhostMode(true)
    end
end
function TutorMessage(player) 
	if (player:getAccountType() == ACCOUNT_TYPE_TUTOR) then
		if GameConfig.Tutor.WelcomeMessageEnabled then
        	player:popupFYI(GameConfig.Tutor.WelcomeMessageRules)
		end
    end
end
function GodAndGMMessage(player)
	if (player:getAccountType() >= ACCOUNT_TYPE_GAMEMASTER) then
		if GameConfig.God.WelcomeMessageEnabled then
        	player:popupFYI(GameConfig.God.WelcomeMessageRules)
		end
    end
end
function AutoOpenChannels(player)
 	-- OPEN CHANNELS
	--if table.contains({"Rookgaard", "Dawnport"}, player:getTown():getName())then
	--	player:openChannel(3) -- world chat
	--	player:openChannel(6) -- advertsing rook main
	--else
		player:openChannel(3) -- world chat
		player:openChannel(5) -- advertsing main
	--end

end
local function onMovementRemoveProtection(cid, oldPosition, time)
    local player = Player(cid)
    if not player then
        return true
    end

    local playerPosition = player:getPosition()
    if (playerPosition.x ~= oldPosition.x or playerPosition.y ~= oldPosition.y or playerPosition.z ~= oldPosition.z) or player:getTarget() then
        player:setStorageValue(50722, 0)
        return true
    end

    addEvent(onMovementRemoveProtection, 1000, cid, oldPosition, time - 1)
end

local function ShowLastLoginIp(player)
  convertedIp = ""
  --print(Game.convertIpToString(player:getIp()))
  local index = 1
  for k, v in string.gmatch(Game.convertIpToString(player:getIp()), "([^.]+)") do
    if index == 1 or index == 4 then
      convertedIp = convertedIp .. k
      if index == 1 then
        convertedIp = convertedIp .. ":"
      end
    else
      convertedIp = convertedIp .. "***"
      if index < 4 then
        convertedIp = convertedIp .. ":"
      end
    end
    index = index + 1
  end
  
  loginStr = string.format(
    "Your last visit in %s: %s.\nLast registered IP: %s", 
    serverName, 
    os.date("%d %b %Y %X", player:getLastLoginSaved()), 
    convertedIp)
    
	player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)

end

function onLogin(player)
	local serverName = configManager.getString(configKeys.SERVER_NAME)
	local loginStr = "Welcome to " .. serverName .. "!"
	if player:getLastLoginSaved() <= 0 then
		loginStr = loginStr .. " Please choose your outfit."
		player:sendOutfitWindow()
    player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
	else
		if loginStr ~= "" then
			player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
		end
    ShowLastLoginIp(player)
	end

	-- Stamina
	nextUseStaminaTime[player.uid] = 0

	TutorMessage(player)
	GodAndGMMessage(player)
	StaffMembersAutoGhost(player)
	AutoOpenChannels(player)
  
	-- Promotion
	-- local vocation = player:getVocation()
	-- local promotion = vocation:getPromotion()
	-- if player:isPremium() then
		-- local value = player:getStorageValue(PlayerStorageKeys.promotion)
		-- if not promotion and value ~= 1 then
			-- player:setStorageValue(STORAGEVALUE_PROMOTION, 1)
		-- elseif value == 1 then
			-- player:setVocation(promotion)
		-- end
	-- elseif not promotion then
		-- player:setVocation(vocation:getDemotion())
	-- end
  if player:getStorageValue(50722) < 1 then
    player:setStorageValue(50722, 1)
    onMovementRemoveProtection(playerId, player:getPosition(), 10)
	end
	-- Events
	player:registerEvent("PlayerDeath")
	player:registerEvent("DropLoot")
  -- register in database that player isOnline
  --db.query("UPDATE `players` SET `isonline` = '1' WHERE `id` = " .. player:getGuid())
	return true
end
