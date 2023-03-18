local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
npcHandler.rats = {}
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

-- CONDITIONALS -- 

-- Greeting and Farewell
local hiKeyword = keywordHandler:addGreetKeyword({'hi'}, {npcHandler = npcHandler, text = 'Hello, |PLAYERNAME|. Welcome to the Academy of Rookgaard. May I sign you up as a {student}?'})
	hiKeyword:addChildKeyword({'student'}, StdModule.say, {npcHandler = npcHandler, text = 'Brilliant! We need fine adventurers like you! If you are ready to learn, just ask me for a lesson. You can always ask for the differently coloured words - such as this one - to continue the lesson.', reset = true})
	hiKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Brilliant! We need fine adventurers like you! If you are ready to learn, just ask me for a lesson. You can always ask for the differently coloured words - such as this one - to continue the lesson.', reset = true})
	-- hiKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'Only nonsense on your mind, eh?', reset = true})
keywordHandler:addAliasKeyword({'hello'})

keywordHandler:addFarewellKeyword({'bye'}, {npcHandler = npcHandler, text = 'Good bye, |PLAYERNAME|! And remember: No running up and down in the academy!'})
keywordHandler:addAliasKeyword({'farewell'})

-- Rats
local ratsKeyword = keywordHandler:addKeyword({'%d+', 'dead', 'rat'}, StdModule.say, {npcHandler = npcHandler},
	function(player, data) npcHandler.rats[player.uid] = data[1] return data[1] and data[1] > 0 and data[1] < 0xFFFFFFFF end,
	function(player)
		npcHandler:say(string.format('Have you brought %d dead rats to me to pick up your reward?', npcHandler.rats[player.uid]), player.uid)
	end)
	ratsKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Thank you! Here is your reward.', reset = true},
		function(player) return player:getItemCount(2813) >= npcHandler.rats[player.uid] end,
		function(player) player:removeItem(2813, npcHandler.rats[player.uid]) player:addMoney(20 * npcHandler.rats[player.uid]) end
	)
	ratsKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'HEY! You don\'t have so many!', reset = true})
	ratsKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'Go and find some rats to kill!', reset = true})

local ratKeyword = keywordHandler:addKeyword({'dead', 'rat'}, StdModule.say, {npcHandler = npcHandler, text = 'Have you brought a dead rat to me to pick up your reward?'})
	ratKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Thank you! Here is your reward.', reset = true},
		function(player) return player:getItemCount(2813) > 0 end,
		function(player) 
			player:removeItem(2813, 1) 
			player:addMoney(20) 
		end
	)
	ratKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'HEY! You don\'t have one! Stop playing tricks on me or I\'ll give you some extra work!', reset = true})
	ratKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'Go and find some rats to kill!', reset = true})

-- Quest -- Present box - 7001
local boxKeyword = keywordHandler:addKeyword({'box'}, StdModule.say, {npcHandler = npcHandler, text = 'Do you have a suitable present box for me?'})
	boxKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'THANK YOU! Here is a helmet that will serve you well.', reset = true},
		function(player) return player:getStorageValue(7001) < 1 and player:getItemCount(1990) > 0 end,
		function(player) 
			player:removeItem(1990, 1) 
			player:addItem(2480, 1) 
			if player:getStorageValue(7001) < 1 then 
				player:setStorageValue(7001, 1)
			end
		end)
	boxKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'You already gave me the present box.', reset = true},
		function(player) return player:getStorageValue(7001) == 1 end)
	boxKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'HEY! You don\'t have one! Stop playing tricks on me or I\'ll give you some extra work!', reset = true})

-- keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, text = 'Well, I would like to send our king a little present but I do not have a suitable box. If you find a nice box, please bring it to me.'},
-- 	function(player) return player:getLevel() >= 4 end)
-- keywordHandler:addAliasKeyword({'quest'})
-- keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, text = 'You are pretty inexperienced. I think killing rats is a suitable challenge for you. For each fresh {dead rat} I will give you two shiny coins of gold.'})
-- keywordHandler:addAliasKeyword({'quest'})

keywordHandler:addKeyword({'fuck'}, StdModule.say, {npcHandler = npcHandler, text = 'For this remark I will wash your mouth with soap, young lady!'},
	function(player) return player:getSex() == PLAYERSEX_FEMALE end,
	function(player) player:getPosition():sendMagicEffect(CONST_ME_YELLOW_RINGS) end)
keywordHandler:addKeyword({'fuck'}, StdModule.say, {npcHandler = npcHandler, text = 'For this remark I will wash your mouth with soap, young man!'}, nil,
	function(player) player:getPosition():sendMagicEffect(CONST_ME_YELLOW_RINGS) end)

-- STATICS -- 
local StaticResponsesTable = {
	{ keyword = {'island', 'of', 'destiny'}, text = 'This is an island with {vocation} teachers. You can learn all about the different vocations there once you are level 8.' },
	{ keyword = {'time'}, text = 'It\'s |TIME|, so you are late. Hurry!' },
	{ keyword = {'name'}, text = 'My name is Seymour, but for you I am \'Sir\' Seymour.' },
	{ keyword = {'sir'}, text = 'At least you know how to address a man of my importance.' },
	{ keyword = {'job'}, text = 'I\'m the master of this fine {academy}, giving {lessons} to my students.' },
	{ keyword = {'lesson'}, text = 'Oh, which lesson did you want to attend again? Was it {Rookgaard}, {fighting}, {equipment}, {citizens}, the {academy} or the {oracle}?' },
	{ keyword = {'bank'}, text = 'In a bank you can deposit your earned gold coins safely. Just go downstairs to {Paulie} and ask him to {deposit} your money.' },
	{ keyword = {'deposit'}, text = 'Yes, depositing your money will keep it safe, so it is a good idea to store it in the bank. Of course, you can always withdraw it again.' },
	{ keyword = {'how', 'are', 'you'}, text = 'Well, the {king} doesn\'t send troops anymore, the {academy} is dreadfully low on money, and the end of the world is pretty nigh. Apart from that I\'m reasonably fine, I suppose.' },
	{ keyword = {'citizen'}, text = 'Most of the citizens here are {merchants}. You can give me the name of any non-player character and I will tell you something about him or her.' },
	{ keyword = {'merchant'}, text = 'Merchants buy and sell goods. Just ask them for a {trade} to see what they offer or buy from you.' },
	{ keyword = {'troll'}, text = 'Trolls are quite nasty monsters which you shouldn\'t face before level 3 or 4 depending on your {equipment}. Ask the bridge {guards} for their locations!' },
	{ keyword = {'guard'}, text = 'The guards {Dallheim} and {Zerbrus} protect our village from {monsters} trying to enter. They also mark useful {dungeon} locations on your map.' },
	{ keyword = {'vocation'}, text = 'There are four vocations: {knights}, {paladins}, {sorcerers} and {druids}. You can choose your vocation once you are level 8 and have talked to the {oracle}.' },
	{ keyword = {'sorcerer'}, text = 'Sorcerers are talented elemental magicians. You will learn all about them once you are level 8 and reached the Island of {Destiny}.' },
	{ keyword = {'knight'}, text = 'Knights are strong melee fighters. You will learn all about them once you are level 8 and reached the Island of {Destiny}.' },
	{ keyword = {'druid'}, text = 'Druids are nature magic users and great healers. You will learn all about them once you are level 8 and reached the Island of {Destiny}.' },
	{ keyword = {'paladin'}, text = 'Paladins are swift distance fighters. You will learn all about them once you are level 8 and reached the Island of {Destiny}.' },
	{ keyword = {'shop'}, text = 'We have a {weapon} and an {armor} shop south of the academy. {Equipment} such as {ropes} are sold to the north-west. {Potions} can be bought to the south. And then there are the {farms}.' },
	{ keyword = {'tibia'}, text = 'The world of Tibia is very large with tons of places to explore. Vast deserts, Caribbean islands, deep jungles, green meadows and jagged mountains await you!' },
	{ keyword = {'temple'}, text = 'The temple is the place to go when you are very low on {health} or poisoned. Ask {Cipfried} for a heal - he usually notices emergencies by himself.' },
	{ keyword = {'health'}, text = 'Your current health is shown by the red bar on the right side. {Death} awaits you if it goes down to zero.' },
	{ keyword = {'death'}, text = 'Dying in Tibia is painful, so try to avoid it. You will lose part of your {experience} points and also equipment. Make sure your {health} always stays up!' },
	{ keyword = {'experience'}, text = 'You gain experience when fighting {monsters}. You can take a look at your skill window to check your progress.' },
	{ keyword = {'monster'}, text = 'Good monsters to start hunting are {rats}. They live in the {sewers} below the village.' },
	{ keyword = {'sewer'}, text = 'One entrance to the sewers is south of this {academy}. Look for a sewer grate, then use it to climb down.' },
	{ keyword = {'academy'}, text = 'The academy is the building you are standing in. We have a {library}, a {bank} and the room of the {oracle}.' },
	{ keyword = {'library'}, text = 'There are many books in the bookcases around you, unless some naughty kids stole them again. Read them for more and detailed information.' },
	{ keyword = {'equip'}, text = 'Don\'t go hunting without proper equipment. You need at least a suitable {weapon}, {armor}, {shield}, {rope} and {shovel}. A {torch} is also good as well as {legs}, a {helmet} and {shoes}.' },
	{ keyword = {'money'}, text = 'Make money by killing {monsters} and picking up their {loot}. You can sell many of the things they carry.' },
	{ keyword = {'loot'}, text = 'Once a monster is dead, you can select \'Open\' on the {corpse} to check what\'s inside. Sometimes they carry {money} or other items which you can sell to {merchants}.' },
	{ keyword = {'corpse'}, text = 'You can even sell some corpses! For example, you can sell fresh dead rats to {Tom} the tanner or me. He also buys other dead creatures, just ask him for a {trade}.' },
	{ keyword = {'rope'}, text = 'You definitely need a rope to progress in dungeons, else you might end up stuck. Buy one from {Al Dee} or {Lee\'Delle}.' },
	{ keyword = {'shovel'}, text = 'A shovel is needed to dig some {dungeon} entrances open. \'Use\' it on a loose stone pile to make a hole large enough to enter.' },
	{ keyword = {'dungeon'}, text = 'You should not descend into dungeons without proper {equipment}. Once you are all prepared, ask the bridge {guards} for suitable {monsters}.' },
	{ keyword = {'torch'}, text = 'A torch will provide you with light in dark {dungeons}. \'Use\' it to light it. You can buy them from {Al Dee} or {Lee\'Delle}.' },
	{ keyword = {'student'}, text = 'Well, I could give you valuable {lessons} or some general {hints} about the game, or a small {quest} if you\'re interested.' },
	{ keyword = {'armor'}, text = 'The starter armor, a coat, does not protect you well. First of all, earn some money and try to get a sturdy leather armor from {Dixi}\'s  or {Lee\'Delle}\'s shop. Simply ask for a {trade}.' },
	{ keyword = {'weapon'}, text = 'The starter weapon, a club, won\'t get you far. You should earn some {money} and buy a better weapon such as a sabre from {Obi}\'s or {Lee\'Delle}\'s shop. Simply ask for a {trade}.' },
	{ keyword = {'helmet'}, text = 'A sturdy leather helmet is a good choice for a beginner. You can either buy it from {Dixi} and {Lee\'Delle}, or, once you are strong enough, {loot} them from {trolls}.' },
	{ keyword = {'shield'}, text = 'I fear you have to buy your first shield by yourself. A wooden shield from {Dixi} or {Lee\'Delle} is a good choice.' },
	{ keyword = {'shoe'}, text = 'Leather boots are basic shoes which will protect you well. You can either buy them from {Dixi} and {Lee\'Delle}, or, once you are strong enough, {loot} them from {trolls}.' },
	{ keyword = {'leg'}, text = 'Leather legs might be a good basic protection. You can buy them from {Dixi} or {Lee\'Delle}. Or, once you are strong enough, hunt {trolls}. They sometimes carry them in their {loot}.' },
	{ keyword = {'food'}, text = 'Many monsters, such as rabbits or deer, are excellent food providers. You can also buy food from {Willie} or {Billy}, the farmers.' },
	{ keyword = {'premium'}, text = 'Paying for your Tibia account will turn it into a premium account. This means access to more areas and functions of the game as well as other neat features.' },
	{ keyword = {'king'}, text = 'Hail to King Tibianus! Long live our king! Not that he cares for an old veteran who is stuck on this godforsaken island...' },
	{ keyword = {'potion'}, text = 'Use a small health potion in case of emergencies to fill up around 75 health points. You can buy them at {Lily}\'s shop. She also has {antidote} potions.' },
	{ keyword = {'antidote'}, text = 'Some monsters poison you. To heal poison, use an antidote potion on yourself. Buy them at {Lily}\'s store.' },
	{ keyword = {'rookgaard'}, text = 'Rookgaard is the name of this {village} as well as of the whole {island}. It belongs to the kingdom of {Thais}, in our world which is called {Tibia}.' },
	{ keyword = {'island'}, text = 'The island is separated into a {premium} side and a non-premium side. On both sides you will find {dungeons}, but the premium side tends to be a little less crowded with other players.' },
	{ keyword = {'thais'}, text = 'The city of Thais is reigned by King Tibianus. Of course, there are many other cities but you will learn about them later.' },
	{ keyword = {'village'}, text = 'The most important places in this village are the {temple}, the different {shops}, the {academy} and the {bridges}.' },
	{ keyword = {'bridge'}, text = 'There is a bridge to the north and one to the west which lead outside the village. You should only leave once you are well {equipped} and at least level 2.' },
	{ keyword = {'main'}, text = 'You can leave for mainland once you are level 8. To do so talk to the {oracle}.' },
	{ keyword = {'fighting'}, text = 'You have to fight {monsters} to train your {skills} and {level}. If you lose {health}, eat {food} to regain it or use a {potion}.' },
	{ keyword = {'skill'}, text = 'The more you fight with a weapon, the better will be your skill handling this weapon. Don\'t worry about that right now though, this will become important once you have a {vocation}.' },
	{ keyword = {'level'}, text = 'Once you gained enough experience for a level, you will advance. This means - among other things - more {health} points, a faster walking speed and more strength to carry things.' },
	{ keyword = {'farm'}, text = 'The farms are west of here. You can buy and sell {food} there which you need to regain {health}.' },
	{ keyword = {'rat'}, text = 'To attack a rat, simply click on it in your battle list. Make sure that you have proper {equipment}, though! Also, I give you 2 gold coins for each {dead rat}.' },
	{ keyword = {'trade'}, text = 'I personally don\'t have anything to trade, but you can ask {merchants} for a trade. That will open a window where you can see their offers and the things they buy from you.' },
	{ keyword = {'destiny'}, text = 'Well, like ... (cough) (cough) What i was talking about ? Oh right ... Make sure your {health} always stays up!' },
	-- names --
	{ keyword = {'obi'}, text = 'Obi sells and buys {weapons}. You can find his shop south of the academy.'},
	{ keyword = {'norma'}, text = 'Norma has recently opened a bar here meaning she sells drinks and snacks. Nothing of importance to you, young student.' },
	{ keyword = {'loui'}, text = 'Oh, let\'s not talk about Loui.' },
	{ keyword = {'santiago'}, text = 'A fine and helpful man. Without him, many new adventurers would be quite clueless.' },
	{ keyword = {'zirella'}, text = 'This is Tom the tanner\'s mother. Other than that, I don\'t think she is of importance.' },
	{ keyword = {'al', 'dee'}, text = 'Al Dee has a general {equipment} store in the north-western part of the village. He sells useful stuff such as {ropes}.' },
	{ keyword = {'amber'}, text = 'A traveller from the {main} continent. I wonder what brought her here. No one comes here of his own free will.' },
	{ keyword = {'billy'}, text = 'Billy is {Willie}\'s cousin, but he has his farm on the {premium} side of the village.' },
	{ keyword = {'willie'}, text = 'Willie is a fine farmer, although he is short-tempered. He sells and buys {food}.' },
	{ keyword = {'cipfried'}, text = 'A humble monk living in the {temple} south of here. He can heal you if you are wounded or poisoned.' },
	{ keyword = {'dixi'}, text = 'Dixi sells and buys {armors}, {shields}, {helmets} and {legs}. You can find her shop south of the academy, just go up the stairs in {Obi}\'s shop.' },
	{ keyword = {'hyacinth'}, text = 'A mysterious druid who lives somewhere in the wilderness. He sells small health {potions} just like {Lily}.' },
	{ keyword = {'lee\'delle'}, text = 'Lee\'Delle\'s shop is in the western part of town, on the {premium} side. She sells everything cheaper.' },
	{ keyword = {'lily'}, text = 'In the southern part of town, Lily sells {potions} which might come in handy once you are deep in a dungeon and need {health}.' },
	{ keyword = {'oracle'}, text = 'The oracle is a mysterious being just upstairs. It will bring you to the {Island of Destiny} to choose your {vocation} once you are level 8.' },
	{ keyword = {'paulie'}, text = 'Yes, Paulie is very important. He is the local {bank} clerk.' },
	{ keyword = {'seymour'}, text = 'Sir Seymour, yes, that\'s me.' },
	{ keyword = {'tom'}, text = 'Tom the tanner buys fresh {corpses}, minotaur leather and paws. Always good to make some {money} if you can carry the corpses there fast enough.' },
	{ keyword = {'dallheim'}, text = 'He\'s the guard on the north {bridge} and a great fighter. He can show you {monster} locations. Just ask him about monsters!' },
	{ keyword = {'zerbrus'}, text = 'I don\'t know much about him he moved here not too long ago. I think he was a Mage of some sorts... propably you could learn spells from him if you ask him politely.' },
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

-- Basic keywords
keywordHandler:addKeyword({'hint'}, StdModule.rookgaardHints, {npcHandler = npcHandler})

keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, text = 'Well, I could give you valuable {lessons} or some general {hints} about the game, or a small {quest} if you\'re interested.'})
keywordHandler:addAliasKeyword({'information'})

npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye! And remember: No running up and down in the academy!')

npcHandler:addModule(FocusModule:new())
