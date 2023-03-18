local deathListEnabled = true
local maxDeathRecords = 100

-- aka "one way karma system"
local DISGUSTING_KILLER = {
  LevelDifference = 0.75, -- number to multiply killer level to compare
  DeathJailPosition = Position(35, 18, 9),
  StorageValue = 62000,
  MaxToTrigger = 4,
  -- make sure to make the texts for each "disgusted" kill
  KillMessage = "Let's see... what you gonna do now!!!",
  Texts = {
    "A being is paying attention to your behaviour",
    "A being is paying attention to your behaviour",
    "A being is disgusted with your decision making",
    "A being is being displeased with your view...",
    "A being is being displeased with your view...",
    "A being is being displeased with your view...",
    "A being is displeased with your behaviour and says that you will regret if you still behave like that",
    "Now this is enough of your disgusting behaviour!!"
  }
}

function bringDisgustingKillerToDemigod(killer)
	killer = Player(killer)
  -- teleport 
  killer:teleportTo(DISGUSTING_KILLER.DeathJailPosition, false)
  -- send effect
  killer:getPosition():sendMagicEffect(CONST_ME_GREEN_RINGS)
  -- send message
  killer:sendTextMessage(MESSAGE_INFO_DESCR, DISGUSTING_KILLER.KillMessage)
end
function onDeath(player, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	local playerId = player:getId()
	if nextUseStaminaTime[playerId] then
		nextUseStaminaTime[playerId] = nil
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are dead.")
	local killunjustified = lastHitUnjustified and 1 or 0
	if killer:isPlayer() and killunjustified then
		local killerLevel = killer:getLevel()
		if killerLevel * DISGUSTING_KILLER.LevelDifference > player:getLevel() then
		-- yes this is disgusting kill
		
		local DisgustedKillCount = killer:getStorageValue(DISGUSTING_KILLER.StorageValue)
		-- make sure to be unpredictible
		if DisgustedKillCount >= DISGUSTING_KILLER.MaxToTrigger + math.random(-1, 2) then
			-- oh hes done for but with random event spawning
			local randomDelay = 1000 -- math.random(15000, 60000)
			addEvent(bringDisgustingKillerToDemigod, randomDelay, killer)
			killer:setStorageValue(DISGUSTING_KILLER.StorageValue, 0)
			killer:sendTextMessage(MESSAGE_INFO_DESCR, DISGUSTING_KILLER.Texts[#DISGUSTING_KILLER.Texts])
		else
			if DisgustedKillCount == -1 then
				DisgustedKillCount = 0
			end
			killer:setStorageValue(DISGUSTING_KILLER.StorageValue, DisgustedKillCount + 1)
			killer:sendTextMessage(MESSAGE_INFO_DESCR, DISGUSTING_KILLER.Texts[DisgustedKillCount + 1])
		end
		end
	end
	if not deathListEnabled then
		return
	end

	local byPlayer = 0
	local killerName
	if killer then
		if killer:isPlayer() then
			byPlayer = 1
		else
			local master = killer:getMaster()
			if master and master ~= killer and master:isPlayer() then
				killer = master
				byPlayer = 1
			end
		end
		killerName = killer:getName()
	else
		killerName = "field item"
	end

	local byPlayerMostDamage = 0
	local mostDamageKillerName
	if mostDamageKiller then
		if mostDamageKiller:isPlayer() then
			byPlayerMostDamage = 1
		else
			local master = mostDamageKiller:getMaster()
			if master and master ~= mostDamageKiller and master:isPlayer() then
				mostDamageKiller = master
				byPlayerMostDamage = 1
			end
		end
		mostDamageName = mostDamageKiller:getName()
	else
		mostDamageName = "field item"
	end

	local playerGuid = player:getGuid()
	db.asyncQuery("INSERT INTO `player_deaths` (`player_id`, `time`, `level`, `killed_by`, `is_player`, `mostdamage_by`, `mostdamage_is_player`, `unjustified`, `mostdamage_unjustified`) VALUES (" .. playerGuid .. ", " .. os.time() .. ", " .. player:getLevel() .. ", " .. db.escapeString(killerName) .. ", " .. byPlayer .. ", " .. db.escapeString(mostDamageName) .. ", " .. byPlayerMostDamage .. ", " .. (unjustified and 1 or 0) .. ", " .. (mostDamageUnjustified and 1 or 0) .. ")")
	local resultId = db.storeQuery("SELECT `player_id` FROM `player_deaths` WHERE `player_id` = " .. playerGuid)

	local deathRecords = 0
	local tmpResultId = resultId
	while tmpResultId ~= false do
		tmpResultId = result.next(resultId)
		deathRecords = deathRecords + 1
	end

	if resultId ~= false then
		result.free(resultId)
	end

	local limit = deathRecords - maxDeathRecords
	if limit > 0 then
		db.asyncQuery("DELETE FROM `player_deaths` WHERE `player_id` = " .. playerGuid .. " ORDER BY `time` LIMIT " .. limit)
	end
	if byPlayer == 1 then
		local targetGuild = player:getGuild()
		targetGuild = targetGuild and targetGuild:getId() or 0
		if targetGuild ~= 0 then
			local killerGuild = killer:getGuild()
			killerGuild = killerGuild and killerGuild:getId() or 0
			if killerGuild ~= 0 and targetGuild ~= killerGuild and isInWar(playerId, killer:getId()) then
				local warId = false
				resultId = db.storeQuery("SELECT `id` FROM `guild_wars` WHERE `status` = 1 AND ((`guild1` = " .. killerGuild .. " AND `guild2` = " .. targetGuild .. ") OR (`guild1` = " .. targetGuild .. " AND `guild2` = " .. killerGuild .. "))")
				if resultId ~= false then
					warId = result.getNumber(resultId, "id")
					result.free(resultId)
				end

				if warId ~= false then
					db.asyncQuery("INSERT INTO `guildwar_kills` (`killer`, `target`, `killerguild`, `targetguild`, `time`, `warid`) SELECT " .. db.escapeString(killerName) .. ", " .. db.escapeString(player:getName()) .. ", " .. killerGuild .. ", " .. targetGuild .. ", " .. os.time() .. ", `id` FROM `guild_wars` WHERE `status` = 1 AND ((`guild1` = " .. killerGuild .. " AND `guild2` = " .. targetGuild .. ") OR (`guild1` = " .. targetGuild .. " AND `guild2` = " .. killerGuild .. "))")
        end
      end
    end
  end
end

