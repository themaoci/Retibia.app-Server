local god_ghost = TalkAction("/ghost")

Helpers.registeredTalkActions["Ghost"] = {
	commandExamples = {"/ghost"},
	otherInfo = "Makes you completly invisible to anything also allows to move through colliders when hold CTRL (change direction)\nIt's a switch command next usage will make you visible.",
	limitation = "God and above"}

function god_ghost.onSay(player, words, param)
	if not Helpers.checkAccessRights(player, ACCOUNT_TYPE_GOD) then
		return true
	end

  	Helpers.logCommand(player, words, param)

	local position = player:getPosition()
	local isGhost = not player:isInGhostMode()

	player:setGhostMode(isGhost)
	if isGhost then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You are now invisible.")
		position:sendMagicEffect(CONST_ME_POFF)
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You are visible again.")
		position.x = position.x + 1
		position:sendMagicEffect(CONST_ME_POFF)
	end
	return false
end

god_ghost:separator(" ")
god_ghost:register()