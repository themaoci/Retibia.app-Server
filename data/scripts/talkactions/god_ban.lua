local god_ban = TalkAction("/ban")

Helpers.registeredTalkActions["Player Ban"] = {
	commandExamples = {"/ban name days reason", "/ban name days reason"},
	otherInfo = "999 days = 15 years ban",
	limitation = "Game Master and above"
}

function god_ban.onSay(player, words, param)
	if not Helpers.checkAccessRights(player, ACCOUNT_TYPE_GAMEMASTER) then
		return true
	end  
  	Helpers.logCommand(player, words, param)
  
	local name = param
	local reason = ''
	local days = 7

	local separatorPos = param:split(',')
	if separatorPos ~= nil then
		name = separatorPos[1]
		days = tonumber(separatorPos[2])
		if days >= 999 then
			days = 365*15 -- 15 years ban
		end
		reason = string.trim(separatorPos[3])
	end

	local accountId = getAccountNumberByPlayerName(name)
	if accountId == 0 then
		return false
	end

	local resultId = db.storeQuery("SELECT 1 FROM `account_bans` WHERE `account_id` = " .. accountId)
	if resultId ~= false then
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Player " .. name .. " [" .. accountId .. "] is already banned");
		result.free(resultId)
		return false
	end

	local timeNow = os.time()
	db.query("INSERT INTO `account_bans` (`account_id`, `reason`, `banned_at`, `expires_at`, `banned_by`) VALUES (" ..
			accountId .. ", " .. db.escapeString(reason) .. ", " .. timeNow .. ", " .. timeNow + (days * 86400) .. ", " .. player:getGuid() .. ")")
	local Reason = ''
	if(Reason ~= "") then
		Reason = "\nSpecified reason: " .. reason
	end
	local target = Player(name)
	if target ~= nil then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, target:getName() .. " has been banned.")
    target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You has been banned!!!\nDuration: " .. days .. " days." .. Reason)
		target:remove()
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, name .. " was already banned.")
	end
end

god_ban:separator(" ")
god_ban:register()