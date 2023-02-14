-- Infinity Room Config
local IRConfig = {
    startPos = Position(100, 100, 2), -- upper left corner
    tpInAid = 65000, -- actionid for enter teleport
    tpOutAid = 65001, -- actionid for exit teleport
    foodAid = 65002, -- actionid for infinity food (only work with EventCallback)
    replacableTile = 598,
    maxRoomsPer = { -- 15 x 15 = 225 rooms max
        row = 15,
        col = 15
    },
    doNotDelete = { 13635, 9726 },
    playerSpotId = 14,
    mapTiles = {
    --{},                               -- 0 -- skip drawing
      {},                               -- 1 -- empty
      {17464},                          -- 2 -- left top corner
      {17444},                          -- 3 -- top center
      {17453},                          -- 4 -- right top
      {17447},                          -- 5 -- right center
      {17454},                          -- 6 -- right bottom
      {17445},                          -- 7 -- bottom center
      {17455},                          -- 8 -- left bottom
      {17446},                          -- 9 -- left center
      {17437, 17574},                   -- 10 -- 1x1
      {17437, 1387, "teleport"},        -- 11 -- 1x2
      {17437, 17566},                   -- 12 -- 1x3
      {17437, 1645, 7159, "foodhuge"},  -- 13 -- 2x1
      {18001},                          -- 14 -- 2x2 - player spot
      {17437, 17575},                   -- 15 -- 2x3
      {17437, "training device"},        -- 16 -- 3x1
      {17437, 1484},                    -- 17 -- 3x2
      {17437, "training device"},        -- 18 -- 3x3
    },
    map = { -- room drawing mask
      { 0,  0,  0,  0,  0,  0, 0 },
      { 0,  2,  3,  3,  3,  4, 0 },
      { 0,  9, 10, 11, 12,  5, 0 },
      { 0,  9, 13, 14, 15,  5, 0 },
      { 0,  9, 16, 17, 18,  5, 0 },
      { 0,  8,  7,  7,  7,  6, 0 },
      { 0,  0,  0,  0,  0,  0, 0 },
    }
}

local IRoom, mapDistX, mapDistY = {}, #IRConfig.map[1], #IRConfig.map
IRoom.__index = IRoom
if not IRoomList then
    IRoomList = {}
end

function IRoom.new(pos, fromPos, index)
    local iroom = {}
    setmetatable(iroom, IRoom)
    iroom.pos = pos
    iroom.fromPos = fromPos
    for x = 1, mapDistX do
        for y = 1, mapDistY do
            local tilePos = Position(pos.x+x, pos.y+y, pos.z)
            tilePos.stackpos = 1
            local tileIndex = IRConfig.map[y][x]
            if tileIndex == IRConfig.playerSpotId then iroom.center = tilePos end
            if tileIndex == 0 then goto endLooper end
            local lastItem
            for _, it in pairs(IRConfig.mapTiles[tileIndex]) do
                local thingType = type(it)
                if thingType == "number" then
                    lastItem = Game.createItem(it, 1, tilePos)
                    if not lastItem then
                      debugPrint("[Warning - IRoom::new] the room could not be created correctly.")
                      iroom:destroy()
                      return
                    end
                elseif thingType == "string" then
                    if it == "teleport" then
                        lastItem:setCustomAttribute("roomIndex", index)
                        lastItem:setAttribute(ITEM_ATTRIBUTE_ACTIONID, IRConfig.tpOutAid)
                    elseif it == "foodhuge" then
                        if EventCallback then
                            lastItem:setAttribute(ITEM_ATTRIBUTE_ACTIONID, IRConfig.foodAid)
                        end
                    else        
                        Game.createMonster(it, tilePos)
                    end
                end
            end
            ::endLooper::
        end
    end
    IRoomList[index] = iroom
    return iroom
end

function IRoom:destroy()
    for x = 1, mapDistX do
        for y = 1, mapDistY do
            local pos = Position(self.pos.x+x, self.pos.y+y, self.pos.z)
            local tile = Tile(pos)
            if tile then
                local thingCount = tile:getThingCount()
                for index = thingCount, 0, -1 do
                  if index ~= 0 then
                    local thing = tile:getThing(index)
                    if thing then
                        if thing:isPlayer() then
                            thing:teleportTo(self.fromPos)
                        else
                            thing:remove()
                        end
                    end
                  end
                end
            end
            pos:sendMagicEffect(CONST_ME_POFF)
        end
    end
    IRoomList[self.index] = nil
end

local function getNextPosition()
    local x, y, z = IRConfig.startPos.x, IRConfig.startPos.y, IRConfig.startPos.z
    local index, indey, pos = 1, 0, Position(x, y, z)
    for _, iroom in pairs(IRoomList) do
        if iroom.pos ~= pos then
            break
        else
            pos = Position(x + (mapDistX * index), y + (mapDistY * indey), z)
            index = index +1
            if index % IRConfig.maxRoomsPer.row == 0 then
                index, indey = 0, indey + 1
                if indey > IRConfig.maxRoomsPer.col then
                    return
                end
            end
        end
    end
    return pos, index
end

local moveOutTp = MoveEvent()
function moveOutTp.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if player then
        local roomIndex = item:getCustomAttribute("roomIndex")
        if roomIndex then
            local iroom = IRoomList[roomIndex]
            if iroom then
                player:teleportTo(iroom.fromPos)
                iroom.fromPos:sendMagicEffect(CONST_ME_TELEPORT)
                iroom:destroy()
                return true
            end
        end
    end
    return true
end
moveOutTp:aid(IRConfig.tpOutAid)
moveOutTp:register()

local moveInTp = MoveEvent()
function moveInTp.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if player then
        local pos, index = getNextPosition()
        if not pos then
            player:teleportTo(fromPosition, false)
            player:sendCancelMessage("There are no free training rooms, try later.")
            return true
        end
        local iroom = IRoom.new(pos, player:getTown():getTemplePosition(), index)
        if iroom then
            iroom.index = index
            player:teleportTo(iroom.center)
            iroom.center:sendMagicEffect(CONST_ME_TELEPORT)
        end
    end
    return true
end
moveInTp:aid(IRConfig.tpInAid)
moveInTp:register()

local foodAction = Action()
function foodAction.onUse(player, item, toPosition, target, fromPosition, isHotkey)
    local condition = player:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
    if condition and math.floor(condition:getTicks() / 1000 + (10 * 12)) >= 1200 then
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "You are full.")
        player:say("You are full.", TALKTYPE_MONSTER_SAY)
    else
        player:feed(120)
        player:say("Mmmm.", TALKTYPE_MONSTER_SAY)
    end
    return true
end
foodAction:aid(IRConfig.foodAid)
foodAction:register()

if EventCallback then
    local ec = EventCallback
    function ec.onMoveItem(player, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
        if item:getActionId() == IRConfig.foodAid then
            return false
        end
        return true
    end
    ec:register(1)
end