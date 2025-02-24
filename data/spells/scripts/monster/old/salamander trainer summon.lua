local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_NONE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SOUND_RED)

local area = createCombatArea({
	{0, 1, 0},
	{1, 3, 1},
	{0, 1, 0}
})
combat:setArea(area)

local maxsummons = 1

function onCastSpell(creature, var)
	local summoncount = creature:getSummons()
	if #summoncount < 1 then
		mid = Game.createMonster("Troll-trained Salamander", creature:getPosition())
    		if not mid then
				return
			end
		mid:setMaster(creature)
	end
	return combat:execute(creature, var)
end