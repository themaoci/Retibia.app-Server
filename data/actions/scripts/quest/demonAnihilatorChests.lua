DAC_Config = {
  rewards = {
    [1] = { name = "Demon Helmet", itemId = 2493},
    [2] = { name = "Demon Armor", itemId = 2494},
    [3] = { name = "Fire Sword", itemId = 2392},
    [4] = { name = "Wand of Everblazing", itemId = 18409},
  },
  ExitPosition = Position(689, 294, 12),
  Storage = {
    EnteredNumber = 7601,
    EnteredInside = 7602,
    Chest_1 = 7611,
    Chest_2 = 7612,
    Chest_3 = 7613,
    Chest_4 = 7614,
  }
}

function onUse(cid, item, frompos, item2, topos)
  local chestId = item.uid
  local reward = DAC_Config.rewards[chestId - 7610]
  if reward ~= nil then
    local enteredNumerTimes = getPlayerStorageValue(cid, DAC_Config.Storage.EnteredNumber)
    if getPlayerStorageValue(cid, DAC_Config.Storage.EnteredInside) == 1 or enteredNumerTimes >= #DAC_Config.rewards then
      doPlayerSendTextMessage(cid,22,"It's empty.")
      return TRUE
    end
    if getPlayerStorageValue(cid,chestId) ~= 1 then
      doPlayerSendTextMessage(cid,22,"You already picked this chest")
      return TRUE
    end
    doPlayerSendTextMessage(cid,22,"You have found a " .. reward.name .. ".")
    doPlayerAddItem(cid, reward.itemId, 1)
    setPlayerStorageValue(cid,DAC_Config.Storage.EnteredNumber, enteredNumerTimes + 1)
    setPlayerStorageValue(cid,chestId,1)
    setPlayerStorageValue(cid,DAC_Config.Storage.EnteredInside,1)
    
    Player(cid):teleportTo(DAC_Config.ExitPosition)
  else
    print("demonAnihilatorChests.lua -> unknown reward for chestId: " .. chestId)
  end
  return 1
end
