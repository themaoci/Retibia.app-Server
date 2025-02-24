local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 6)
combat:setArea(createCombatArea(AREA_SQUARE1X1))

local condition = Condition(COMBAT_PHYSICALDAMAGE)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(3, 10000, -25)
combat:addCondition(condition)

function onCastSpell(creature, var)
	return combat:execute(creature, var)
end