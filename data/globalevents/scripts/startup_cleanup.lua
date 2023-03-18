--[[ 
    This script cleans the database every time the server is started, with the main aim of not overloading it.
    It works as configured:
        - Deleting inactive characters for X months.
        - Deleting accounts that have been empty (which have no characters created) for X months.
        - Leaving the houses free if their owner does not enter the game for more than X days.
        - Deleting house invites made by former residents if the house has no owner.
        - Deleting guilds that were created X days ago and have less than Y members.
     Credit: luanluciano93, Leu and Cjaker.
]]--

local inactiveMonthsToDeleteCharacter = 6 -- How many months the player needs to be inactive to be deleted.
local emptyAccountMonths = 1 -- How many months an account needs to be without any character created to be deleted.
local inactiveDaysToCleanHouse = 7 -- How many days the player needs to be inactive to lose the house.
local inactiveDaysToCleanGuildWithFewPlayers = 10 -- How many days after the creation of the guild will verify the minimum amount of players.
local minimumGuildMembers = 5 -- Minimum amount of members for the guild not to enter verification.

local function executeDatabase(fromClause)
    local totalClear = 0
    local resultId = db.storeQuery("SELECT COUNT(*) AS `count` FROM ".. fromClause)
    if resultId ~= false then
        totalClear = result.getNumber(resultId, 'count')
        result.free(resultId)
        if totalClear > 0 then
            db.query("DELETE FROM ".. fromClause)
        end
    end
    return totalClear
end

local function doCheckInactivePlayer() -- Automatically delete data from tables "houses, player_items, player_depotitems, player_deaths, guilds, player_storage"
    local timeStamp = os.time() - (86400 * (inactiveMonthsToDeleteCharacter * 30))
    local fromClause = "`players` WHERE NOT `name` == 'Starting Player Sample' and `group_id` = 1 AND lastlogin <= ".. timeStamp
    return executeDatabase(fromClause)
end

local function doCheckEmptyAccounts() -- Automatically delete data from tables "player_viplist"
    local timeStamp = os.time() - (86400 * (emptyAccountMonths * 30))
    local fromClause = "`accounts` WHERE `accounts`.`creation` <= ".. timeStamp .." AND NOT EXISTS (SELECT `id` FROM `players` WHERE `accounts`.`id` = `players`.`account_id`)"
    return executeDatabase(fromClause)
end

local function doCheckInactiveHouses() -- Checks for inactive houses
    local timeStamp = os.time() - (86400 * (inactiveDaysToCleanHouse * 24))
    local totalClear = 0
    
    local resultId = db.storeQuery("SELECT `houses`.`owner`, `houses`.`id` FROM `houses`, `players` WHERE `houses`.`owner` != 0 AND `houses`.`owner` = `players`.`id` AND `players`.`lastlogin` <= " .. timeStamp .. ";")
    if resultId ~= false then        
        repeat
            local owner = result.getNumber(resultId, "owner")
            local houseId = result.getNumber(resultId, "id")
            local house = House(houseId)

            if house and (owner > 0) then
                house:setOwnerGuid(0)
                totalClear = totalClear + 1
            end
        until not result.next(resultId)
        result.free(resultId)
    end
    return totalClear
end

local function doCheckInactiveHouseLists() --Deleting "house_lists" from the player
    local fromClause = "`house_lists` WHERE EXISTS (SELECT `id` FROM `houses` WHERE `house_lists`.`house_id` = `houses`.`id` AND `houses`.`owner` = 0)"
    return executeDatabase(fromClause)
end

local function doCheckInactiveGuilds() -- automatically delete data from tables  "guild_invites, guild_membership, guild_ranks"
    local timeStamp = os.time() - (86400 * (inactiveDaysToCleanGuildWithFewPlayers * 24))
    local fromClause = "`guilds` WHERE `guilds`.`creationdata` <= ".. timeStamp .." AND (SELECT COUNT(*) from `guild_membership` WHERE `guild_membership`.`guild_id` = `guilds`.`id`) < " .. minimumGuildMembers .. ""
    return executeDatabase(fromClause)
end

-- Executing cleaning functions upon server startup.
function onStartup()
    print("[[ DATABASE CLEAN ]]")

    local inactivePlayer = doCheckInactivePlayer()
    if inactivePlayer > 0 then
        print(">> ".. inactivePlayer .. " deleted inactive players.")
    end

    local emptyAccounts = doCheckEmptyAccounts()
    if emptyAccounts > 0 then
        print(">> ".. emptyAccounts .." empty deleted accounts.")
    end

    local inactiveHouses = doCheckInactiveHouses()
    if inactiveHouses > 0 then
        print(">> ".. inactiveHouses .." houses that were expropriated.")
    end

    local inactiveHouseLists = doCheckInactiveHouseLists()
    if inactiveHouseLists > 0 then
        print(">> ".. inactiveHouseLists .." deleted inactive house lists.")
    end

    local inactiveGuilds = doCheckInactiveGuilds()
    if inactiveGuilds > 0 then
        print(">> ".. inactiveGuilds .." deleted inactive guilds.")
    end

    addEvent(saveServer, 10000)
end