local gwp_wallpos = {x=455, y=321, z=11}
local gwp_wallRightpos = {x=456, y=321, z=11}
local gwp_wallLeftpos = {x=454, y=321, z=11}
function onUse(cid, item, frompos, item2, topos)
 
  if getPlayerStorageValue(cid, 7019) == 1 and getPlayerStorageValue(cid, 7038) == 1 then 
    local player = Player(cid)
    local playerPos = player:getPosition()

    if playerPos.x == gwp_wallRightpos.x and playerPos.y == gwp_wallRightpos.y then
      playerPos.x = gwp_wallLeftpos.x
      player:teleportTo(playerPos)
      return 1
    end
    if playerPos.x == gwp_wallLeftpos.x and playerPos.y == gwp_wallLeftpos.y then
      playerPos.x = gwp_wallRightpos.x
      player:teleportTo(playerPos)
      return 1
    end
    return 1
  end
  doPlayerSendCancel(cid, "Seems like this wall is different from the others...")
  return 1
end
  