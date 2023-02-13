DA_Config = {
    entrancePositions = {
        Position(678, 294, 12),
        Position(679, 294, 12),
        Position(680, 294, 12),
        Position(681, 294, 12)
    },
    exitPositions = {
        Position(769, 294, 12),
        Position(770, 294, 12),
        Position(771, 294, 12),
        Position(772, 294, 12)
    },
    demonPositions = {
		Position(768, 294, 12),
		Position(767, 294, 12),
		Position(769, 292, 12),
		Position(769, 296, 12),
		Position(771, 292, 12),
		Position(771, 296, 12),
		Position(773, 292, 12),
		Position(773, 296, 12),
		Position(774, 293, 12),
		Position(774, 295, 12)
	},
    spawnMonster = "Demon",
    requiredLevel = 100,
    LeverLeft = 9825,
    LeverRight = 9826,
}

function onUse(cid, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == DA_Config.LeverRight then
        local storePlayers, playerTile = {}
        local failed_to_enter = false
        local whoFinishedAlready = ""
        for i = 1, #DA_Config.entrancePositions do
            playerTile = Tile(DA_Config.entrancePositions[i]):getTopCreature()
            if not playerTile or not playerTile:isPlayer() then
                player:sendTextMessage(MESSAGE_STATUS_SMALL, "You need 4 players.")
                return true
            end

            if playerTile:getLevel() < DA_Config.requiredLevel then
                player:sendTextMessage(MESSAGE_STATUS_SMALL, "All the players need to be level ".. DA_Config.requiredLevel .." or higher.")
                return true
            end

            if playerTile:getPlayerStorageValue(cid, DAC_Config.Storage.EnteredNumber) >= #DAC_Config.rewards then
                failed_to_enter = true
                if whoFinishedAlready ~= "" then
                    
                    whoFinishedAlready = whoFinishedAlready .. ", "
                end
                whoFinishedAlready = whoFinishedAlready .. playerTile:getName()
            end

            storePlayers[#storePlayers + 1] = playerTile
        end
        local specs, spec = Game.getSpectators(DA_Config.exitPositions[1], false, false, 3, 3, 2, 2)
        for i = 1, #specs do
            spec = specs[i]
            if spec:isPlayer() then
                player:sendTextMessage(MESSAGE_STATUS_SMALL, "A team is already inside the quest room.")
                return true
            end

            spec:remove()
        end
        -- checked for spectators and now we gonna check if the guys who want to enter already finished quest so it wont allow any starting
        if failed_to_enter then
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "Those players already finished all possible routes for this quest: " .. whoFinishedAlready)
        end

        for i = 1, #DA_Config.demonPositions do
            Game.createMonster(DA_Config.spawnMonster, DA_Config.demonPositions[i])
        end

        for i = 1, #storePlayers do
            local players = storePlayers[i]
            DA_Config.entrancePositions[i]:sendMagicEffect(CONST_ME_POFF)
            players:teleportTo(DA_Config.exitPositions[i])
            DA_Config.exitPositions[i]:sendMagicEffect(CONST_ME_ENERGYAREA)
            players:setDirection(DIRECTION_EAST)
        end
    else
        --if item.itemid == 1945 then
        --if config.daily then
        --    player:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_NOTPOSSIBLE))
        --    return true
        --
    end
    item:transform(item.itemid == DA_Config.LeverRight and DA_Config.LeverLeft or DA_Config.LeverRight)
    return true
end