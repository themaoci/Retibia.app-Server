local god_place_monster = TalkAction("/pm", "/m")

TA_HELPER.registeredTalkActions["Spawn Monster"] = {
	commandExamples = {"/pm monster_name", "/m monster_name"},
	otherInfo = "Spawns monster in front of you",
	limitation = "God and above"
}

function god_place_monster.onSay(player, words, param)
	if not TA_HELPER.checkAccessRights(player, ACCOUNT_TYPE_GOD) then
		return true
	end
  	TA_HELPER.logCommand(player, words, param)
	local position = player:getPosition()
	local monster = Game.createMonster(param, position)
	if monster ~= nil then
		monster:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		position:sendMagicEffect(CONST_ME_MAGIC_RED)
	else
		player:sendCancelMessage("There is not enough room.")
		position:sendMagicEffect(CONST_ME_POFF)
	end
	return false
end

god_place_monster:separator(" ")
god_place_monster:register()