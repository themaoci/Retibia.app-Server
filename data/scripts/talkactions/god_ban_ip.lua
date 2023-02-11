local god_ban_ip = TalkAction("/banip", "/banIp")

Helpers.registeredTalkActions["Player Ban IP"] = {
	commandExamples = {"/banip name days", "/banIp name days"},
	otherInfo = "999 days = 15 years ban",
	limitation = "Game Master and above"
}
function god_ban_ip.onSay(player, words, param)
	if not Helpers.checkAccessRights(player, ACCOUNT_TYPE_GAMEMASTER) then
		return true
	end
    Helpers.logCommand(player, words, param)

	local name = param
	local days = 60
	local paramTable = param.split(",")
	if(#paramTable == 2) then
		name = paramTable[1]
		days = paramTable[2]
		if(days >= 999) then
		days = 365*15 -- 15 years ban
		end
	end

	local resultId = db.storeQuery("SELECT `account_id`, `lastip` FROM `players` WHERE `name` = " .. db.escapeString(name))
	if resultId == false then
		return false
	end

	local targetIp = result.getDataLong(resultId, "lastip")
	result.free(resultId)

	local targetPlayer = Player(name)
	if targetPlayer then
		targetIp = targetPlayer:getIp()
    	targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You has been banned!!!\nDuration: " .. days .. " days.")
		targetPlayer:remove()
	end

	if targetIp == 0 then
		return false
	end

	resultId = db.storeQuery("SELECT 1 FROM `ip_bans` WHERE `ip` = " .. targetIp)
	if resultId ~= false then
		result.free(resultId)
		return false
	end

	local timeNow = os.time()
	db.query("INSERT INTO `ip_bans` (`ip`, `reason`, `banned_at`, `expires_at`, `banned_by`) VALUES (" ..
			targetIp .. ", '', " .. timeNow .. ", " .. timeNow + (days * 86400) .. ", " .. player:getGuid() .. ")")
	return false
end

god_ban_ip:separator(" ")
god_ban_ip:register()