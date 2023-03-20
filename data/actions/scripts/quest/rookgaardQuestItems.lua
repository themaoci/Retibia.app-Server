--999-- Storage is taken (used to free wand/rod in magic shop)

--7000 - 7999 is reserved storage ids for Rook quests only--

-- 
-- 7035 -- Movement tile for Spike sword (Poison spider cave) [MOVEMENT STEP IN ON TILE]
-- 7036 -- Movement tile for Spike sword (Rotworm cave) [MOVEMENT STEP IN ON TILE]




RookGaardQuestItems_Config = {
  	scriptStartUID = 7000,
	reward = {
    -- 1 -- Semour Exchange quest, Present and gain legion helmet.
    -- 2 -- Willie Exchange quest, Banana and gain studded shield.
    -- 3 -- Billy Exchange quest, Pan and gain antidote rune.
    -- 4 -- Lee'Delle Exchange quest, Honey Flower and Studded legs.
    -- 5 -- Al Dee Exchange quest, Small axe and gain pick.
    -- 7 -- Amber Exchange quest, Ambers Notebook and gain short sword.
		[10] = { -- hydras egg (in jungle area)
			name = "hydras egg", 
			items = {
				[1] = { id = 4850, count = 1 }
			}
		},
		[14] = { -- Doublet -- under the floor
			name = "doublet", 
			items = {
				[1] = { id = 2485, count = 1, capReq = 25 }
			}
		},
		[26] = {  -- Small Axe -- in the coffin
			name = "small axe", 
			items = {
				[1] = { id = 2559, count = 1, capReq = 15 }
			}
		},
    -- 27 -- Benny Carter quest, help him deal with few missions. [TO REWORK]
    -- 28 -- Benny Carter quest, Kill rats storage. [TO REWORK]
    -- 29 -- Benny Carter quest, Kill spiders storage. [TO REWORK]
    -- 30 -- Benny Carter quest, Kill Aaron. [TO REWORK]
		[31] = {  -- Banana Palm --
			name = "banana", 
			items = {
				[1] = { id = 2676, count = 1, capReq = 2 }
			}
		},
    -- 32 -- Benny Carter quest, Vocation quest. [TO REWORK]
    -- 33 -- Benny Carter quest, Minotaur mage switch quest. [TO REWORK]
    -- 34 -- Golden Key Quest. [TO REWORK]
    -- 37 -- Access to the door above Tom's shop [TO REWORK]
    -- 41 -- Spike sword storage for web (given in last door) [TO REWORK]
  },
	rewardKey = {
		[9] = { -- Bear Room Key -- [UNABLE TO CONVERT - REQUIRE TEXT FIELD]
			name = "bear room key", 
			keyId = 2089, 
			actionId = 2004, 
			description = "(Key: 4601)",
			requiredToMeet = {} 
		},
		[18] = {  -- Katana key --
			name = "key", 
			keyId = 2088, 
			actionId = 2007, 
			description = "(Key: 4603)",
			requiredToMeet = {} 
		},
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
          doPlayerSendTextMessage(cid,MESSAGE_LOOT,"You need " .. item.capReq * item.count .. " cap free or more to loot this!")
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
      doPlayerSendTextMessage(cid,MESSAGE_LOOT,"You have found a " .. reward.name .. ".")
      -- lock second pickup now
			setPlayerStorageValue(cid,item.uid,1)
		else
		  doPlayerSendTextMessage(cid,MESSAGE_LOOT,"It's empty.")
		end
    return 1
	end

  -- Keys below
	local rewardKey = RookGaardQuestItems_Config.rewardKey[item.uid - RookGaardQuestItems_Config.scriptStartUID]
	if rewardKey ~= nil then
		if getPlayerStorageValue(cid,item.uid) <= 0 then
			for _, requirement in pairs(rewardKey.requiredToMeet) do
				if getPlayerStorageValue(cid,requirement.StorageId) ~= 1 then
					doPlayerSendTextMessage(cid,MESSAGE_LOOT, requirement.wrongText)
					return 1
				end		
			end
      if getPlayerFreeCap(cid) <= rewardKey.capReq then
        doPlayerSendTextMessage(cid,MESSAGE_LOOT,"You need " .. rewardKey.capReq .. " cap or more to loot this!")
        return 1
      end
      doPlayerSendTextMessage(cid,MESSAGE_LOOT,"You have found a " .. rewardKey.name .. ".")
      local keySpawned = doPlayerAddItem(cid, rewardKey.keyId, 1)
      doSetItemActionId(keySpawned, rewardKey.actionId)
      doSetItemSpecialDescription(keySpawned, rewardKey.description)	
      setPlayerStorageValue(cid, item.uid, 1)
		else
			doPlayerSendTextMessage(cid,MESSAGE_LOOT,"it's empty.")
		end
    return 1
	end
  return 0
end
