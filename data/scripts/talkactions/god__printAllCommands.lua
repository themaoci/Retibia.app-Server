local god_print_commands = TalkAction("/cmd")

function god_print_commands.onSay(player, words, param)
	if not Helpers.checkAccessRights(player, ACCOUNT_TYPE_GOD) then
		return true
	end
    Helpers.drawAllAdminCommands(player)
	return false
end

god_print_commands:register()