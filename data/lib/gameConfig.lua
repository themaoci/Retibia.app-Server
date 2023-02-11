GameConfig = {
  ['Outfits'] = nil,
  ['Mounts'] = nil,
  ['Spells'] = {
    ['Instant'] = nil,
    ['Rune'] = nil
  },
  ['sharedExpPercentage'] = 1.2,
  ['autoGhostStaffMembers'] = true,
  ["God"] = {
    ['WelcomeMessageEnabled'] = false,
    ['WelcomeMessageCommands'] = [[
-- COMMANDS --
/ban {username},{reason},{time in days}
/banid - works the same as /ban without time
/i {itemId},{amount}
-- COMMANDS --
]]
  }, 
  ["Tutor"] = {
    ['WelcomeMessageEnabled'] = false,
    ['WelcomeMessageRules'] = [[ Tutor Rules
1 *> 3 Warnings you lose the job.
2 *> Without parallel conversations with players in Help, if the player starts offending, you simply mute it.
3 *> Be educated with the players in Help and especially in the Private, try to help as much as possible.
4 *> Always be on time, if you do not have a justification you will be removed from the staff.
5 *> Help is only allowed to ask questions related to tibia.
6 *> It is not allowed to divulge time up or to help in quest.
7 *> You are not allowed to sell items in the Help.
8 *> If the player encounters a bug, ask to go to the website to send a ticket and explain in detail.
9 *> Always keep the Tutors Chat open. (required).
10 *> You have finished your schedule, you have no tutor online, you communicate with some CM in-game or ts and stay in the help until someone logs in, if you can.
11 *> Always keep a good Portuguese in the Help, we want tutors who support, not that they speak a satanic ritual.
12 *> If you see a tutor doing something that violates the rules, take a print and send it to your superiors. "
- Commands -
Mute Player: /mute nick, 90. (90 seconds)
Unmute Player: /unmute nick.
- Commands -]]
  },
  ['StartItems'] = {
      --club, coat
      items = {{2175, 1}},
      --container rope, shovel, red apple
      container = {{2674, 2}}
  },
  ['PremiumTile'] = {
    StepInActionId = 50241,
    kickEffect = CONST_ME_MAGIC_BLUE,
    kickMsg = "Only noble citizens can pass, get your premium account on our website!",
    enterMsg = "Welcome to a premium area!",
    enterEffect = CONST_ME_MAGIC_BLUE
  },
  ['LevelTile'] = {
    TileStepOut = 446,
    TileStepIn = 447,
    kickMsg = "Only players with level %s and above may leave the town!"
  },
  ["Vocations"] = {
    ["warrior"] = {
      text = "You have been blessed by ×ÞÎ þçâ and now you can call yourself a Warrior!",
      vocationId = 2,
      --equipment
      {
      },
      --container
      {
        {2120, 1},  -- rope
        {2554, 1},  -- shovel
        {7618, 50}, -- health potion
        {7620, 10}, -- mana potion
        {2152, 20}  -- platinum coins
      }
    },		
    ["rogue"] = {
      text = "You have been blessed by ×ÞÎ þçâ and now you can call yourself a Rogue!",
      vocationId = 4,
      --equipment
      {
      },
      --container
      {
        {2120, 1},  -- rope
        {2554, 1},  -- shovel
        {7618, 55}, -- health potion
        {7620, 5}, -- mana potion
        {2152, 40}  -- platinum coins
      }
    },
    ["mage"] = {
      text = "You have been blessed by ×ÞÎ þçâ and now you can call yourself a Mage!",
      vocationId = 3,
      --equipment
      {
      },
      --container
      {
        {2120, 1},  -- rope
        {2554, 1},  -- shovel
        {7618, 10}, -- health potion
        {7620, 50}, -- mana potion
        {2152, 30}  -- platinum coins
      }
    },
    ["all_rounder"] = {
      text = "You have been blessed by ×ÞÎ þçâ and now you can call yourself a All Rounder!",
      vocationId = 1,
      --equipment
      {
      },
      --container
      {
        {2120, 1},  -- rope
        {2554, 1},  -- shovel
        {7618, 30}, -- health potion
        {7620, 30}, -- mana potion
        {2152, 100} -- platinum coins
      }
    }
  },
  ["Spells"] = {
    ["Free"] = {
      ["irrumabo mana"] =           { name="Fuck mana",                     isPremium="0", price=0, level=0, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori infir tera"] =        { name="Mud Attack",                    isPremium="0", price=0, level=1, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori infir vis"] =         { name="Buzz",                          isPremium="0", price=0, level=1, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori min flam"] =          { name="Apprentice's Strike",           isPremium="0", price=0, level=1, mlevel=0, clevel=0, dlevel=0 }, 
      ["exura"] =                   { name="Light Healing",                 isPremium="0", price=0, level=1, mlevel=0, clevel=0, dlevel=0 }, 
      ["exura dis"] =               { name="Practice Healing",              isPremium="0", price=0, level=1, mlevel=0, clevel=0, dlevel=0 }, 
      ["exura ico"] =               { name="Wound Cleansing",               isPremium="0", price=0, level=1, mlevel=0, clevel=0, dlevel=0 }, 
      ["exura infir"] =             { name="Magic Patch",                   isPremium="0", price=0, level=1, mlevel=0, clevel=0, dlevel=0 }, 
      ["exura infir ico"] =         { name="Bruise Bane",                   isPremium="0", price=0, level=1, mlevel=0, clevel=0, dlevel=0 }, 
      ["utevo lux"] =               { name="Light",                         isPremium="0", price=0, level=1, mlevel=0, clevel=0, dlevel=0 }, 
      ["exevo dis flam hur"] =      { name="Practice Fire Wave",            isPremium="0", price=0, level=1, mlevel=0, clevel=0, dlevel=0 }, 
      ["exevo infir con"] =         { name="Arrow Call",                    isPremium="0", price=0, level=1, mlevel=0, clevel=0, dlevel=0 }, 
      ["exevo infir flam hur"] =    { name="Scorch",                        isPremium="0", price=0, level=1, mlevel=0, clevel=0, dlevel=0 }, 
      ["exevo infir frigo hur"] =   { name="Chill Out",                     isPremium="0", price=0, level=1, mlevel=0, clevel=0, dlevel=0 }, 
      ["adori blank"] =             { name="Blank Rune",                    isPremium="0", price=100, level=5, mlevel=0, clevel=0, dlevel=0 }, 
      ["adori dis min vis"] =       { name="Practice Magic Missile Rune",   isPremium="0", price=500, level=5, mlevel=0, clevel=0, dlevel=0 }, 
      ["adori infir vis"] =         { name="Lightest Missile Rune",         isPremium="0", price=450, level=5, mlevel=0, clevel=0, dlevel=0 }, 
      ["exiva"] =                   { name="Find Person",                   isPremium="0", price=1000, level=8, mlevel=0, clevel=0, dlevel=0 }, 
      ["exana pox"] =               { name="Cure Poison",                   isPremium="0", price=150, level=10, mlevel=0, clevel=0, dlevel=0 }, 
      ["exevo con"] =               { name="Conjure Arrow",                 isPremium="0", price=450, level=13, mlevel=0, clevel=0, dlevel=0 }, 
      ["utevo gran lux"] =          { name="Great Light",                   isPremium="0", price=500, level=13, mlevel=0, clevel=0, dlevel=0 }, 
      ["utamo vita"] =              { name="Magic Shield",                  isPremium="0", price=450, level=14, mlevel=0, clevel=0, dlevel=0 }, 
      ["exevo pan"] =               { name="Food",                          isPremium="0", price=300, level=14, mlevel=0, clevel=0, dlevel=0 }, 
      ["adevo grav pox"] =          { name="Poison Field Rune",             isPremium="0", price=300, level=14, mlevel=0, clevel=0, dlevel=0 }, 
      ["adana pox"] =               { name="Cure Poison Rune",              isPremium="0", price=600, level=15, mlevel=0, clevel=0, dlevel=0 }, 
      ["adevo grav flam"] =         { name="Fire Field Rune",               isPremium="0", price=500, level=15, mlevel=0, clevel=0, dlevel=0 }, 
      ["adura gran"] =              { name="Intense Healing Rune",          isPremium="0", price=600, level=15, mlevel=0, clevel=0, dlevel=0 }, 
      ["adori min vis"] =           { name="Light Magic Missile Rune",      isPremium="0", price=500, level=15, mlevel=0, clevel=0, dlevel=0 }, 
      ["exevo con pox"] =           { name="Conjure Poisoned Arrow",        isPremium="0", price=1000, level=16, mlevel=0, clevel=0, dlevel=0 }, 
      ["adeta sio"] =               { name="Convince Creature Rune",        isPremium="0", price=800, level=16, mlevel=0, clevel=0, dlevel=0 }, 
      ["adito grav"] =              { name="Destroy Field Rune",            isPremium="0", price=700, level=17, mlevel=0, clevel=0, dlevel=0 }, 
      ["exevo flam hur"] =          { name="Fire Wave",                     isPremium="0", price=850, level=18, mlevel=0, clevel=0, dlevel=0 }, 
      ["exevo frigo hur"] =         { name="Ice Wave",                      isPremium="0", price=850, level=18, mlevel=0, clevel=0, dlevel=0 }, 
      ["exura gran"] =              { name="Intense Healing",               isPremium="0", price=350, level=20, mlevel=0, clevel=0, dlevel=0 }, 
      ["utevo res ina"] =           { name="Creature Illusion",             isPremium="0", price=1000, level=23, mlevel=0, clevel=0, dlevel=0 }, 
      ["exevo vis lux"] =           { name="Energy Beam",                   isPremium="0", price=1000, level=23, mlevel=0, clevel=0, dlevel=0 }, 
      ["adori tera"] =              { name="Stalagmite Rune",               isPremium="0", price=1400, level=24, mlevel=0, clevel=0, dlevel=0 }, 
      ["adura vita"] =              { name="Ultimate Healing Rune",         isPremium="0", price=1500, level=24, mlevel=0, clevel=0, dlevel=0 }, 
      ["exevo con flam"] =          { name="Conjure Explosive Arrow",       isPremium="0", price=1000, level=25, mlevel=0, clevel=0, dlevel=0 }, 
      ["adori vis"] =               { name="Heavy Magic Missile Rune",      isPremium="0", price=1500, level=25, mlevel=0, clevel=0, dlevel=0 }, 
      ["utevo res"] =               { name="Summon Creature",               isPremium="0", price=2000, level=25, mlevel=0, clevel=0, dlevel=0 }, 
      ["adevo ina"] =               { name="Chameleon Rune",                isPremium="0", price=1300, level=27, mlevel=0, clevel=0, dlevel=0 }, 
      ["adevo mas flam"] =          { name="Fire Bomb Rune",                isPremium="0", price=1500, level=27, mlevel=0, clevel=0, dlevel=0 }, 
      ["exevo gran vis lux"] =      { name="Great Energy Beam",             isPremium="0", price=1800, level=29, mlevel=0, clevel=0, dlevel=0 }, 
      ["adevo mas grav pox"] =      { name="Poison Wall Rune",              isPremium="0", price=1600, level=29, mlevel=0, clevel=0, dlevel=0 }, 
      ["exura vita"] =              { name="Ultimate Healing",              isPremium="0", price=1000, level=30, mlevel=0, clevel=0, dlevel=0 }, 
      ["adori mas flam"] =          { name="Great Fireball Rune",           isPremium="0", price=1200, level=30, mlevel=0, clevel=0, dlevel=0 }, 
      ["adori mas frigo"] =         { name="Avalanche Rune",                isPremium="0", price=1200, level=30, mlevel=0, clevel=0, dlevel=0 }, 
      ["adevo mas hur"] =           { name="Explosion Rune",                isPremium="0", price=1800, level=31, mlevel=0, clevel=0, dlevel=0 }, 
      ["adevo mas grav flam"] =     { name="Fire Wall Rune",                isPremium="0", price=2000, level=33, mlevel=0, clevel=0, dlevel=0 }, 
      ["utana vid"] =               { name="Invisibility",                  isPremium="0", price=2000, level=35, mlevel=0, clevel=0, dlevel=0 }, 
      ["exura san"] =               { name="Divine Healing",                isPremium="0", price=3000, level=35, mlevel=0, clevel=0, dlevel=0 }, 
      ["exevo tera hur"] =          { name="Terra Wave",                    isPremium="0", price=2500, level=38, mlevel=0, clevel=0, dlevel=0 }, 
      ["exevo vis hur"] =           { name="Energy Wave",                   isPremium="0", price=2500, level=38, mlevel=0, clevel=0, dlevel=0 }, 
      ["adevo mas grav vis"] =      { name="Energy Wall Rune",              isPremium="0", price=2500, level=41, mlevel=0, clevel=0, dlevel=0 }, 
      ["adori gran mort"] =         { name="Sudden Death Rune",             isPremium="0", price=3000, level=45, mlevel=0, clevel=0, dlevel=0 }, 
  
      ["alana sio"] =               { name="Kick Guest",                    isPremium="0", price=0, level=1, mlevel=0, clevel=0, dlevel=0 }, 
      ["aleta grav"] =              { name="Edit Door",                     isPremium="0", price=0, level=1, mlevel=0, clevel=0, dlevel=0 }, 
      ["aleta sio"] =               { name="Invite Guests",                 isPremium="0", price=0, level=1, mlevel=0, clevel=0, dlevel=0 }, 
      ["aleta som"] =               { name="Invite Subowners",              isPremium="0", price=0, level=1, mlevel=0, clevel=0, dlevel=0 }
    },
    ["Premium"] = {
      ["adori infir mas tera"] =    { name="Light Stone Shower Rune",   isPremium="1", price=500, level=1, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori vis"] =               { name="Energy Strike",             isPremium="1", price=800, level=12, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori tera"] =              { name="Terra Strike",              isPremium="1", price=800, level=13, mlevel=0, clevel=0, dlevel=0 }, 
      ["utani hur"] =               { name="Haste",                     isPremium="1", price=600, level=14, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori flam"] =              { name="Flame Strike",              isPremium="1", price=800, level=14, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori frigo"] =             { name="Ice Strike",                isPremium="1", price=800, level=15, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori moe ico"] =           { name="Physical Strike",           isPremium="1", price=800, level=16, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori mort"] =              { name="Death Strike",              isPremium="1", price=800, level=16, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori ico"] =               { name="Brutal Strike",             isPremium="1", price=1000, level=16, mlevel=0, clevel=0, dlevel=0 }, 
      ["exevo con mort"] =          { name="Conjure Bolt",              isPremium="1", price=450, level=17, mlevel=0, clevel=0, dlevel=0 }, 
      ["exura sio"] =               { name="Heal Friend",               isPremium="1", price=800, level=18, mlevel=0, clevel=0, dlevel=0 }, 
      ["utani gran hur"] =          { name="Strong Haste",              isPremium="1", price=1300, level=20, mlevel=0, clevel=0, dlevel=0 }, 
      ["exeta res"] =               { name="Challenge",                 isPremium="1", price=2000, level=20, mlevel=0, clevel=0, dlevel=0 }, 
      ["adito tera"] =              { name="Disintegrate Rune",         isPremium="1", price=900, level=21, mlevel=0, clevel=0, dlevel=0 }, 
      ["exana vis"] =               { name="Cure Electrification",      isPremium="1", price=1000, level=22, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori con"] =               { name="Ethereal Spear",            isPremium="1", price=1100, level=23, mlevel=0, clevel=0, dlevel=0 }, 
      ["exevo con hur"] =           { name="Conjure Sniper Arrow",      isPremium="1", price=1000, level=24, mlevel=0, clevel=0, dlevel=0 }, 
      ["adevo mas pox"] =           { name="Poison Bomb Rune",          isPremium="1", price=1000, level=25, mlevel=0, clevel=0, dlevel=0 }, 
      ["utani tempo hur"] =         { name="Charge",                    isPremium="1", price=1300, level=25, mlevel=0, clevel=0, dlevel=0 }, 
      ["utori flam"] =              { name="Ignite",                    isPremium="1", price=1500, level=26, mlevel=0, clevel=0, dlevel=0 }, 
      ["utevo vis lux"] =           { name="Ultimate Light",            isPremium="1", price=1600, level=26, mlevel=0, clevel=0, dlevel=0 }, 
      ["exana ina"] =               { name="Cancel Invisibility",       isPremium="1", price=1600, level=26, mlevel=0, clevel=0, dlevel=0 }, 
      ["adana mort"] =              { name="Animate Dead Rune",         isPremium="1", price=1200, level=27, mlevel=0, clevel=0, dlevel=0 }, 
      ["adori san"] =               { name="Holy Missile Rune",         isPremium="1", price=1600, level=27, mlevel=0, clevel=0, dlevel=0 }, 
      ["adori flam"] =              { name="Fireball Rune",             isPremium="1", price=1600, level=27, mlevel=0, clevel=0, dlevel=0 }, 
      ["adevo res flam"] =          { name="Soulfire Rune",             isPremium="1", price=1800, level=27, mlevel=0, clevel=0, dlevel=0 }, 
      ["adevo grav vita"] =         { name="Wild Growth Rune",          isPremium="1", price=2000, level=27, mlevel=0, clevel=0, dlevel=0 }, 
      ["adori mas tera"] =          { name="Stone Shower Rune",         isPremium="1", price=1100, level=28, mlevel=0, clevel=0, dlevel=0 }, 
      ["adori mas vis"] =           { name="Thunderstorm Rune",         isPremium="1", price=1100, level=28, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori hur"] =               { name="Whirlwind Throw",           isPremium="1", price=1500, level=28, mlevel=0, clevel=0, dlevel=0 }, 
      ["adori frigo"] =             { name="Icicle Rune",               isPremium="1", price=1700, level=28, mlevel=0, clevel=0, dlevel=0 }, 
      ["exana flam"] =              { name="Cure Burning",              isPremium="1", price=2000, level=30, mlevel=0, clevel=0, dlevel=0 }, 
      ["adevo grav tera"] =         { name="Magic Wall Rune",           isPremium="1", price=2100, level=32, mlevel=0, clevel=0, dlevel=0 }, 
      ["utamo mas sio"] =           { name="Protect Party",             isPremium="1", price=4000, level=32, mlevel=0, clevel=0, dlevel=0 }, 
      ["utito mas sio"] =           { name="Train Party",               isPremium="1", price=4000, level=32, mlevel=0, clevel=0, dlevel=0 }, 
      ["utori mas sio"] =           { name="Enchant Party",             isPremium="1", price=4000, level=32, mlevel=0, clevel=0, dlevel=0 }, 
      ["utura mas sio"] =           { name="Heal Party",                isPremium="1", price=4000, level=32, mlevel=0, clevel=0, dlevel=0 }, 
      ["exevo con grav"] =          { name="Conjure Piercing Bolt",     isPremium="1", price=1000, level=33, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori mas"] =               { name="Groundshaker",              isPremium="1", price=1500, level=33, mlevel=0, clevel=0, dlevel=0 }, 
      ["utori vis"] =               { name="Electrify",                 isPremium="1", price=2500, level=34, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori"] =                   { name="Berserk",                   isPremium="1", price=2500, level=35, mlevel=0, clevel=0, dlevel=0 }, 
      ["adevo mas vis"] =           { name="Energy Bomb Rune",          isPremium="1", price=2300, level=37, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori san"] =               { name="Divine Missile",            isPremium="1", price=1800, level=40, mlevel=0, clevel=0, dlevel=0 }, 
      ["utori kor"] =               { name="Inflict Wound",             isPremium="1", price=2500, level=40, mlevel=0, clevel=0, dlevel=0 }, 
      ["exevo gran frigo hur"] =    { name="Strong Ice Wave",           isPremium="1", price=7500, level=40, mlevel=0, clevel=0, dlevel=0 }, 
      ["exeta vis"] =               { name="Enchant Staff",             isPremium="1", price=2000, level=41, mlevel=0, clevel=0, dlevel=0 }, 
      ["exeta con"] =               { name="Enchant Spear",             isPremium="1", price=2000, level=45, mlevel=0, clevel=0, dlevel=0 }, 
      ["exana kor"] =               { name="Cure Bleeding",             isPremium="1", price=2500, level=45, mlevel=0, clevel=0, dlevel=0 }, 
      ["exevo mas san"] =           { name="Divine Caldera",            isPremium="1", price=3000, level=50, mlevel=0, clevel=0, dlevel=0 }, 
      ["utura"] =                   { name="Recovery",                  isPremium="1", price=4000, level=50, mlevel=0, clevel=0, dlevel=0 }, 
      ["utori pox"] =               { name="Envenom",                   isPremium="1", price=6000, level=50, mlevel=0, clevel=0, dlevel=0 }, 
      ["adana ani"] =               { name="Paralyze Rune",             isPremium="1", price=1900, level=54, mlevel=0, clevel=0, dlevel=0 }, 
      ["utamo tempo"] =             { name="Protector",                 isPremium="1", price=6000, level=55, mlevel=0, clevel=0, dlevel=0 }, 
      ["exevo gran mas tera"] =     { name="Wrath of Nature",           isPremium="1", price=6000, level=55, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori amp vis"] =           { name="Lightning",                 isPremium="1", price=5000, level=55, mlevel=0, clevel=0, dlevel=0 }, 
      ["exevo gran mas vis"] =      { name="Rage of the Skies",         isPremium="1", price=6000, level=55, mlevel=0, clevel=0, dlevel=0 }, 
      ["utamo tempo san"] =         { name="Swift Foot",                isPremium="1", price=6000, level=55, mlevel=0, clevel=0, dlevel=0 }, 
      ["exevo con vis"] =           { name="Conjure Power Bolt",        isPremium="1", price=1000, level=59, mlevel=0, clevel=0, dlevel=0 }, 
      ["utito tempo"] =             { name="Blood Rage",                isPremium="1", price=8000, level=60, mlevel=0, clevel=0, dlevel=0 }, 
      ["utito tempo san"] =         { name="Sharpshooter",              isPremium="1", price=8000, level=60, mlevel=0, clevel=0, dlevel=0 }, 
      ["exura gran san"] =          { name="Salvation",                 isPremium="1", price=8000, level=60, mlevel=0, clevel=0, dlevel=0 }, 
      ["exevo gran mas flam"] =     { name="Hell's Core",               isPremium="1", price=8000, level=60, mlevel=0, clevel=0, dlevel=0 }, 
      ["exevo gran mas frigo"] =    { name="Eternal Winter",            isPremium="1", price=8000, level=60, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori gran flam"] =         { name="Strong Flame Strike",       isPremium="1", price=6000, level=70, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori gran tera"] =         { name="Strong Terra Strike",       isPremium="1", price=6000, level=70, mlevel=0, clevel=0, dlevel=0 }, 
      ["utori san"] =               { name="Holy Flash",                isPremium="1", price=7500, level=70, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori min"] =               { name="Front Sweep",               isPremium="1", price=4000, level=70, mlevel=0, clevel=0, dlevel=0 }, 
      ["utori mort"] =              { name="Curse",                     isPremium="1", price=6000, level=75, mlevel=0, clevel=0, dlevel=0 }, 
      ["exana mort"] =              { name="Cure Curse",                isPremium="1", price=6000, level=80, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori gran frigo"] =        { name="Strong Ice Strike",         isPremium="1", price=6000, level=80, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori gran vis"] =          { name="Strong Energy Strike",      isPremium="1", price=7500, level=80, mlevel=0, clevel=0, dlevel=0 }, 
      ["exura gran ico"] =          { name="Intense Wound Cleansing",   isPremium="1", price=6000, level=80, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori gran"] =              { name="Fierce Berserk",            isPremium="1", price=7500, level=90, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori max flam"] =          { name="Ultimate Flame Strike",     isPremium="1", price=15000, level=90, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori max tera"] =          { name="Ultimate Terra Strike",     isPremium="1", price=15000, level=90, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori gran con"] =          { name="Strong Ethereal Spear",     isPremium="1", price=10000, level=90, mlevel=0, clevel=0, dlevel=0 }, 
      ["utura gran"] =              { name="Intense Recovery",          isPremium="1", price=10000, level=100, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori max frigo"] =         { name="Ultimate Ice Strike",       isPremium="1", price=15000, level=100, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori max vis"] =           { name="Ultimate Energy Strike",    isPremium="1", price=15000, level=100, mlevel=0, clevel=0, dlevel=0 }, 
      ["exori gran ico"] =          { name="Annihilation",              isPremium="1", price=20000, level=110, mlevel=0, clevel=0, dlevel=0 }  
    }
  }
}