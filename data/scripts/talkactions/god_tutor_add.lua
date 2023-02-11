local god_tutor_add = TalkAction("/tutor+", "/tutoradd")

Helpers.registeredTalkActions["Add Tutor Group To Player"] = {
	commandExamples = {"/tutor+ name", "/tutoradd name"},
	otherInfo = "Adds a Player a group of a Tutor",
	limitation = "Game Master and above"
}

function god_tutor_add.onSay(player, words, param)
	if not Helpers.checkAccessRights(player, ACCOUNT_TYPE_GAMEMASTER) then
		return true
	end
  	Helpers.logCommand(player, words, param)

	local target = Player(param)
	if target == nil then
		player:sendCancelMessage("A player with that name is not online.")
		return false
	end

	if target:getAccountType() ~= ACCOUNT_TYPE_NORMAL then
		player:sendCancelMessage("You can only promote a normal player to a tutor.")
		return false
	end

	target:setAccountType(ACCOUNT_TYPE_TUTOR)
	target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been promoted to a tutor by " .. player:getName() .. ".")
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have promoted " .. target:getName() .. " to a tutor.")
	return false
end

god_tutor_add:separator(" ")
god_tutor_add:register()