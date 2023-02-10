local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)                 npcHandler:onCreatureAppear(cid)             end
function onCreatureDisappear(cid)             npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)         npcHandler:onCreatureSay(cid, type, msg)     end
function onThink()                             npcHandler:onThink()                         end

function creatureSayCallback(cid, type, msg)
    if(not npcHandler:isFocused(cid)) then
        return false
    end

    local shopWindow = {}
    local spells = {
        {id=1950, buy = 150, name = "Exana Pox", spell = "Andidote", vocations = {1,2,3,4,5,6,7,8}, level = 10},
        {id=1950, buy = 2500, name = "Exori", spell = "Berserk", vocations = {4,8}, level = 35},
        {id=1950, buy = 80, name = "Exiva", spell = "Find Person", vocations = {1,2,3,4,5,6,7,8}, level = 8},
        {id=2182, buy = 5000, name = "Exori Flam", spell = "Flame Strike", vocations = {1,2,5,6}, level = 12},
        {id=1950, buy = 8000, name = "Utito Tempo", spell = "Blood Rage", vocations = {4,8}, level = 60},
        {id=1950, buy = 2000, name = "Exeta Res", spell = "Challenge", vocations = {8}, level = 20},
        {id=1950, buy = 5000, name = "Exori Gran", spell = "Fierce Berserk", vocations = {4,8}, level = 70},
        {id=1950, buy = 500, name = "Utevo Gran Lux", spell = "Great Light", vocations = {1,2,3,4,5,6,7,8}, level = 13},
        {id=1950, buy = 1500, name = "Exori Mas", spell = "Groundshaker", vocations = {4,8}, level = 33},
        {id=1950, buy = 1500, name = "Exana Mort", spell = "Wound Cleansing", vocations = {4,8}, level = 30}
    }
    
    local onBuy = function(cid, item, subType, amount, ignoreCap, inBackpacks)
        if not getPlayerLearnedInstantSpell(cid, shopWindow[item].Words) then
            if getPlayerLevel(cid) >= shopWindow[item].Level then
                if isInArray(shopWindow[item].Vocs, getPlayerVocation(cid)) then
                    doPlayerRemoveMoney(cid, shopWindow[item].Price)
                    doPlayerLearnInstantSpell(cid, shopWindow[item].Words)
                    npcHandler:say("You have learned " .. shopWindow[item].Words, cid)
                else
                    npcHandler:say("This spell is not for your vocation.", cid)
                end
            else
                npcHandler:say("You need to obtain a level of " .. shopWindow[item].Level .. " or higher to be able to learn this spell.", cid)
            end
        else
            npcHandler:say("You already know this spell.", cid)
        end
            

        return true
    end
    if msgcontains(msg, 'trade') or msgcontains(msg, 'spells') then
        for var, item in pairs(spells) do
            if then
                shopWindow[item.id] = {Level = item.level, Vocs = item.vocations, Price = item.buy, subType = 0, Words = item.spell, SpellName = item.name}
            end
        end
        openShopWindow(cid, spells, onBuy, onSell) end
        return true
    end
    return true
end


npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())