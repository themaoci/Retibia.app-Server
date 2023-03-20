GameConfig = {
  ['RookgaardHints'] = 1500,
  ['TravellingTrader'] = {
    ['Mission01'] = 2001,
    ['Mission02'] = 2002,
    ['Mission03'] = 2003,
    ['Mission04'] = 2004,
    ['Mission05'] = 2005,
    ['Mission06'] = 2006,
    ['Mission06'] = 2007, -- recognized trader
  },
  ['AdventurersGuild'] = {
    ['FreeStone'] = {
      ['Brewster'] = 2101,
    }
  },
  ['EnableDevTestingChest'] = true,
  ['BlockTrashingTeleports'] = true,
  ['FlyingShip'] = {
    ['rookgaard'] = Position(339, 390, 4),
    ['cormaya'] = Position(749, 440, 5),
  },
  ['Waypoint'] = {
    ['Config'] = {
      ['ObjectActionId'] = 60800,
      ['PlayerStorageValue'] = 60800,
      ['TeleportEffectOut'] = CONST_ME_TELEPORT,
      ['TeleportEffectIn'] = CONST_ME_TELEPORT,
      ['EnableSavingWaypoints'] = false,
    },
    ['Locations'] = {
      [0] = { pos = Position(380, 358, 8),   Name = "Rookgaard Refugee Town" },
      [1] = { pos = Position(657, 240, 11),  Name = "Dragon Nest Ruins" },
      [2] = { pos = Position(658, 103, 13),  Name = "Elder Dragon Hideout" },
      [3] = { pos = Position(235, 669, 8),   Name = "Mages Outpost" },
      [4] = { pos = Position(681, 285, 2),   Name = "Desert Tower Outpost" }
    }
  },
  ['StaminaRegen'] = { 
    ['free'] = 180, 
    ['premium'] = 600 
  },
  ['Outfits'] = nil, -- auto loaded by server
  ['Mounts'] = nil, -- auto loaded by server
  ['Spells'] = {
    ['Instant'] = nil, -- auto loaded by server
    ['Rune'] = nil -- auto loaded by server
  },
  ['sharedExpPercentage'] = { 
    ['above2400'] = 1.5, 
    ['below840'] = 0.5 
  },
  ['autoGhostStaffMembers'] = true,
  ["God"] = {
    ['WelcomeMessageEnabled'] = false,
    ['WelcomeMessageCommands'] = "-- COMMANDS --\n/cmd -> to get all commands-- COMMANDS --\n"
  }, 
  ["Tutor"] = {
    ['WelcomeMessageEnabled'] = false,
    ['WelcomeMessageRules'] = "Tutor Rules\n1 *> 3 Warnings you lose the job.\n2 *> Without parallel conversations with players in Help, if the player starts offending, you simply mute it.\n3 *> Be educated with the players in Help and especially in the Private, try to help as much as possible.\n4 *> Always be on time, if you do not have a justification you will be removed from the staff.\n5 *> Help is only allowed to ask questions related to tibia.\n6 *> It is not allowed to divulge time up or to help in quest.\n7 *> You are not allowed to sell items in the Help.\n8 *> If the player encounters a bug, ask to go to the website to send a ticket and explain in detail.\n9 *> Always keep the Tutors Chat open. (required).\n10 *> You have finished your schedule, you have no tutor online, you communicate with some CM in-game or ts and stay in the help until someone logs in, if you can.\n11 *> Always keep a good Portuguese in the Help, we want tutors who support, not that they speak a satanic ritual.\n12 *> If you see a tutor doing something that violates the rules, take a print and send it to your superiors.\n\n- Commands -\nMute Player: /mute nick, 90. (90 seconds)\nUnmute Player: /unmute nick.\n- Commands -"
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
  }
}