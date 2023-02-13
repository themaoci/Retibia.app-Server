--999-- Storage is taken (used to free wand/rod in magic shop)

--7000 - 7999 is reserved storage ids for Rook quests only--

RookGaardQuestItems_Config = {
  scriptStartUID = 7000,
	reward = {
    -- 1 -- Semour Exchange quest, Present and gain legion helmet.
    -- 2 -- Willie Exchange quest, Banana and gain studded shield.
    -- 3 -- Billy Exchange quest, Pan and gain antidote rune.
    -- 4 -- Lee'Delle Exchange quest, Honey Flower and Studded legs.
    -- 5 -- Al Dee Exchange quest, Small axe and gain pick.
		[6] = { --ambers notebook--
			name = "ambers notebook", 
			items = {
				[1] = { id = 1955, count = 1, capReq = 10, text = "Hardek *\nBozo *\nSam ****\nOswald\nPartos ***\nQuentin *\nTark ***\nHarsky ***\nStutch *\nFerumbras *\nFrodo **\nNoodles ****"}
			}
		},
    -- 7 -- Amber Exchange quest, Ambers Notebook and gain short sword.
		[8] = { -- Letter + Salmon --
			name = "letter and some salmon", 
			items = {
				[1] = { id = 2597, count = 1, text = "", capReq = 1},
				[2] = { id = 2668, count = 2, capReq = 3}
			}
		},
		[9] = { -- Bear Room Key -- 
			name = "bear room key", 
			items = {
				[1] = { id = 2089, count = 1, actionId = 2004, description = "(Key: 4601)"}
			}
		},
		[10] = { -- Bear Room Chain Armor -- 
			name = "Chain Armor", 
			items = {
				[1] = { id = 2464, count = 1, capReq = 100 }
			}
		},
		[11] = { -- Bear Room Brass Helmet -- 
			name = "Brass Helmet",
			items = {
				[1] = { id = 2460, count = 1, capReq = 27 }
			}
		},
		[12] = { -- Bear Room Bag -- 
			name = "bag", 
			wrapInBag = 1987,
			items = {
				[1] = { id = 2668, count = 12, capReq = 4 },
				[2] = { id = 2148, count = 40, capReq = 1 }
			}
		},
		[13] = { -- Combat Knife -- 
			name = "combat knife", 
			items = {
				[1] = { id = 2404, count = 1, capReq = 9 }
			}
		},
		[14] = { -- Doublet -- 
			name = "doublet", 
			items = {
				[1] = { id = 2485, count = 1, capReq = 25 }
			}
		},
		[15] = { -- Dragon corpse -- 
			name = "bag", 
			wrapInBag = 1987,
			items = {
				[1] = { id = 2480, count = 1, capReq = 31 },
				[2] = { id = 2530, count = 1, capReq = 63 }
			}
		},
		[16] = { -- Goblin Temple left chest --
			name = "bag", 
			wrapInBag = 1987,
			items = {
				[1] = { id = 2563, count = 1, capReq = 18 }, -- pan
				[2] = { id = 1294, count = 5, capReq = 3.6 }, -- small stone
				[3] = { id = 2148, count = 50, capReq = 0.1 } -- gold coin
			}
		},
		[17] = {  -- Goblin Temple right chest --
			name = "bag", 
			wrapInBag = 1987,
			items = {
				[1] = { id = 2006, count = 6, capReq = 1.8 }, -- vial
				[2] = { id = 2111, count = 4, capReq = 0.8 }, -- snowball
				[3] = { id = 2642, count = 1, capReq = 0.6 } -- sandals
			}
		},
		[18] = {  -- Katana key --
			name = "key", 
			items = {
				[1] = { id = 2088, count = 1, capReq = 1, actionId = 2007, description = "(Key: 4603)" }
			}
		},
		[19] = {  -- Katana --
			name = "katana", 
			items = {
				[1] = { id = 2412, count = 1, capReq = 31 }
			}
		},
		[20] = {  -- carlin sword --
			name = "carlin sword", 
			items = {
				[1] = { id = 2395, count = 1, capReq = 40 }
			}
		},
		[21] = {  -- carlin sword - fishing rod --
			name = "fishing rod", 
			items = {
				[1] = { id = 2580, count = 1, capReq = 9 }
			}
		},
		[22] = {  -- carlin sword - bag or arrows --
			name = "bag", 
			wrapInBag = 1987,
			items = {
				[1] = { id = 2545, count = 40, capReq = 0.8 },
				[2] = { id = 2544, count = 40, capReq = 0.7 }
			}
		},
		[23] = {  -- Rapier --
			name = "rapier", 
			items = {
				[1] = { id = 2384, count = 1, capReq = 15 }
			}
		},
		[24] = {  -- Torch -- use it later for starting gear for players quest
			name = "bag", 
			wrapInBag = 1987,
			items = {
				[1] = { id = 2050, count = 1, capReq = 5 } -- torch
			}
		},
		[25] = {  -- Present --
			name = "bag", 
			wrapInBag = 1988,
			items = {
				[1] = { id = 2013, count = 1, capReq = 2 },
				[2] = { id = 2035, count = 1, capReq = 1.5 },
				[3] = { id = 2014, count = 1, capReq = 7.5 },
				[4] = { id = 1990, count = 1, capReq = 6 }, -- present
			}
		},
		[26] = {  -- Small Axe --
			name = "small axe", 
			items = {
				[1] = { id = 2559, count = 1, capReq = 15 }
			}
		},
    -- 27 -- Benny Carter quest, help him deal with few missions.
    -- 28 -- Benny Carter quest, Kill rats storage.
    -- 29 -- Benny Carter quest, Kill spiders storage.
    -- 30 -- Benny Carter quest, Kill Aaron.
		[31] = {  -- Banana Palm --
			name = "banana", 
			items = {
				[1] = { id = 2676, count = 1, capReq = 2 }
			}
		},
    -- 32 -- Benny Carter quest, Vocation quest.
    -- 33 -- Benny Carter quest, Minotaur mage switch quest.
    -- 34 -- Golden Key Quest.
    -- 35 -- Movement tile for Spike sword (Poison spider cave)
    -- 36 -- Movement tile for Spike sword (Rotworm cave)
    -- 37 -- Access to the door above Tom's shop
		[42] = {  -- Viking Helmet --
			name = "viking helmet", 
			items = {
				[1] = { id = 2473, count = 1, capReq = 39 }
			}
		},
    -- 41 -- Spike sword storage for web (given in last door)
		[50] = {  -- Reward after mino mage room --
			name = "platinum coins", 
			items = {
				[1] = { id = 2152, count = 40, capReq = 0.1 }
			}
		},
  },
	rewardKey = {
		[38] = { -- Key 0013 (Open's the mino mage door) - kamien tam gdize jest minotaur archer
			name = "golden key", 
			keyId = 2091, 
			actionId = 2043, 
			description = "(Key: 0013)", 
			capReq = 1,
			requiredToMeet = {
				[1] = { StorageId = 7037, wrongText = "Something is weird about this stone." }
			} 
		},
		[39] = { -- Key 0015 (Opens Toms bedroom) - cialo human tam gdize sa miski NW od miasta
			name = "copper key", 
			keyId = 2089, 
			actionId = 2045, 
			description = "(Key: 0015)", 
			capReq = 1,
			requiredToMeet = {
				[1] = { StorageId = 7037, wrongText = "Something is weird about this corpse." }
			} 
		},
		[40] = { -- Key 0011 (Opens Gobblin switch rooms) - 
			name = "copper key", 
			keyId = 2089, 
			actionId = 2046, 
			description = "(Key: 0011)", 
			capReq = 1,
			requiredToMeet = {
			} 
		},
	}
}

function onUse(cid, item, frompos, item2, topos)
	local reward = RookGaardQuestItems_Config.reward[item.uid - RookGaardQuestItems_Config.scriptStartUID]
	if reward ~= nil then
		if getPlayerStorageValue(cid,item.uid) <= 0 then
      local backpack = nil
      if reward.wrapInBag ~= nil then
        backpack = doPlayerAddItem(cid, reward.wrapInBag, 1)  
      end
      for _, item in pairs(reward.items) do
        -- check if item can be picked up
        if getPlayerFreeCap(cid) <= item.capReq * item.count then
          -- display information that it cannot pickup and you are missing cap
          doPlayerSendTextMessage(cid,22,"You need " .. item.capReq * item.count .. " cap free or more to loot this!")
          return 1
        end
        local createdItem = nil
        if backpack ~= nil then
          -- option wrapinbag is present and backpack was created so we gonna add item with count to the backpack
          createdItem = doAddContainerItem(backpack, item.id, item.count)
        else
          -- add item to player with amount from config
          createdItem = doPlayerAddItem(cid, item.id, item.count) 
        end
        if createdItem ~= nil then
          -- set custom text of item if present in config (should work only for items that are writable)
          if item.text ~= nil then
            doSetItemText(createdItem, item.text)
          end
          -- set actionid of the item if present in config
          if item.actionId ~= nil then
            doSetItemActionId(createdItem, tonumber(item.actionId))
          end
          -- set description of the item if present in config
          if item.description ~= nil then
            doSetItemSpecialDescription(createdItem, item.description)
          end           
        end
      end
      -- display information to the player
      doPlayerSendTextMessage(cid,22,"You have found a " .. reward.name .. ".")
      -- lock second pickup now
			setPlayerStorageValue(cid,item.uid,1)
		else
		  doPlayerSendTextMessage(cid,22,"It's empty.")
		end
    return 1
	end

  -- Keys below
	local rewardKey = RookGaardQuestItems_Config.rewardKey[item.uid - RookGaardQuestItems_Config.scriptStartUID]
	if rewardKey ~= nil then
		if getPlayerStorageValue(cid,item.uid) <= 0 then
			for _, requirement in pairs(rewardKey.requiredToMeet) do
				if getPlayerStorageValue(cid,requirement.StorageId) ~= 1 then
					doPlayerSendTextMessage(cid,22, requirement.wrongText)
					return 1
				end		
			end
      if getPlayerFreeCap(cid) <= rewardKey.capReq then
        doPlayerSendTextMessage(cid,22,"You need " .. rewardKey.capReq .. " cap or more to loot this!")
        return 1
      end
      doPlayerSendTextMessage(cid,22,"You have found a " .. rewardKey.name .. ".")
      local keySpawned = doPlayerAddItem(cid, rewardKey.keyId, 1)
      doSetItemActionId(keySpawned, rewardKey.actionId)
      doSetItemSpecialDescription(keySpawned, rewardKey.description)	
      setPlayerStorageValue(cid, item.uid, 1)
		else
			doPlayerSendTextMessage(cid,22,"it's empty.")
		end
    return 1
	end
  return 0
end
