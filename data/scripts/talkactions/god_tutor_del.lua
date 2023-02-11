local god_tutor_del = TalkAction("/tutor-", "/tutorremove")

Helpers.registeredTalkActions["Remove Tutor Group From Player"] = {
	commandExamples = {"/tutor- name", "/tutorremove name"},
	otherInfo = "Removes from a Player a group of a Tutor",
	limitation = "Game Master and above"
}

function god_tutor_del.onSay(player, words, param)
	if not Helpers.checkAccessRights(player, ACCOUNT_TYPE_GAMEMASTER) then
		return true
	end
  	Helpers.logCommand(player, words, param)

	local resultId = db.storeQuery("SELECT `name`, `account_id`, (SELECT `type` FROM `accounts` WHERE `accounts`.`id` = `account_id`) AS `account_type` FROM `players` WHERE `name` = " .. db.escapeString(param))
	if resultId == false then
		player:sendCancelMessage("A player with that name does not exist.")
		return false
	end

	if result.getDataInt(resultId, "account_type") ~= ACCOUNT_TYPE_TUTOR then
		player:sendCancelMessage("You can only demote a tutor to a normal player.")
		return false
	end

	local target = Player(param)
	if target ~= nil then
		target:setAccountType(ACCOUNT_TYPE_NORMAL)
	else
		db.query("UPDATE `accounts` SET `type` = " .. ACCOUNT_TYPE_NORMAL .. " WHERE `id` = " .. result.getDataInt(resultId, "account_id"))
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have demoted " .. result.getDataString(resultId, "name") .. " to a normal player.")
	result.free(resultId)
	return false
end

god_tutor_del:separator(" ")
god_tutor_del:register()