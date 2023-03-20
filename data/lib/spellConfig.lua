
-- THIS DATA WILL BE CACHED IN EACH SPELL AFTER FIRST USE OF SAID SPELL

SpellConfig = {
    -- EXAMPLE: [""] = { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 0.01, ['value'] = 10 }, ['max'] = { ['skillMul'] = 0.01, ['value'] = 10 } }

    -- TICK ATTACK SPELL --
    ['Curse'] =                     { ['levelDivider'] = 80, ['min'] = { ['skillMul'] = 0.5, ['value'] = 7 }, ['max'] = { ['skillMul'] = 0.9, ['value'] = 8 } },
    ['Electrify'] =                 { ['levelDivider'] = 80, ['min'] = { ['skillMul'] = 0.15, ['value'] = 1 }, ['max'] = { ['skillMul'] = 0.25, ['value'] = 1 } },
    ['Envenom'] =                   { ['levelDivider'] = 80, ['min'] = { ['skillMul'] = 0.55, ['value'] = 6 }, ['max'] = { ['skillMul'] = 0.75, ['value'] = 7 } },
    ['Holy Flash'] =                { ['levelDivider'] = 80, ['min'] = { ['skillMul'] = 0.3, ['value'] = 2 }, ['max'] = { ['skillMul'] = 0.5, ['value'] = 3 } },
    ['Ignite'] =                    { ['levelDivider'] = 80, ['min'] = { ['skillMul'] = 0.3, ['value'] = 2 }, ['max'] = { ['skillMul'] = 0.6, ['value'] = 4 } },
    ['Inflict Wound'] =             { ['levelDivider'] = 80, ['min'] = { ['skillMul'] = 0.2, ['value'] = 2 }, ['max'] = { ['skillMul'] = 0.4, ['value'] = 2 } },
    -- ATTACK SPELL -- 
    ['Buzz'] =                      { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 0.04, ['value'] = 2 }, ['max'] = { ['skillMul'] = 0.08, ['value'] = 5 } },
    ['Chill Out'] =                 { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 0.03, ['value'] = 2 }, ['max'] = { ['skillMul'] = 0.45, ['value'] = 3 } },
    ['Mud Attack'] =                { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 0.4, ['value'] = 2 }, ['max'] = { ['skillMul'] = 0.8, ['value'] = 5 } },
    ['Practice Fire Wave'] =        { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 0.04, ['value'] = 11 }, ['max'] = { ['skillMul'] = 0.08, ['value'] = 14 } },
    ['Scorch'] =                    { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 0.3, ['value'] = 2 }, ['max'] = { ['skillMul'] = 0.45, ['value'] = 3 } },
    ['Annihilation'] =              { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 0.06, ['value'] = 13 }, ['max'] = { ['skillMul'] = 0.14, ['value'] = 34 } },
    ["Apprentice's Strike"] =       { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 0.06, ['value'] = 10 }, ['max'] = { ['skillMul'] = 0.14, ['value'] = 20 }, ['skillGlobalMul'] = 10 },
    ['Berserk'] =                   { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 0.03, ['value'] = 7 }, ['max'] = { ['skillMul'] = 0.05, ['value'] = 11 } },
    ['Brutal Strike'] =             { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 0.02, ['value'] = 4 }, ['max'] = { ['skillMul'] = 0.04, ['value'] = 9 } },
    ['Death Strike'] =              { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 1.4, ['value'] = 8 }, ['max'] = { ['skillMul'] = 2.2, ['value'] = 14 } },
    ['Divine Caldera'] =            { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 5, ['value'] = 25 }, ['max'] = { ['skillMul'] = 6.2, ['value'] = 45 } },
    ['Divine Missile'] =            { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 1.9, ['value'] = 8 }, ['max'] = { ['skillMul'] = 3, ['value'] = 18 } },
    ['Energy Beam'] =               { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 1.8, ['value'] = 11 }, ['max'] = { ['skillMul'] = 3, ['value'] = 19 } },
    ['Energy Strike'] =             { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 1.4, ['value'] = 8 }, ['max'] = { ['skillMul'] = 2.2, ['value'] = 14 } },
    ['Energy Wave'] =               { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 4.5, ['value'] = 20 }, ['max'] = { ['skillMul'] = 7.6, ['value'] = 48 } },
    ['Eternal Winter'] =            { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 5.5, ['value'] = 25 }, ['max'] = { ['skillMul'] = 11, ['value'] = 50 } },
    ['Ethereal Spear'] =            { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 0.7, ['value'] = 0 }, ['max'] = { ['skillMul'] = 5, ['value'] = 0 } },
    ['Fierce Berserk'] =            { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 0.06, ['value'] = 13 }, ['max'] = { ['skillMul'] = 0.11, ['value'] = 27 } },
    ['Fire Wave'] =                 { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 1.2, ['value'] = 7 }, ['max'] = { ['skillMul'] = 2, ['value'] = 12 } },
    ['Flame Strike'] =              { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 1.4, ['value'] = 8 }, ['max'] = { ['skillMul'] = 2.2, ['value'] = 14 } },
    ['Front Sweep'] =               { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 0.04, ['value'] = 11 }, ['max'] = { ['skillMul'] = 0.08, ['value'] = 21 } },
    ['Great Energy Beam'] =         { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 3.6, ['value'] = 22 }, ['max'] = { ['skillMul'] = 6, ['value'] = 37 } },
    ['Groundshaker'] =              { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 0.02, ['value'] = 4 }, ['max'] = { ['skillMul'] = 0.03, ['value'] = 6 } },
    ["Hell's Core"] =               { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 8, ['value'] = 50 }, ['max'] = { ['skillMul'] = 12, ['value'] = 75 } },
    ['Ice Strike'] =                { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 1.4, ['value'] = 8 }, ['max'] = { ['skillMul'] = 2.2, ['value'] = 14 } },
    ['Ice Wave'] =                  { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 0.8, ['value'] = 5 }, ['max'] = { ['skillMul'] = 2, ['value'] = 12 } },
    ['Physical Strike'] =           { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 1.6, ['value'] = 9 }, ['max'] = { ['skillMul'] = 2.4, ['value'] = 14 } },
    ['Rage of the Skies'] =         { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 4, ['value'] = 75 }, ['max'] = { ['skillMul'] = 10, ['value'] = 150 } },
    ['Strong Ethereal Spear'] =     { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 0, ['value'] = 7 }, ['max'] = { ['skillMul'] = 1.5, ['value'] = 13 } },
    ['Strong Ice Wave'] =           { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 4.5, ['value'] = 20 }, ['max'] = { ['skillMul'] = 7.6, ['value'] = 48 } },
    ['Terra Strike'] =              { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 1.4, ['value'] = 8 }, ['max'] = { ['skillMul'] = 2.2, ['value'] = 14 } },
    ['Terra Wave'] =                { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 3.25, ['value'] = 5 }, ['max'] = { ['skillMul'] = 6.75, ['value'] = 30 } },
    ['Ultimate Energy Strike'] =    { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 4.5, ['value'] = 35 }, ['max'] = { ['skillMul'] = 7.3, ['value'] = 55 } },
    ['Ultimate Flame Strike'] =     { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 4.5, ['value'] = 35 }, ['max'] = { ['skillMul'] = 7.3, ['value'] = 55 } },
    ['Ultimate Ice Strike'] =       { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 4.5, ['value'] = 35 }, ['max'] = { ['skillMul'] = 7.3, ['value'] = 55 } },
    ['Ultimate Terra Strike'] =     { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 4.5, ['value'] = 35 }, ['max'] = { ['skillMul'] = 7.3, ['value'] = 55 } },
    ['Whirlwind Throw'] =           { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 0.01, ['value'] = 1 }, ['max'] = { ['skillMul'] = 0.03, ['value'] = 6 } },
    ['Wrath of Nature'] =           { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 3, ['value'] = 32 }, ['max'] = { ['skillMul'] = 9, ['value'] = 40 } },
    ['Lightning'] =                 { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 2.2, ['value'] = 12 }, ['max'] = { ['skillMul'] = 3.4, ['value'] = 21 } },
    ['Strong Energy Strike'] =      { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 2.8, ['value'] = 16 }, ['max'] = { ['skillMul'] = 4.4, ['value'] = 28 } },
    ['Strong Flame Strike'] =       { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 2.8, ['value'] = 16 }, ['max'] = { ['skillMul'] = 4.4, ['value'] = 28 } },
    ['Strong Ice Strike'] =         { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 2.8, ['value'] = 16 }, ['max'] = { ['skillMul'] = 4.4, ['value'] = 28 } },
    ['Strong Terra Strike'] =       { ['levelDivider'] = 5, ['min'] = { ['skillMul'] = 2.8, ['value'] = 16 }, ['max'] = { ['skillMul'] = 4.4, ['value'] = 28 } },
    -- HEAL SPELL -- 

    -- SUPPORT SPELL --
    ['Ultimate Light'] = { ['Level'] = 12, ['Color'] = 215, ['Time'] = 33 * 60 + 10 },
    ['Great Light'] = { ['Level'] = 8, ['Color'] = 215, ['Time'] = 11 * 60 + 10 },
    ['Light'] = { ['Level'] = 6, ['Color'] = 215, ['Time'] = 6 * 60 + 10 },
    ['Creature Illusion'] = { ['Time'] = 180000 },

}