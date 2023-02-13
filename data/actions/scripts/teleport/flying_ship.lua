local FlyingShip_LastUsed = {}

function onUse(player, item)
    if FlyingShip_LastUsed[player:getId()] ~= nil then
        if FlyingShip_LastUsed[player:getId()] > os.time() then
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You exhausted power of this orb wait abit and try again (>5 seconds)")
            return true
        end
    end

    local uniqueId = item:getActionId()
    FlyingShip_LastUsed[player:getId()] = os.time() + 5
    -- on rookgaard
    if uniqueId == 10110 then
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:teleportTo(GameConfig.FlyingShip.cormaya)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    end
    -- on cormaya
    if uniqueId == 10111 then
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:teleportTo(GameConfig.FlyingShip.rookgaard)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    end
    return true
end
  