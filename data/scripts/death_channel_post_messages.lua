local config = {
    channelId = 20,
    subTypes = {
        { count = 1, message = 'was killed by' },
        { count = 2, message = 'was slain by' },
        { count = 5, message = 'was crushed by' },
        { count = 8, message = 'was eliminated by' },
        { count = 10, message = 'was annihilated by' }
    }
}
local creatureEvent = CreatureEvent("DeathChannelOnDeath")
function creatureEvent.onDeath(player)
    local attackersCount, description, creatures = 0, {}, {}
    for uid, cb in pairs(player:getDamageMap()) do
        local attacker = Creature(uid)
        if attacker then
            if attacker:isPlayer() then
                attackersCount = attackersCount + 1
                description[attackersCount] = attacker:getName() .. '[' .. attacker:getLevel() .. ']'
            elseif attacker:isMonster() then
                local attackerName = attacker:getName()
                if not creatures[attackerName] then
                    local master = attacker:getMaster()
                    if master then
                        attackersCount = attackersCount + 1
                        description[attackersCount] = string.format('a %s summoned by %s', attackerName, master:isPlayer() and master:getName() or master:getType():getNameDescription())
                    else
                        attackersCount = attackersCount + 1
                        description[attackersCount] = string.format('a %s', attackerName)
                    end
                    creatures[attackerName] = true
                end
            end
        end
    end

    local subType = nil
    for _, info in ipairs(config.subTypes) do
        if attackersCount >= info.count then
            subType = info.message
        end
    end

    sendChannelMessage(config.channelId, TALKTYPE_CHANNEL_O, string.format('%s [%d] %s %s.', player:getName(), player:getLevel(), subType, table.concat(description, ', '):gsub('(.*),', '%1 and')))
end

creatureEvent:register()

local creatureEvent = CreatureEvent("DeathChannelOnLogin")

function creatureEvent.onLogin(player)
    player:registerEvent("DeathChannelOnDeath")
    return true
end

creatureEvent:register()