local condition = Condition(CONDITION_OUTFIT)
condition:setTicks(SpellConfig['Creature Illusion'].Time)
function onCastSpell(creature, variant)
	local returnValue = RETURNVALUE_NOERROR
	local monsterType = MonsterType(variant:getString())
	if not monsterType then
		returnValue = RETURNVALUE_CREATUREDOESNOTEXIST
	elseif not creature:hasFlag(PlayerFlag_CanIllusionAll) and not monsterType:isIllusionable() then
		returnValue = RETURNVALUE_NOTPOSSIBLE
	end

	if returnValue ~= RETURNVALUE_NOERROR then
		creature:sendCancelMessage(returnValue)
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	condition:setOutfit(monsterType:getOutfit())
	creature:addCondition(condition)
	creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	return true
end
