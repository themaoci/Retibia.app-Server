local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)	npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()						npcHandler:onThink()						end

local voices = {
	{ text = 'Buying fresh corpses of rats, rabbits and wolves.' },
	{ text = 'Oh yeah, I\'m also interested in wolf paws and bear paws.' },
	{ text = 'Also buying minotaur leather.' }
}
npcHandler:addModule(VoiceModule:new(voices))

-- Greeting and Farewell
keywordHandler:addGreetKeyword({'hi'}, {npcHandler = npcHandler, text = 'Hey there, |PLAYERNAME|. I\'m Tom the tanner. If you have fresh {corpses}, leather, paws or other animal body parts, {trade} with me.'})
keywordHandler:addAliasKeyword({'hello'})
keywordHandler:addFarewellKeyword({'bye'}, {npcHandler = npcHandler, text = 'Good hunting, child.'}, function(player) return player:getSex() == PLAYERSEX_FEMALE end)
keywordHandler:addAliasKeyword({'farewell'})
keywordHandler:addFarewellKeyword({'bye'}, {npcHandler = npcHandler, text = 'Good hunting, son.'})
keywordHandler:addAliasKeyword({'farewell'})

-- Basic keywords
keywordHandler:addKeyword({'hint'}, StdModule.rookgaardHints, {npcHandler = npcHandler})

local StaticResponsesTable = {
	--{ keyword = , aliases = {}, text =  },
	{ keyword = {'name'}, aliases = {}, text = 'My name is Tom the tanner.\nI\'m the local {tanner}. I buy fresh animal {corpses}, tan them, and convert them into fine leather clothes which I then sell to {merchants}.' },
	{ keyword = {'merchant'}, aliases = {}, text = '{Dixi} and {Lee\'Delle} sell my leather clothes in their shops.' },
	{ keyword = {'tanner'}, aliases = {}, text = 'That\'s my job. It can be dirty at times but it provides enough income for my living.' },
	{ keyword = {'information'}, aliases = {}, text = 'Do I look like a tourist information centre? Go ask someone else.' },
	{ keyword = {'help'}, aliases = {}, text = 'Help? I will give you a few gold coins if you have some fresh dead {animals} for me. Note the word {fresh}.' },
	{ keyword = {'fresh'}, aliases = {}, text = 'Fresh means: shortly after their death.' },
	{ keyword = {'how', 'are', 'you'}, aliases = {}, text = 'Much to do these days.' },
	{ keyword = {'monster'}, aliases = {}, text = 'Good monsters to start with are rats. They live in the {sewers} under the village of {Rookgaard}.' },
	{ keyword = {'dungeon'}, aliases = {}, text = 'Dungeons can be dangerous without proper {equipment}.' },
	{ keyword = {'equipment'}, aliases = {}, text = 'You need at least a {backpack}, a {rope}, a {shovel}, a {weapon}, an {armor} and a {shield}.' },
	{ keyword = {'time'}, aliases = {}, text = 'Sorry, I haven\'t been outside for a while, so I don\'t know.' },
	{ keyword = {'troll'}, aliases = {}, text = 'Troll leather stinks. Can\'t use it.' },
	{ keyword = {'orc'}, aliases = {}, text = 'I don\'t buy orcs. Their skin is too scratchy.' },
	{ keyword = {'human'}, aliases = {}, text = 'Are you crazy?!', ungreet = true },
	{ keyword = {'backpack'}, aliases = {{'rope'}}, text = 'Nope, sorry, don\'t sell that. Go see {Al Dee} or {Lee\'Delle}.' },
	{ keyword = {'armor'}, aliases = {{'shield'}}, text = 'Nope, sorry, don\'t sell that. Ask {Dixi} or {Lee\'Delle}.' },
	{ keyword = {'weapon'}, aliases = {}, text = 'Nope, sorry, don\'t sell that. Ask {Obi} or {Lee\'Delle}.' },
	{ keyword = {'corpse'}, aliases = {{'wares'},{'animal'},{'sell'},{'buy'},{'offer'}}, text = 'I\'m buying fresh {corpses} of rats, rabbits and wolves. I don\'t buy half-decayed ones. If you have any for sale, {trade} with me.' },
	{ keyword = {'al', 'dee'}, aliases = {}, text = 'He\'s an apple polisher.' },
	{ keyword = {'amber'}, aliases = {}, text = 'Now that\'s an interesting woman.' },
	{ keyword = {'billy'}, aliases = {}, text = 'He\'s a better cook than his cousin {Willie}, actually.' },
	{ keyword = {'willie'}, aliases = {}, text = 'I kinda like him. At least he says what he thinks.' },
	{ keyword = {'tom'}, aliases = {}, text = 'Yep.' },
	{ keyword = {'seymour'}, aliases = {}, text = 'He sticks his nose too much in books.' },
	{ keyword = {'zirella'}, aliases = {}, text = 'My mother?? Did you meet my mother??' },
	{ keyword = {'santiago'}, aliases = {}, text = 'I don\'t have a problem with him.' },
	{ keyword = {'paulie'}, aliases = {}, text = 'Typical pencil pusher.' },
	{ keyword = {'oracle'}, aliases = {}, text = 'It\'s in the academy, just above Seymour. Go there once you are level 8 to leave this place.' },
	{ keyword = {'obi'}, aliases = {}, text = 'He is such a hypocrite.' },
	{ keyword = {'norma'}, aliases = {}, text = 'I like her beer.' },
	{ keyword = {'dixi'}, aliases = {}, text = 'She buys my fine leather clothes.' },
	{ keyword = {'loui'}, aliases = {}, text = 'I wonder what spectacular monsters he has found.' },
	{ keyword = {'lee\'delle'}, aliases = {}, text = 'Her nose is a little high in the air, I think. She never shakes my hand.' },
	{ keyword = {'hyacinth'}, aliases = {}, text = 'I wonder if he\'s angry because his potion monopoly fell.' },
	{ keyword = {'cipfried'}, aliases = {}, text = 'I\'m not what you\'d call a \'believer\'.' },
	{ keyword = {'dallheim'}, aliases = {}, text = 'He\'s okay.' },
	{ keyword = {'zerbrus'}, aliases = {}, text = 'He\'s okay.' },
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

npcHandler:setMessage(MESSAGE_WALKAWAY, 'D\'oh?')
npcHandler:setMessage(MESSAGE_SENDTRADE, 'Sure, check what I buy.')

npcHandler:addModule(FocusModule:new())
