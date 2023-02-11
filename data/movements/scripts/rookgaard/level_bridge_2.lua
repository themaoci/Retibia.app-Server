local Config_LevelTile = GameConfig['LevelTile']

function onStepIn(cid, item, pos, topos)
  if isPlayer(cid) == TRUE and item.itemid == Config_LevelTile.TileStepOut then
    local levelRequirement = item.uniqueid
    if getPlayerLevel(cid) >= levelRequirement then
      doTransformItem(item.uid, Config_LevelTile.TileStepIn)
    else
      position = getPlayerPosition(cid)
      local X = pos.x - topos.x
      local Y = pos.y - topos.y
      newposition = {x = position.x - (X * 2), y = position.y - (Y * 2), z = position.z}
      doPlayerSendTextMessage(cid,22,string.format(Config_LevelTile.kickMsg, levelRequirement))
      doTeleportThing(cid, newposition)
      doSendMagicEffect(newposition, 13)
    end
  end
end

function onStepOut(cid, item, pos, topos)
  if isPlayer(cid) == TRUE and item.itemid == Config_LevelTile.TileStepIn then
    doTransformItem(item.uid, Config_LevelTile.TileStepOut)
  end
end
