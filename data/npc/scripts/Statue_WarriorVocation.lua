local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local vocation = {}

local config = {
  npcAllowedVocation = "warrior",
  minFistLevel = 15,
  minClubLevel = 15,
  minSwordLevel = 15,
  minAxeLevel = 15,
  minShieldLevel = 15,
}

function onCreatureAppear(cid)			    npcHandler:onCreatureAppear(cid)			    end
function onCreatureDisappear(cid)		    npcHandler:onCreatureDisappear(cid)			  end
function onCreatureSay(cid, type, msg)  npcHandler:onCreatureSay(cid, type, msg)  end
function onThink()				              npcHandler:onThink()					            end

local function greetCallback(cid)

	-- SKILL_FIST = 0,
	-- SKILL_CLUB = 1,
	-- SKILL_SWORD = 2,
	-- SKILL_AXE = 3,
	-- SKILL_DISTANCE = 4,
	-- SKILL_SHIELD = 5,
	-- SKILL_FISHING = 6,

	-- SKILL_MAGLEVEL = 7, (not accessable)
	-- SKILL_LEVEL = 8, (not accessable)

	local player = Player(cid)
  local fistLevel = player:getSkillLevel(0)
  local clubLevel = player:getSkillLevel(1)
  local swordLevel = player:getSkillLevel(2)
  local axeLevel = player:getSkillLevel(3)
  local shieldLevel = player:getSkillLevel(5)
  local vocation = player:getVocation():getId()
  
  local isWorthy = fistLevel >= config.minFistLevel or clubLevel >= config.minClubLevel or swordLevel >= config.minSwordLevel or axeLevel >= config.minAxeLevel or shieldLevel >= config.minShieldLevel
  if vocation ~= 0 then
    npcHandler:say(player:getName() ..", you already received the blessing. i can't help you more.", cid)
    npcHandler:resetNpc(cid)
    return false
  end
  if not isWorthy then
    npcHandler:say(player:getName() ..", you are yet to grow in strength before you can receive my blessing", cid)
    npcHandler:resetNpc(cid)
    return false
  end
  
  npcHandler:setMessage(MESSAGE_GREET, player:getName() ..", are you prepared to receive my blessing of the Rogue ?")

	return true
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	if npcHandler.topic[cid] == 0 then
		if msgcontains(msg, "yes") then
      player:setVocation(Vocation(GameConfig.Vocations[config.npcAllowedVocation].vocationId))
      local targetVocation = GameConfig.Vocations[config.npcAllowedVocation]
      for i = 1, #targetVocation[1] do
        player:addItem(targetVocation[1][i][1], targetVocation[1][i][2])
      end
      local backpack = player:addItem(1988)
      for i = 1, #targetVocation[2] do
        backpack:addItem(targetVocation[2][i][1], targetVocation[2][i][2])
      end
      player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have received a backpack with starting items.")
      npcHandler:say(GameConfig.Vocations[config.npcAllowedVocation].text, cid)
			npcHandler.topic[cid] = 1
		end
  end

	return true
end



npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:setMessage(MESSAGE_FAREWELL, "...")
npcHandler:setMessage(MESSAGE_WALKAWAY, "...")
npcHandler:addModule(FocusModule:new())