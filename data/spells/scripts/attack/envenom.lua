local Config = {
	['skipLevel'] = true,
	['onlyOneSkill'] = true,
	['skillReq'] = {
		['CQC'] = 0,
		['DIS'] = 0,
		['MAG'] = 0,
	},
	['NAME'] = "Envenom",
	['INIT'] = false,
}
local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_CARNIPHILA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_EARTH)

function onCastSpell(creature, variant)
	if not Config.INIT then
		Config = LOAD_SPELL_INDYVIDUAL_DATA(Config)
	end
	local mSkill = GetSkillDataFromPlayer(creature, Config)
	local level = (creature:getLevel() / Config.Stats.levelDivider)
	local min = level + (mSkill * Config.Stats.min.skillMul) + Config.Stats.min.value
	local max = level + (mSkill * Config.Stats.max.skillMul) + Config.Stats.max.value
	for _, target in ipairs(combat:getTargets(creature, variant)) do
		local damage = math.random(math.floor(min) * 1000, math.floor(max) * 1000) / 1000
		creature:addDamageCondition(target, CONDITION_POISON, DAMAGELIST_LOGARITHMIC_DAMAGE, target:isPlayer() and damage / 2 or damage)
	end
	return true
end

