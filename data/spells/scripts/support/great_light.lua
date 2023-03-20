local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local condition = Condition(CONDITION_LIGHT)
condition:setParameter(CONDITION_PARAM_LIGHT_LEVEL, SpellConfig['Great Light'].Level)
condition:setParameter(CONDITION_PARAM_LIGHT_COLOR, SpellConfig['Great Light'].Color)
condition:setParameter(CONDITION_PARAM_TICKS, SpellConfig['Great Light'].Time * 1000)
combat:addCondition(condition)

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end
