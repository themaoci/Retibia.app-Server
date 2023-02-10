local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

-- Basic Keywords
keywordHandler:addKeyword({'hint'}, StdModule.rookgaardHints, {npcHandler = npcHandler})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, text = 'Time doesn\'t matter to me.'})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m Tenebrus ex hero.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m a mage.'})
keywordHandler:addKeyword({'mage'}, StdModule.say, {npcHandler = npcHandler, text = 'Oh you want to know more about mages ? well they can use spells on more profitable manner also their effectiveness increases. If you want to become a mage you need to exceel in magic skills'})
keywordHandler:addKeyword({'bank'}, StdModule.say, {npcHandler = npcHandler, text = 'Storage for worldly wealth.'})
keywordHandler:addKeyword({'destiny'}, StdModule.say, {npcHandler = npcHandler, text = 'Well i know it could break your faith but our destiny was ruined by some upper being...'})
keywordHandler:addKeyword({'how', 'are', 'you'}, StdModule.say, {npcHandler = npcHandler, text = 'Thank the gods, I\'m fine.'})
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, text = 'What help do you seek? I sell health potions, ask me for a {trade} if you need one.'})
keywordHandler:addKeyword({'magic'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m one of the few magic users on this isle.'})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, text = 'It is shaped by the will of the gods, so we don\'t have to question it.'})
keywordHandler:addKeyword({'temple'}, StdModule.say, {npcHandler = npcHandler, text = 'I used to be there with my old friend Cipfried to heal adventurers. After all these years, I prefer solitude now.'})
keywordHandler:addKeyword({'library'}, StdModule.say, {npcHandler = npcHandler, text = 'The library is in the {academy}, north of the {temple}.'})
keywordHandler:addKeyword({'academy'}, StdModule.say, {npcHandler = npcHandler, text = 'A place to learn about {Tibia}.'})
keywordHandler:addKeyword({'food'}, StdModule.say, {npcHandler = npcHandler, text = 'Are you hungry? I\'m sorry, I have no food here.'})
keywordHandler:addKeyword({'potion'}, StdModule.say, {npcHandler = npcHandler, text = 'Yes, I sell health and mana potions. Ask me for a {trade} if you need one.'})
keywordHandler:addKeyword({'dungeon'}, StdModule.say, {npcHandler = npcHandler, text = 'The dungeons are dangerous for inexperienced adventurers.'})

keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, text = 'Just ask me for a {trade} to check out my offers. I have only small health potions for sale, though.'})
keywordHandler:addAliasKeyword({'stuff'})
keywordHandler:addAliasKeyword({'wares'})
keywordHandler:addAliasKeyword({'buy'})
keywordHandler:addAliasKeyword({'sell'})

keywordHandler:addKeyword({'equipment'}, StdModule.say, {npcHandler = npcHandler, text = 'You\'ll have to buy that from the merchants in town. I\'m just a simple druid and healer.'})
keywordHandler:addAliasKeyword({'rope'})
keywordHandler:addAliasKeyword({'backpack'})
keywordHandler:addAliasKeyword({'shovel'})
keywordHandler:addAliasKeyword({'shield'})
keywordHandler:addAliasKeyword({'armor'})
keywordHandler:addAliasKeyword({'helmet'})

keywordHandler:addKeyword({'deposit'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'ll pay you 5 gold for every empty vial and potion flask. Just ask me for a {trade}.'})
keywordHandler:addAliasKeyword({'flask'})
keywordHandler:addAliasKeyword({'vial'})

-- Names
keywordHandler:addKeyword({'obi'}, StdModule.say, {npcHandler = npcHandler, text = 'A greedy and annoying person just like most people are.'})
keywordHandler:addKeyword({'norma'}, StdModule.say, {npcHandler = npcHandler, text = 'Now she has completely gotten out of her mind.'})
keywordHandler:addKeyword({'loui'}, StdModule.say, {npcHandler = npcHandler, text = 'He was a promising young druid when something happened to his mind. It\'s a sad story.'})
keywordHandler:addKeyword({'santiago'}, StdModule.say, {npcHandler = npcHandler, text = 'He does a good job out there.'})
keywordHandler:addKeyword({'zirella'}, StdModule.say, {npcHandler = npcHandler, text = 'I know her since she was little.'})
keywordHandler:addKeyword({'al', 'dee'}, StdModule.say, {npcHandler = npcHandler, text = 'One of these greedy merchants.'})
keywordHandler:addKeyword({'amber'}, StdModule.say, {npcHandler = npcHandler, text = 'I saw her stranding with her raft.'})
keywordHandler:addKeyword({'billy'}, StdModule.say, {npcHandler = npcHandler, text = 'He\'s a farmer and behaves a little better than his cousin.'})
keywordHandler:addKeyword({'willie'}, StdModule.say, {npcHandler = npcHandler, text = 'An unpleasant person.'})
keywordHandler:addKeyword({'cipfried'}, StdModule.say, {npcHandler = npcHandler, text = 'His healing powers equal mine.'})
keywordHandler:addKeyword({'dixi'}, StdModule.say, {npcHandler = npcHandler, text = 'I think she\'s under bad influence.'})
keywordHandler:addKeyword({'hyacinth'}, StdModule.say, {npcHandler = npcHandler, text = 'That\'s my name.'})
keywordHandler:addKeyword({'lee\'delle'}, StdModule.say, {npcHandler = npcHandler, text = 'She\'s actually quite nice.'})
keywordHandler:addKeyword({'lily'}, StdModule.say, {npcHandler = npcHandler, text = 'She\'s a druid. Since she started selling health potions, people visit me only rarely. Which is a good thing, but of course I\'ll help if I\'m needed.'})
keywordHandler:addKeyword({'oracle'}, StdModule.say, {npcHandler = npcHandler, text = 'The oracle will lead you to your {destiny} once you are level 8.'})
keywordHandler:addKeyword({'paulie'}, StdModule.say, {npcHandler = npcHandler, text = 'I think that guy is new. He\'s a {bank} clerk.'})
keywordHandler:addKeyword({'seymour'}, StdModule.say, {npcHandler = npcHandler, text = 'He has some inner devils that torture him.'})
keywordHandler:addKeyword({'tom'}, StdModule.say, {npcHandler = npcHandler, text = 'Tom is the local tanner. That means he always needs fresh corpses or leather.'})
keywordHandler:addKeyword({'dallheim'}, StdModule.say, {npcHandler = npcHandler, text = 'A man of the sword.'})
keywordHandler:addAliasKeyword({'zerbrus'})

npcHandler:setMessage(MESSAGE_WALKAWAY, 'See you then.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Bless you on your journeys.')
npcHandler:setMessage(MESSAGE_SENDTRADE, 'Here you go. Don\'t forget, if you buy potions, there\'s a {deposit} of 5 gold on the empty flask.')
npcHandler:setMessage(MESSAGE_GREET, 'Greetings, traveller |PLAYERNAME|. As you have found me in this depths of books, how can i {help} you ?')


local booksByType = {
    ["attack"] = 1955,
    ["healing"] = 1960,
    ["support"] = 1959,
    ["runeMaking"] = 1958,
    ["conjure"] = 1958,
    ["enchant"] = 1958
}
function creatureSayCallback(cid, type, msg)
    if(not npcHandler:isFocused(cid)) then
        return false
    end
    local showAll = msgcontains(msg, 'spellsall')
    if msgcontains(msg, 'spells') or showAll then

        local skillAvailableToBuy = {}
        local allSkills = {}
        local spells = {}
        local playerLevel = tonumber(getPlayerLevel(cid))
        local playerMLevel = tonumber(getPlayerMagLevel(cid))
        local playerDLevel = tonumber(getPlayerSkill(cid, 4))
        local playerCLevel = tonumber(math.max(unpack({getPlayerSkill(cid, 0), getPlayerSkill(cid, 1), getPlayerSkill(cid, 2), getPlayerSkill(cid, 3)})))
        local Spells = {GameConfig.Spells.Free, GameConfig.Spells.Premium}
        
        local AddToSpellList = function(spell, extendName)
            if getPlayerLearnedInstantSpell(cid, spell.name) then return end

            local item_level = tonumber(spell.level or 0)
            local item_mlevel = tonumber(spell.mlevel or 0)
            local item_clevel = tonumber(spell.clevel or 0)
            local item_dlevel = tonumber(spell.dlevel or 0)

            local CanLearnNow = ""
            if item_level <= playerLevel and item_mlevel <= playerMLevel and item_dlevel <= playerDLevel and item_clevel <= playerCLevel then
                CanLearnNow = "[*]"
                skillAvailableToBuy[#spells + 1] = spell
            else
                if not showAll then return end
            end

            allSkills[#spells + 1] = spell

            local bookId = booksByType["attack"]
            if string.sub(spell.name, -4) == "Rune" then
                bookId = booksByType["runeMaking"]
            end
            spells[#spells + 1] = {
                id = bookId, 
                buy = spell.price, 
                sell = 0, 
                subType = i, 
                specialId = #spells + 1,
                name = extendName .. "Spellbook:\n" .. spell.name,
                funcShop = 1
            }
        end
        
        for i, list in pairs(Spells) do
            if i == 1 then
                for i, spell in pairs(list) do
                    AddToSpellList(spell, "")
                end
            else
                if isPremium(cid) then
                    for i, spell in pairs(list) do
                        AddToSpellList(spell, "Old ")
                    end
                end
            end
        end

        local onBuy = function(cid, item, subType, amount, ignoreCap, inBackpacks, specialId)
            local SpellToBuy = skillAvailableToBuy[specialId]
            if SpellToBuy ~= nil then
                if not getPlayerLearnedInstantSpell(cid, SpellToBuy.name) then
                    local player = Player(cid)
                    if player:removeTotalMoney(SpellToBuy.price) then
                        doPlayerLearnInstantSpell(cid, SpellToBuy.name)
                        --You can use that spell now with incantation of {" .. SpellToBuy.words .. "}.
                        npcHandler:say("Thank you. I have received your payment of " .. SpellToBuy.price .. "gp for " .. SpellToBuy.name .. " spellbook.", cid)
                    else
                        npcHandler:say("Oh... you dont have enough money ?", cid)
                    end
                else
                    npcHandler:say("You already know this spell.", cid)
                end
            else
                local missingRequirements = ""

                local item_level = tonumber(allSkills[specialId].level or 0)
                local item_mlevel = tonumber(allSkills[specialId].mlevel or 0)
                local item_clevel = tonumber(allSkills[specialId].clevel or 0)
                local item_dlevel = tonumber(allSkills[specialId].dlevel or 0)

                if item_level <= playerLevel then
                    missingRequirements = missingRequirements .. "Level required is " .. item_level .. " but you have " .. playerLevel
                end
                if item_mlevel <= playerMLevel then
                    if missingRequirements ~= "" then
                        missingRequirements = missingRequirements .. ", "
                    end
                    missingRequirements = missingRequirements .. "Magic Level required is " .. item_mlevel .. " but you have " .. playerMLevel
                end
                if item_dlevel <= playerDLevel then
                    if missingRequirements ~= "" then
                        missingRequirements = missingRequirements .. ", "
                    end
                    missingRequirements = missingRequirements .. "Distance Skill Level required is " .. item_dlevel .. " but you have " .. playerDLevel
                end
                if item_clevel <= playerCLevel then
                    if missingRequirements ~= "" then
                        missingRequirements = missingRequirements .. ", "
                    end
                    missingRequirements = missingRequirements .. "Any Combat Skill Level required is " .. item_clevel .. " but you have " .. playerCLevel
                end
                npcHandler:say("You are unable to learn " .. allSkills[specialId].name .. ", because " .. missingRequirements, cid)
            end
            return true
        end
        openShopWindow(cid, spells, onBuy, onSell)
        return true
    end
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
