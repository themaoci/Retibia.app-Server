local Config = {
	['skipLevel'] = true,
	['onlyOneSkill'] = true,
	['skillReq'] = {
		['CQC'] = 0,
		['DIS'] = 0,
		['MAG'] = 0,
	},
	['NAME'] = "Ethereal Spear",
	['INIT'] = false,
}
local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ETHEREALSPEAR)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)

function onGetFormulaValues(player, skill, attack, factor)
	if not Config.INIT then
		Config = LOAD_SPELL_INDYVIDUAL_DATA(Config)
	end
	local mSkill = GetSkillDataFromPlayer(player, Config)
	--local distanceSkill = player:getEffectiveSkillLevel(SKILL_DISTANCE)
	local level = (player:getLevel() / Config.Stats.levelDivider)
	local min = level + (mSkill * Config.Stats.min.skillMul)
	local max = level + mSkill + Config.Stats.max.value
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

