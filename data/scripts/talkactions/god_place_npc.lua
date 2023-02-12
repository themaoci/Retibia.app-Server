local god_place_npc = TalkAction("/pn", "/s")

TA_HELPER.registeredTalkActions["Spawn NPC"] = {
	commandExamples = {"/pn npc_name", "/s npc_name"},
	otherInfo = "Spawn an NPC by its name in front of you",
	limitation = "God and above"
}

function god_place_npc.onSay(player, words, param)
	if not TA_HELPER.checkAccessRights(player, ACCOUNT_TYPE_GOD) then
		return true
	end
  	TA_HELPER.logCommand(player, words, param)

	local position = player:getPosition()
	local npc = Game.createNpc(param, position)
	if npc ~= nil then
		npc:setMasterPos(position)
		position:sendMagicEffect(CONST_ME_MAGIC_RED)
	else
		player:sendCancelMessage("There is not enough room.")
		position:sendMagicEffect(CONST_ME_POFF)
	end
	return false
end

god_place_npc:separator(" ")
god_place_npc:register()