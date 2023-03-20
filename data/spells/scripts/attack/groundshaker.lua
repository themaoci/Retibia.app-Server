local Config = {
	['skipLevel'] = true,
	['onlyOneSkill'] = true,
	['skillReq'] = {
		['CQC'] = 0,
		['DIS'] = 0,
		['MAG'] = 0,
	},
	['NAME'] = "Groundshaker",
	['INIT'] = false,
}
local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GROUNDSHAKER)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setParameter(COMBAT_PARAM_USECHARGES, true)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onGetFormulaValues(player, skill, attack, factor)
	if not Config.INIT then
		Config = LOAD_SPELL_INDYVIDUAL_DATA(Config)
	end
	local mSkill = GetSkillDataFromPlayer(player, Config)
	local level = (player:getLevel() / Config.Stats.levelDivider)
	local min = level + (mSkill * attack * Config.Stats.min.skillMul) + Config.Stats.min.value
	local max = level + (mSkill * attack* Config.Stats.max.skillMul) + Config.Stats.max.value
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

