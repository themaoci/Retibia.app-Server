local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local config = {
  npcAllowedVocation = "mage"
}

function onCreatureAppear(cid)			    npcHandler:onCreatureAppear(cid)			    end
function onCreatureDisappear(cid)		    npcHandler:onCreatureDisappear(cid)			  end
function onCreatureSay(cid, type, msg)  npcHandler:onCreatureSay(cid, type, msg)  end
function onThink()				              npcHandler:onThink()					            end

local function greetCallback(cid)
	local player = Player(cid)
  local mlevel = player:getMagicLevel()
  local vocation = player:getVocation():getId()
  
  if vocation ~= 0 then
    npcHandler:say(player:getName() ..", you already received the blessing. i can't help you more.", cid)
    npcHandler:resetNpc(cid)
    return false
  end
  if mlevel <= 0 then
    npcHandler:say(player:getName() ..", you are yet to grow in strength before you can receive my blessing", cid)
    npcHandler:resetNpc(cid)
    return false
  end
  
  npcHandler:setMessage(MESSAGE_GREET, player:getName() ..", are you prepared to receive my blessing of the Mage ?")

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