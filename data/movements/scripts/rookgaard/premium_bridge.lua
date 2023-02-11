
function DetectDirection(positionStart, positionEnd) 
  local X = positionStart.x - positionEnd.x
  local Y = positionStart.y - positionEnd.y
  return Position(positionEnd.x + (X * 3), positionEnd.y + (Y * 3), positionEnd.z)
end

function onStepIn(cid, item, position, fromPosition)
  local Config = GameConfig['PremiumTile']
	if isPremium(cid) == TRUE and item.actionid == Config.StepInActionId then
    doPlayerSendTextMessage(cid, 22, Config.enterMsg)
    doSendMagicEffect(position, Config.enterEffect)
    return
  end
  local kickPos = DetectDirection(fromPosition, position)
  doTeleportThing(cid, kickPos)
  doSendMagicEffect(Config.kickPos, Config.kickEffect)
  doPlayerSendCancel(cid, Config.kickMsg)
  return true
end
