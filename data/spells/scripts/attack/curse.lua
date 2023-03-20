local Config = {
	['skipLevel'] = true,
	['onlyOneSkill'] = true,
	['skillReq'] = {
		['CQC'] = 0,
		['DIS'] = 0,
		['MAG'] = 0,
	},
	['NAME'] = "Curse",
	['INIT'] = false,
}

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_DEATH)

function onCastSpell(creature, variant)
	if not Config.INIT then
		Config = LOAD_SPELL_INDYVIDUAL_DATA(Config)
	end
	local mSkill = GetSkillDataFromPlayer(creature, Config)

	local level = (creature:getLevel() / Config.Stats.levelDivider)
	local min = level + (mSkill * Config.Stats.min.skillMul) + Config.Stats.min.value
	local max = level + (mSkill * Config.Stats.max.skillMul) + Config.Stats.max.value
	local damage = math.random(math.floor(min), math.floor(max))
	for _, target in ipairs(combat:getTargets(creature, variant)) do
		creature:addDamageCondition(target, CONDITION_CURSED, DAMAGELIST_EXPONENTIAL_DAMAGE, damage)
	end
	return true
end

