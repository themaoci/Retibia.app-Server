local god_teleport_creature_here = TalkAction("/c")

TA_HELPER.registeredTalkActions["Teleport To Closest Creature"] = {
	commandExamples = {"/c name"},
	otherInfo = "Teleport to closest Creature by its name | player's, monster's, npc's included",
	limitation = "God and above"
}

function god_teleport_creature_here.onSay(player, words, param)
	if not TA_HELPER.checkAccessRights(player, ACCOUNT_TYPE_GOD) then
		return true
	end
  	TA_HELPER.logCommand(player, words, param)

	local creature = Creature(param)
	if not creature then
		player:sendCancelMessage("A creature with that name could not be found.")
		return false
	end

	local oldPosition = creature:getPosition()
	local newPosition = creature:getClosestFreePosition(player:getPosition(), false)
	if newPosition.x == 0 then
		player:sendCancelMessage("You can not teleport " .. creature:getName() .. ".")
		return false
	elseif creature:teleportTo(newPosition) then
		if not creature:isInGhostMode() then
			oldPosition:sendMagicEffect(CONST_ME_POFF)
			newPosition:sendMagicEffect(CONST_ME_TELEPORT)
		end
	end
	return false
end

god_teleport_creature_here:separator(" ")
god_teleport_creature_here:register()