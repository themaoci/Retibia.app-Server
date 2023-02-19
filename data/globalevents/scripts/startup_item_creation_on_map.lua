
function onStartup()
    if secretPassage_code == nil or #secretPassage_code == 0 then
        math.randomseed( os.time() ) -- first, sets a seed for the pseudo-random generator
        local function my_random (t,from, to)  -- second, exclude duplicates
            local num = math.random (from, to)
            if t[num] then  num = my_random (t, from, to)   end
            t[num]=num 
            return num
        end
        secretPassage_code = {}
        t = {}    -- initialize  table with not duplicate values
        v_Name = "x-"
        for i =1,4 do
            table.insert(secretPassage_code, i, my_random(t, 1, 4))
            --v_Name = v_Name .. i    -- It is better to use the table here and concatenate it after..
        end 
        print("[SECRET] secretPassage_code (687,247,8): " .. table.concat(secretPassage_code, "") .. " [" .. string.format("%x", tonumber(table.concat(secretPassage_code, ""))) .. "]")

        -- spawn helper for entrance to the crypt
        local position_item = Position(689, 251, 8)
        position_item.stackpos = 1
        
        local parchment = Game.createItem(23796, 1, position_item) -- 23796 - parchment
        parchment:setCustomAttribute("secretPassageHelp", tonumber(table.concat(secretPassage_code, "")))
        parchment:setAttribute(ITEM_ATTRIBUTE_TEXT, "What i was able to research is that there are 'Hexagonal' patterns all over the wall. They all together translates to " .. string.format("%x", tonumber(table.concat(secretPassage_code, ""))))
        parchment:setActionId(999)
    end
end