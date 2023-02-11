

LOCATION_ROOKGARD = {}


LOCATION_ROOKGARD["PremiumTile"] = {}

LOCATION_ROOKGARD["ZeroPosition"] = Position(0,0,0)

LOCATION_ROOKGARD["BearRoomStonePosition"] = Position(430,276,11)
LOCATION_ROOKGARD["BearRoomStoneNewPosition"] = Position(430,278,11)

LOCATION_ROOKGARD["AcademyQuest"] = {
  GatePosition = {x=380, y=348, z=8, stackpos=1},
  LeverLeft = 1945,
  LeverRight = 1946,
  StoneWall = 1050
}

LOCATION_ROOKGARD['MinoMage'] = {
  WallPosition = {x=403, y=234, z=12, stackpos=1},
  ReplacementDoor = 1223,
  ReplacementDoorActionId = 7037,
  LeverLeft = 1945,
  LeverRight = 1946,
  StuckMessage = "The switch seems to be stuck."
}

LOCATION_ROOKGARD['TrainWithMonster'] = {
  Option = {},
  FrameworkWall = 1037,
  LeverLeft = 1945,
  LeverRight = 1946,
  GatePosition = {x=394, y=347, z=8, stackpos=1},
  uID = 15068
}
-- spawnable creature id here
LOCATION_ROOKGARD.TrainWithMonster.Option[3102] = {x=373, y=324, z=10, stackpos=1}
LOCATION_ROOKGARD.TrainWithMonster.Option[3103] = {x=375, y=324, z=10, stackpos=1}
LOCATION_ROOKGARD.TrainWithMonster.Option[3104] = {x=377, y=324, z=10, stackpos=1}
LOCATION_ROOKGARD.TrainWithMonster.Option[3105] = {x=379, y=324, z=10, stackpos=1}

LOCATION_ROOKGARD["BearRoom"] = {
  position = Position(430,276,11),
  newPosition = Position(430,278,11),
  StoneId = 1304,
  LeverId = {
    Left = 1945,
    Right = 1946
  },
}

LOCATION_ROOKGARD["KatanaQuest"] = {
  position = Position(462,323,11),
  LeverId = {
    Left = 1945,
    Right = 1946
  },
  DoorId = {
    Open = 5109,
    Close = 5108
  }
}

-- Bridge on 
LOCATION_ROOKGARD["CaveBridge"] = {
	bridgePositions = {
		{position = Position(384, 380, 8), groundId = 9022, itemId = 4645},
		{position = Position(385, 380, 8), groundId = 4616},
		{position = Position(386, 380, 8), groundId = 9022, itemId = 4647}
	},
	leverPositions = {
		Position(383, 379, 8),
		Position(389, 379, 8)
	},
	relocatePosition = Position(387, 380, 8),
	relocateMonsterPosition = Position(388, 380, 8),
	bridgeId = 5770
}


LOCATION_ROOKGARD['SwordOfFury'] = {
  FirePositions = {
    {x=385, y=259, z=7, stackpos=254},
    {x=386, y=259, z=7, stackpos=254},
    {x=387, y=259, z=7, stackpos=254},
    {x=385, y=260, z=7, stackpos=254},
    {x=387, y=260, z=7, stackpos=254},
    {x=385, y=261, z=7, stackpos=254},
    {x=386, y=261, z=7, stackpos=254},
    {x=387, y=261, z=7, stackpos=254}
  },
  FireReplacement = 1494,
  SwordPosition = {x=386, y=260, z=7, stackpos=2},
  NewSwordPosition = {x=277, y=402, z=12},
  MonsterSpawnPosition = {x=277, y=403, z=12},
  MonsterSpawnName = "Minotaur Mage"
}


LOCATION_ROOKGARD["Items"] = {}
LOCATION_ROOKGARD.Items["purplekey"] = 2086
LOCATION_ROOKGARD.Items["woodenkey"] = 2087
LOCATION_ROOKGARD.Items["silverkey"] = 2088
LOCATION_ROOKGARD.Items["copperkey"] = 2089
LOCATION_ROOKGARD.Items["crystalkey"] = 2090
LOCATION_ROOKGARD.Items["goldenkey"] = 2091
LOCATION_ROOKGARD.Items["bonekey"] = 2092

------ QUEST ITEMS FOUND ON ROOKGAARD ------
LOCATION_ROOKGARD["ItemAction"] = {}
LOCATION_ROOKGARD["ItemAction"]["7006"] = {
-- Ambers Notebook --
  reqCap = 10,
  sendTextMessage = "You have found a book.",
  itemsToAdd = {
    { id = 1955, amount = 1, specialDescription = "Hardek *\nBozo *\nSam ****\nOswald\nPartos ***\nQuentin *\nTark ***\nHarsky ***\nStutch *\nFerumbras *\nFrodo **\nNoodles ****" }
  },
  storageValue = 7006,
  alreadyPickedUp = "it's empty."
}
LOCATION_ROOKGARD["ItemAction"]["7008"] = {
-- Letter + Salmon --
  reqCap = 7,
  sendTextMessage = "You have found a letter and some salmon.",
  itemsToAdd = {
    { id = 2597, amount = 1, specialDescription = "" },
    { id = 2668, amount = 2, specialDescription = "" }
  },
  storageValue = 7008,
  alreadyPickedUp = "it's empty."
}
LOCATION_ROOKGARD["ItemAction"]["7009"] = {
-- Bear Room Key --
  reqCap = 7,
  sendTextMessage = "You have found a key.",
  itemsToAdd = {
    { id = 2089, amount = 1, specialDescription = "(Key: 4601)", actionId = 2004 }
  },
  storageValue = 7009,
  alreadyPickedUp = "it's empty."
}
LOCATION_ROOKGARD["ItemAction"]["7010"] = {
-- Bear Room Chain Armor --
  reqCap = 100,
  sendTextMessage = "You have found a chain armor.",
  itemsToAdd = {
    { id = 2464, amount = 1, specialDescription = "" }
  },
  storageValue = 7010,
  alreadyPickedUp = "it's empty."
}
LOCATION_ROOKGARD["ItemAction"]["7011"] = {
-- Bear Room Brass Helmet --
  reqCap = 27,
  sendTextMessage = "You have found a brass helmet.",
  itemsToAdd = {
    { id = 2460, amount = 1, specialDescription = "" }
  },
  storageValue = 7011,
  alreadyPickedUp = "it's empty."
}
LOCATION_ROOKGARD["ItemAction"]["7012"] = {
-- Bear Room Bag --
  reqCap = 27,
  sendTextMessage = "You have found a letter and some salmon.",
  itemsToAdd = {
    { id = 2544, amount = 12, specialDescription = "" },
    { id = cfcoppercoin, amount = 40, specialDescription = "" }
  },
  containerId = 1987, --if ~= nil then add items in container
  storageValue = 7012,
  alreadyPickedUp = "it's empty."
}
LOCATION_ROOKGARD["ItemAction"]["7013"] = {
-- Combat Knife --
  reqCap = 9,
  sendTextMessage = "You have found a combat knife.",
  itemsToAdd = {
    { id = 2404, amount = 1, specialDescription = "" }
  },
  storageValue = 7013,
  alreadyPickedUp = "it's empty."
}
LOCATION_ROOKGARD["ItemAction"]["7014"] = {
-- Doublet --
  reqCap = 25,
  sendTextMessage = "You have found a doublet.",
  itemsToAdd = {
    { id = 2485, amount = 1, specialDescription = "" }
  },
  storageValue = 7014,
  alreadyPickedUp = "The loose board is empty."
}
LOCATION_ROOKGARD["ItemAction"]["7015"] = {
-- Dragon corpse --
  reqCap = 102,
  sendTextMessage = "You have found a bag.",
  itemsToAdd = {
    { id = 2480, amount = 1, specialDescription = "" },
    { id = 2530, amount = 1, specialDescription = "" }
  },
  containerId = 1987,
  storageValue = 7015,
  alreadyPickedUp = "it's empty."
}
LOCATION_ROOKGARD["ItemAction"]["7016"] = {
-- Goblin Temple --
  reqCap = 32,
  sendTextMessage = "You have found a bag.",
  itemsToAdd = {
    { id = 2563, amount = 1, specialDescription = "" },
    { id = 1294, amount = 5, specialDescription = "" },
    { id = cfcoppercoin, amount = 50, specialDescription = "" }
  },
  containerId = 1987,
  storageValue = 7016,
  alreadyPickedUp = "it's empty."
}
LOCATION_ROOKGARD["ItemAction"]["7017"] = {
-- Goblin Temple --
  reqCap = 21,
  sendTextMessage = "You have found a bag.",
  itemsToAdd = {
    { id = 2006, amount = 6, specialDescription = "" },
    { id = 2111, amount = 4, specialDescription = "" },
    { id = 2642, amount = 1, specialDescription = "" }
  },
  containerId = 1987,
  storageValue = 7017,
  alreadyPickedUp = "it's empty."
}
LOCATION_ROOKGARD["ItemAction"]["7018"] = {
-- Katana Key --
  reqCap = 1,
  sendTextMessage = "You have found a key.",
  itemsToAdd = {
    { id = 2088, amount = 1, specialDescription = "(Key: 4603)", actionId = 2007 }
  },
  storageValue = 7018,
  alreadyPickedUp = "it's empty."
}
LOCATION_ROOKGARD["ItemAction"]["7019"] = {
-- Katana --
  reqCap = 31,
  sendTextMessage = "You have found a katana.",
  itemsToAdd = {
    { id = 2412, amount = 1, specialDescription = "" }
  },
  storageValue = 7019,
  alreadyPickedUp = "it's empty."
}
LOCATION_ROOKGARD["ItemAction"]["7020"] = {
-- Carlin Sword --
  reqCap = 40,
  sendTextMessage = "You have found a carlin sword.",
  itemsToAdd = {
    { id = 2395, amount = 1, specialDescription = "" }
  },
  storageValue = 7020,
  alreadyPickedUp = "it's empty."
}
LOCATION_ROOKGARD["ItemAction"]["7021"] = {
-- Carlin Sword (Fishing Rod) --
  reqCap = 9,
  sendTextMessage = "You have found a fishing rod.",
  itemsToAdd = {
    { id = 2580, amount = 1, specialDescription = "" }
  },
  storageValue = 7021,
  alreadyPickedUp = "it's empty."
}
LOCATION_ROOKGARD["ItemAction"]["7022"] = {
-- Carlin Sword (Bag) --
  reqCap = 19,
  sendTextMessage = "You have found a bag.",
  itemsToAdd = {
    { id = 2545, amount = 4, specialDescription = "" },
    { id = 2544, amount = 10, specialDescription = "" }
  },
  containerId = 1987,
  storageValue = 7022,
  alreadyPickedUp = "it's empty."
}
LOCATION_ROOKGARD["ItemAction"]["7023"] = {
-- Rapier --
  reqCap = 15,
  sendTextMessage = "You have found a rapier.",
  itemsToAdd = {
    { id = 2384, amount = 1, specialDescription = "" }
  },
  storageValue = 7023,
  alreadyPickedUp = "it's empty."
}
LOCATION_ROOKGARD["ItemAction"]["7024"] = {
-- Torch --
  reqCap = 5,
  sendTextMessage = "You have found a torch.",
  itemsToAdd = {
    { id = 2050, amount = 1, specialDescription = "" }
  },
  storageValue = 7024,
  alreadyPickedUp = "it's empty."
}
LOCATION_ROOKGARD["ItemAction"]["7025"] = {
  reqCap = 35,
  sendTextMessage = "You have found a backpack.",
  itemsToAdd = {
    { id = 2013, amount = 1, specialDescription = "" },
    { id = 2035, amount = 1, specialDescription = "" },
    { id = 2014, amount = 1, specialDescription = "" },
    { id = 1990, amount = 1, specialDescription = "" }
  },
  containerId = 1988,
  storageValue = 7025,
  alreadyPickedUp = "it's empty."
}
LOCATION_ROOKGARD["ItemAction"]["7026"] = {
-- Small Axe --
  reqCap = 20,
  sendTextMessage = "You have found a small axe.",
  itemsToAdd = {
    { id = 2559, amount = 1, specialDescription = "" }
  },
  storageValue = 7026,
  alreadyPickedUp = "it's empty."
}
LOCATION_ROOKGARD["ItemAction"]["7027"] = {
-- Viking helmet --
  reqCap = 39,
  sendTextMessage = "You have found a Viking Helmet.",
  itemsToAdd = {
    { id = 2473, amount = 1, specialDescription = "" }
  },
  storageValue = 7027,
  alreadyPickedUp = "it's empty."
}
  
LOCATION_ROOKGARD["ItemAction"]["7031"] = {
-- Banana Palm --
  reqCap = 2,
  sendTextMessage = "You have found a banana.",
  itemsToAdd = {
    { id = 2597, amount = 1, specialDescription = "" }
  },
  storageValue = 7031,
  alreadyPickedUp = "it's empty."
}
------ QUEST ITEMS FOUND ON ROOKGAARD ------
