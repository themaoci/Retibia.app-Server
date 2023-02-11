local god_place_summon = TalkAction("/ps", "/summon")

Helpers.registeredTalkActions["Spawn Summon"] = {
	commandExamples = {"/ps monster_name", "/summon monster_name"},
	otherInfo = "Spawn a Summoned monster in front of you and make you its master",
	limitation = "God and above"
}

function god_place_summon.onSay(player, words, param)
	if not Helpers.checkAccessRights(player, ACCOUNT_TYPE_GOD) then
		return true
	end
  	Helpers.logCommand(player, words, param)

	local position = player:getPosition()
	local monster = Game.createMonster(param, position)
	if monster ~= nil then
		monster:setMaster(player)
		position:sendMagicEffect(CONST_ME_MAGIC_RED)
	else
		player:sendCancelMessage("There is not enough room.")
		position:sendMagicEffect(CONST_ME_POFF)
	end
	return false
end

god_place_summon:separator(" ")
god_place_summon:register()