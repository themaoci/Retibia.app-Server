local nextOpenTimeDelay = 5 -- 5 seconds
local loot_table = {
    [{  0,  50}] = {
        { id = 2148, count = {1, 10} },
    },
    [{ 50,  84}] = {
        { id = 2148, count = {10, 50} },
    },
    [{ 85,  94}] = {
        { id = 2152, count = {1, 2} },
    },
    [{ 95,  99}] = {
        { id = 2152, count = {5, 10} },
    },
    [{100, 100}] = {
        { id = 2160, count = 1 },
    }
}
local function getRewardsByChance(chance)
    for k, v in pairs(loot_table) do
        if (chance >= k[1] and chance <= k[2]) then
            return v
        end
    end
    return false
end
RandomizedChestsTimeTable = {}
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    --local tmp = getRewardsByLevel(player:getLevel())
    local position = item:getPosition()
    local chest_hash = position.x .. ":" .. position.y .. ":" .. position.z
    local OpenTime = os.time()
    local ChestNotUsedOnce = RandomizedChestsTimeTable[chest_hash] == nil
    local ChestUsedTimeWait = RandomizedChestsTimeTable[chest_hash] ~= nil and RandomizedChestsTimeTable[chest_hash] < OpenTime

    print("-----")
    for k,v in pairs(RandomizedChestsTimeTable) do
        print(k .. " => " .. v)    
    end
    --print(ChestNotUsedOnce)
    --print(ChestUsedTimeWait)
    if ChestNotUsedOnce or ChestUsedTimeWait then
        -- set new time for the chest to generate staff
        RandomizedChestsTimeTable[chest_hash] = OpenTime + nextOpenTimeDelay
        local gen_number_of_items = math.random(0, 5)
        for i = 0, gen_number_of_items do
            local chance = math.random(0, 100)
            local reward_table = getRewardsByChance(chance)
            local r_item = reward_table[math.random(1, #reward_table)]
            local amount = r_item.count == 'number' and r_item.count or math.random(r_item.count[1], r_item.count[2])
            --print("chance: " .. chance .. "  item: " .. r_item.id .. "  amount: " .. amount)
            item:addItem(r_item.id, amount)
        end
    
    end
    -- nothing to do here anymore
    return false
end