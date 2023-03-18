local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local voices = {
	{ text = 'Ah, what the heck.Make sure you know what you want before you bug me.' },
	{ text = 'Buying and selling food!' },
	{ text = 'Make sure you know what you want before you bug me.' },
	{ text = 'You, over there! Stop sniffing around my farm! Either trade with me or leave!' }
}
npcHandler:addModule(VoiceModule:new(voices))

-- Basic keywords
local StaticResponsesTable = {
	--{ keyword = , aliases = {}, text =  },
	{ keyword = {'offer'}, aliases = {{'sell'},{'buy'},{'food'}}, text = 'Haven\'t they taught you anything at school? Ask for a {trade} if you want to trade.' },
	{ keyword = {'information'}, aliases = {{'help'},{'hint'}}, text = 'Help yourself. Or ask the other {citizens}, I don\'t have time for that.' },
	{ keyword = {'how', 'are', 'you'}, aliases = {}, text = 'Fine enough.' },
	{ keyword = {'name'}, aliases = {}, text = 'Willie.' },
	{ keyword = {'job'}, aliases = {}, text = 'I\'m a farmer and a cook.' },
	{ keyword = {'cook'}, aliases = {}, text = 'I try out old and new {recipes}. You can sell all {food} to me.' },
	{ keyword = {'recipe'}, aliases = {}, text = 'I\'d love to try a banana pie but I lack the {bananas}. If you get me one, I\'ll reward you.' },
	{ keyword = {'citizen'}, aliases = {}, text = 'Which one?' },
	{ keyword = {'rookgaard'}, aliases = {}, text = 'This island would be wonderful if there weren\'t a constant flood of newcomers.' },
	{ keyword = {'tibia'}, aliases = {}, text = 'If I were you, I\'d stay here.' },
	{ keyword = {'spell'}, aliases = {}, text = 'I know how to spell.' },
	{ keyword = {'magic'}, aliases = {}, text = 'I\'m a magician in the kitchen.' },
	{ keyword = {'weapon'}, aliases = {}, text = 'I\'m not in the weapon business, so stop disturbing me.' },
	{ keyword = {'king'}, aliases = {}, text = 'I\'m glad that we don\'t see many officials here.' },
	{ keyword = {'sewer'}, aliases = {}, text = 'What about them? Do you live there?' },
	{ keyword = {'dungeon'}, aliases = {}, text = 'I\'ve got no time for your dungeon nonsense.' },
	{ keyword = {'rat'}, aliases = {}, text = 'My cousin {Billy} cooks rat stew. Yuck! Can you imagine that?' },
	{ keyword = {'monster'}, aliases = {}, text = 'Are you afraid of monsters? I bet even the sight of a {rat} would let your knees tremble. Hahaha.' },
	{ keyword = {'time'}, aliases = {}, text = 'Do I look like a clock?' },
	{ keyword = {'god'}, aliases = {}, text = 'I\'m a farmer, not a preacher.' },
	{ keyword = {'al', 'dee'}, aliases = {}, text = 'Can\'t stand him.' },
	{ keyword = {'amber'}, aliases = {}, text = 'Quite a babe.' },
	{ keyword = {'billy'}, aliases = {}, text = 'Don\'t ever mention his name again! He can\'t even {cook}!' },
	{ keyword = {'cipfried'}, aliases = {}, text = 'Our little monkey.' },
	{ keyword = {'dallheim'}, aliases = {}, text = 'Uhm, fine guy I think.' },
	{ keyword = {'dixi'}, aliases = {}, text = 'Boring little girl.' },
	{ keyword = {'hyacinth'}, aliases = {}, text = 'Overrated.' },
	{ keyword = {'lee\'delle'}, aliases = {}, text = 'She thinks she owns this island with her underpriced offers.' },
	{ keyword = {'lily'}, aliases = {}, text = 'I don\'t like hippie girls.' },
	{ keyword = {'loui'}, aliases = {}, text = 'Leave me alone with that guy.' },
	{ keyword = {'norma'}, aliases = {}, text = 'About time we got a bar here.' },
	{ keyword = {'obi'}, aliases = {}, text = 'This old guy has only money on his mind.' },
	{ keyword = {'oracle'}, aliases = {}, text = 'Hopefully it gets you off this island soon so you can stop bugging me.' },
	{ keyword = {'paulie'}, aliases = {}, text = 'Uptight and correct in any situation.' },
	{ keyword = {'santiago'}, aliases = {}, text = 'If he wants to sacrifice all his free time for beginners, fine with me. Then they don\'t disturb me.' },
	{ keyword = {'seymour'}, aliases = {}, text = 'This joke of a man thinks he is sooo important.' },
	{ keyword = {'tom'}, aliases = {}, text = 'Decent guy.' },
	{ keyword = {'willie'}, aliases = {}, text = 'Yeah, so?' },
	{ keyword = {'zerbrus'}, aliases = {}, text = 'Overrated.' },
	{ keyword = {'zirella'}, aliases = {}, text = 'Too old to be interesting for me.' },
}
for _, staticResp in ipairs(StaticResponsesTable) do
	-- redo this later
	local keywordParameters = {npcHandler = npcHandler, text = staticResp.text}
	if staticResp.ungreet ~= nil then
		keywordParameters['ungreet'] = staticResp.ungreet
	end
	keywordHandler:addKeyword(staticResp.keyword, StdModule.say, keywordParameters)
	if staticResp.aliases ~= nil then
		for _, alias in ipairs(staticResp.aliases) do
			keywordHandler:addAliasKeyword(alias)
		end
	end
end


-- Studded Shield Quest
local bananaKeyword = keywordHandler:addKeyword({'banana'}, StdModule.say, {npcHandler = npcHandler, text = 'Have you found a banana for me?'})
	bananaKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'A banana! Great. Here, take this shield, I don\'t need it anyway.', reset = true},
			function(player) return player:getItemCount(2676) > 0 end,
			function(player)
				player:removeItem(2676, 1)
				player:addItem(2526, 1)
			end
	)
	bananaKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Are you trying to mess with me?!', reset = true})
	bananaKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'Too bad.', reset = true})

npcHandler:setMessage(MESSAGE_WALKAWAY, 'Yeah go away!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Yeah, bye |PLAYERNAME|.')
npcHandler:setMessage(MESSAGE_SENDTRADE, 'Ya take a good look.')
npcHandler:setMessage(MESSAGE_GREET, 'Hiho |PLAYERNAME|. I hope you\'re here to {trade}.')

npcHandler:addModule(FocusModule:new())
