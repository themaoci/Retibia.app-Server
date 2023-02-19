function onUse(cid, item, frompos, item2, topos)
    local itemActionId = item:getActionId()
    local itemUniqueId = item:getUniqueId()
    local townCodeId = itemUniqueId - itemActionId
    local player = Player(cid)
    
    if not player then
      return false
    end
    local town = Town(townCodeId)
    if not town then
      return false
    end
    player:setTown(town)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You set " .. town:getName() .. " as your return point.")
    return true
end