local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)		 end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)		 end
function onCreatureSay(cid, type, msg)	npcHandler:onCreatureSay(cid, type, msg) end
function onThink()						npcHandler:onThink()					 end


local currentVisitedPlayerBlessPrice = 100000
-- Healing
local function addHealKeyword(text, condition, effect)
	keywordHandler:addKeyword({'heal'}, StdModule.say, {npcHandler = npcHandler, text = text},
		function(player) return player:getCondition(condition) ~= nil end,
		function(player)
			player:removeCondition(condition)
			player:getPosition():sendMagicEffect(effect)
		end
	)
end
addHealKeyword('You are burning. Let me quench those flames.', CONDITION_FIRE, CONST_ME_MAGIC_GREEN)
addHealKeyword('You are poisoned. Let me soothe your pain.', CONDITION_POISON, CONST_ME_MAGIC_RED)
addHealKeyword('You are electrified, my child. Let me help you to stop trembling.', CONDITION_ENERGY, CONST_ME_MAGIC_GREEN)
keywordHandler:addKeyword({'heal'}, StdModule.say, {npcHandler = npcHandler, text = 'You are hurt, my child. I will heal your wounds.'},
	function(player) return player:getHealth() < 40 end,
	function(player)
		local health = player:getHealth()
		if health < 40 then player:addHealth(40 - health) end
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	end
)
keywordHandler:addKeyword({'heal'}, StdModule.say, {npcHandler = npcHandler, text = 'You aren\'t looking that bad. Sorry, I can\'t help you. But if you are looking for additional protection you should go on the {pilgrimage} of ashes or get the protection of the {twist of fate} here.'})

-- Embrace of Tibia
local blessKeyword = keywordHandler:addKeyword({'embrace'}, StdModule.say, {npcHandler = npcHandler, text = 'Would you like to receive that protection for a sacrifice of |BLESSCOST| gold, child?'})
	blessKeyword:addChildKeyword({'yes'}, StdModule.bless, {npcHandler = npcHandler, text = 'So receive the embrace of Tibia, pilgrim.', cost = '|BLESSCOST|', bless = 2})
	blessKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'Fine. You are free to decline my offer.', reset = true})

-- Fire of the Suns
local blessKeyword = keywordHandler:addKeyword({'suns'}, StdModule.say, {npcHandler = npcHandler, text = 'Would you like to receive that protection for a sacrifice of |BLESSCOST| gold, child?'})
blessKeyword:addChildKeyword({'yes'}, StdModule.bless, {npcHandler = npcHandler, text = 'So receive the fire of the suns, pilgrim.', cost = '|BLESSCOST|', bless = 3})
blessKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'Fine. You are free to decline my offer.', reset = true})
keywordHandler:addAliasKeyword({'fire'})

-- Spiritual Shielding
local blessKeyword = keywordHandler:addKeyword({'spiritual'}, StdModule.say, {npcHandler = npcHandler, text = 'Here in the whiteflower temple you may receive the blessing of spiritual shielding. But we must ask of you to sacrifice |BLESSCOST| gold. Are you still interested?'})
	blessKeyword:addChildKeyword({'yes'}, StdModule.bless, {npcHandler = npcHandler, text = 'So receive the shielding of your spirit, pilgrim.', cost = '|BLESSCOST|', bless = 1})
	blessKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'Fine. You are free to decline my offer.', reset = true})
keywordHandler:addAliasKeyword({'shield'})

npcHandler:setMessage(MESSAGE_WALKAWAY, 'See you soon.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'See you soon.')
npcHandler:setMessage(MESSAGE_GREET, 'Welcome, |PLAYERNAME|. How may I help you? Are you in need of {heal}ing? or maybe you need one of my blessings which are {spiritual} shielding, {embrace} of tibia or {fire} of the {suns} ?')

npcHandler:addModule(FocusModule:new())
