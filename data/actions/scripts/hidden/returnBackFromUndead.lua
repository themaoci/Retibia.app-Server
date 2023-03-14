local TeleportTo = Position(365, 231, 11)

function onUse(cid, item, frompos, item2, topos)
  local player = Player(cid)
  player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
  player:teleportTo(TeleportTo)
  return 1
end