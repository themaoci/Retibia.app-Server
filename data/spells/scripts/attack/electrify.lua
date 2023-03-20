local Config = {
	['skipLevel'] = true,
	['onlyOneSkill'] = true,
	['skillReq'] = {
		['CQC'] = 0,
		['DIS'] = 0,
		['MAG'] = 0,
	},
	['NAME'] = "Electrify",
	['INIT'] = false,
}
local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)

function onCastSpell(creature, variant)
	if not Config.INIT then
		Config = LOAD_SPELL_INDYVIDUAL_DATA(Config)
	end
	local mSkill = GetSkillDataFromPlayer(creature, Config)
	local level = (creature:getLevel() / Config.Stats.levelDivider)
	local min = level + (mSkill * Config.Stats.min.skillMul) + Config.Stats.min.value
	local max = level + (mSkill * Config.Stats.max.skillMul) + Config.Stats.max.value
	for _, target in ipairs(combat:getTargets(creature, variant)) do
		local rounds = math.random(math.floor(min), math.floor(max))
		creature:addDamageCondition(target, CONDITION_ENERGY, DAMAGELIST_VARYING_PERIOD, target:isPlayer() and 13 or 25, {10, 12}, rounds)
	end
	return true
end

