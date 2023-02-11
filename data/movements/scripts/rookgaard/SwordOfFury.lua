function onStepIn(cid, item, pos, topos)
  if isPlayer(cid) == TRUE and item.actionid == 7000 then
    if item.uid == 7035 then
      if getPlayerStorageValue(cid, 7035) <= 0 then
        setPlayerStorageValue(cid, 7035, 1)
        doSendMagicEffect(getPlayerPosition(cid), 13)
        SwordofFuryDisappear(cid)
      elseif getPlayerStorageValue(cid, 7035) <= 1 then
        SwordofFuryDisappear(cid)
      end
    elseif item.uid == 7036 then
      if getPlayerStorageValue(cid, 7036) <= 0 then
        setPlayerStorageValue(cid, 7036, 1)
        doSendMagicEffect(getPlayerPosition(cid), 13)
        SwordofFuryDisappear(cid)
      elseif getPlayerStorageValue(cid, 7036) <= 1 then
        SwordofFuryDisappear(cid)
      end
    end
  end
end

function SwordofFuryDisappear(cid)
  if getPlayerStorageValue(cid, 7035) >= 1 and getPlayerStorageValue(cid, 7036) >= 1 then
    local Config = LOCATION_ROOKGARD['SwordOfFury']
    local GetSword = getThingfromPos(Config.SwordPosition)
    if GetSword.itemid == 2383 then
      doRemoveItem(GetSword.uid)
      doCreateItem(2383, 1, Config.NewSwordPosition)
      doSummonCreature(Config.MonsterSpawnName, Config.MonsterSpawnPos)
      doSendMagicEffect(Config.SwordPosition, 13)
      setPlayerStorageValue(cid, 7037, 1)
      
      for i, data in ipairs(Config.FirePositions) do
        local fire = getThingfromPos(data)
        doTransformItem(fire.uid,Config.FireReplacement)
      end

    end
  end
end