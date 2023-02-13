QuestItems_Config = {
  rewards = {
      [1] = { name = "Protection Amulet", itemId = 2200, charges = 250},
      [2] = { name = "Stealth Ring", itemId = 2165},
  },
}
  
function onUse(cid, item, frompos, item2, topos)
  local rewardId = item.uid
  local reward = QuestItems_Config.rewards[rewardId - 8000]
  if reward ~= nil then
    if getPlayerStorageValue(cid,rewardId) ~= 1 then
      doPlayerSendTextMessage(cid,22,"It's empty")
      return TRUE
    end
    local text = "You have found a " .. reward.name .. "."
    local itemAdded = doPlayerAddItem(cid, reward.itemId, 1)
    if reward.charges ~= nil then
      if itemAdded:hasAttribute(ITEM_ATTRIBUTE_CHARGES) then
          itemAdded:setAttribute(ITEM_ATTRIBUTE_CHARGES, reward.charges)
          text = text .. " With " .. reward.charges .. " charges."
      end
    end
    doPlayerSendTextMessage(cid,22, text)
    setPlayerStorageValue(cid,rewardId,1)
  else
    print("newQuestItems_1.lua -> unknown reward for Id: " .. rewardId)
  end
  return 1
end
  