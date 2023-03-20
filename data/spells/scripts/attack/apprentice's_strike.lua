local Config = {
	['skipLevel'] = true,
	['onlyOneSkill'] = true,
	['skillReq'] = {
		['CQC'] = 0,
		['DIS'] = 0,
		['MAG'] = 0,
	},
	['NAME'] = "Apprentice's Strike",
	['INIT'] = false,
}
local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREATTACK)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)

function onGetFormulaValues(player, level, magicLevel)
	if not Config.INIT then
		Config = LOAD_SPELL_INDYVIDUAL_DATA(Config)
	end
	local mSkill = GetSkillDataFromPlayer(player, Config)

	local skillAtt = mSkill * 10
	local min = (skillAtt * Config.Stats.min.skillMul) + Config.Stats.min.value
	local max = (skillAtt * Config.Stats.max.skillMul) + Config.Stats.max.value
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

