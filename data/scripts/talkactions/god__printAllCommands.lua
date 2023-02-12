local god_print_commands = TalkAction("/cmd")

function god_print_commands.onSay(player, words, param)
	if not TA_HELPER.checkAccessRights(player, ACCOUNT_TYPE_GOD) then
		return true
	end
    TA_HELPER.drawAllAdminCommands(player)
	return false
end

god_print_commands:register()