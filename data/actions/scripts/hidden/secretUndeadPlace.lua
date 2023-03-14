local TeleportTo = Position(335, 94, 11)

playerPressedStone = {}
configSecretUndeadPlace = {
  lastKey = 7
}
function onUse(cid, item, frompos, item2, topos)
    local itemActionId = item:getActionId()
    local itemUniqueId = item:getUniqueId()
    local itemCodeId = itemUniqueId - itemActionId
    local player = Player(cid)
    if (playerPressedStone[player:getId()] ~= nil) then
      if playerPressedStone[player:getId()] + 1 == itemCodeId then
        -- we get last stone pressed now teleport
        if configSecretUndeadPlace.lastKey == itemCodeId then 
          player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
          player:teleportTo(TeleportTo)
          TeleportTo:sendMagicEffect(CONST_ME_TELEPORT)
          return true
        end
        -- this one is correct increase by 1
        playerPressedStone[player:getId()] = itemCodeId
        player:getPosition():sendMagicEffect(CONST_ME_ENERGYHIT)
      else
        playerPressedStone[player:getId()] = 0
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
      end
    else
      playerPressedStone[player:getId()] = 1
    end
    return 1
  end