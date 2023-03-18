
-- 

function onStepIn(cid, item, pos, topos)
    if isPlayer(cid) == TRUE then
        --local tileActionId = item:getActionId()
        local tileUniqueId = item:getUniqueId()
        -- set achivement on entering room or other place
        if player:getStorageValue(tileUniqueId) ~= 1 then
            player:setStorageValue(tileUniqueId, 1)
        end
    end
end