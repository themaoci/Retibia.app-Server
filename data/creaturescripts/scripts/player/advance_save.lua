local config = {
    savePlayer = true,
    OnLevelPlayerSetHpManaFull = false,
    OnMagLevelPlayerSetManaFull = false,
    skillsTable = {
        [SKILL__LEVEL] = { enabled = true, text = "LEVEL UP", textColor = TEXTCOLOR_WHITE},
        [SKILL__MAGLEVEL] = { enabled = true, text = "MAGIC UP", textColor = TEXTCOLOR_BLUE},
        [SKILL_AXE] = { enabled = true, text = "AXE UP", textColor = TEXTCOLOR_ORANGE},
        [SKILL_CLUB] = { enabled = true, text = "CLUB UP", textColor = TEXTCOLOR_ORANGE},
        [SKILL_SWORD] = { enabled = true, text = "SWORD UP", textColor = TEXTCOLOR_ORANGE},
        [SKILL_SHIELD] = { enabled = true, text = "SHIELDING UP", textColor = TEXTCOLOR_ORANGE},
        [SKILL_DISTANCE] = { enabled = true, text = "DISTANCE UP", textColor = TEXTCOLOR_ORANGE}   
    }
}

function onAdvance(player, skill, oldLevel, newLevel)
	if(skill == SKILL__EXPERIENCE) then
        return true
    end

    local skillTable = config.skillsTable[skill]
    if not skillTable then
        return true
    end

    if not skillTable.enabled then
        return true
    end

    if skill == SKILL__LEVEL and config.OnLevelPlayerSetHpManaFull then
        doCreatureAddHealth(cid, getCreatureMaxHealth(cid) - getCreatureHealth(cid))
        doCreatureAddMana(cid, getCreatureMaxMana(cid) - getCreatureMana(cid))
    end
    if skill == SKILL__MAGLEVEL and config.OnMagLevelPlayerSetManaFull then
        doCreatureAddMana(cid, getCreatureMaxMana(cid) - getCreatureMana(cid))
    end
    
    doSendAnimatedText(getPlayerPosition(cid), skillTable.text, skillTable.textColor)

    if config.savePlayer then
        doPlayerSave(cid, true)
    end

    return true
end
