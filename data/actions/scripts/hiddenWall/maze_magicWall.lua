
-- move that to helpers!!!
function TpToPosIfMeetReq(player, newPos, requirementCallback) 
  if requirementCallback(player) then
    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    player:teleportTo(newPos)
  end
end
function CalculateTpOutPosition(player, item, frompos)
  local actionId = item:getActionId()
  local playerPos = player:getPosition()
  local x = frompos.x
  local y = frompos.y
  if actionId == 6502 then
      y = frompos.y + (frompos.y - playerPos.y)
  else
      x = frompos.x + (frompos.x - playerPos.x)
  end
  return Position(x, y, frompos.z)
end

function requirementsFulfilled(player)
  --swordPos = Position(386, 260, 7)
  -- TODO add more data so if someone already is on the same place with the quest he can also pick the reward
  local swordPos = {x=386, y=260, z=7, stackpos=1}
  local getsword = getThingfromPos(swordPos)
  if getsword.itemid == 2383 then -- spikesword between fire
      return true
  end
  doPlayerSendCancel(player, "This energy wall blocks the way...")
  return false
end
-- 6501 => x
-- 6502 => y
function onUse(cid, item, frompos, item2, topos)
  local player = Player(cid)
  local newPos = CalculateTpOutPosition(player, item, frompos)
  TpToPosIfMeetReq(player, newPos, requirementsFulfilled)
  return 1
end
  