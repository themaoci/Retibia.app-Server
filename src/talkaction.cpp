/**
 * The Forgotten Server - a free and open-source MMORPG server emulator
 * Copyright (C) 2019  Mark Samman <mark.samman@gmail.com>
 * Copyright (C) 2019-2021  Saiyans King
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#include "otpch.h"

#include "player.h"
#include "talkaction.h"
#include "pugicast.h"

TalkActions::TalkActions()
	: scriptInterface("TalkAction Interface")
{
	scriptInterface.initState();
	talkActions.reserve(100);
}

TalkActions::~TalkActions()
{
	clear(false);
}

void TalkActions::clear(bool fromLua)
{
	for (auto it = talkActions.begin(); it != talkActions.end(); ) {
		if (fromLua == it->second->fromLua) {
			it = talkActions.erase(it);
		} else {
			++it;
		}
	}

	reInitState(fromLua);
}

LuaScriptInterface& TalkActions::getScriptInterface()
{
	return scriptInterface;
}

std::string TalkActions::getScriptBaseName() const
{
	return "talkactions";
}

Event_ptr TalkActions::getEvent(const std::string& nodeName)
{
	if (strcasecmp(nodeName.c_str(), "talkaction") != 0) {
		return nullptr;
	}
	return Event_ptr(new TalkAction(&scriptInterface));
}

bool TalkActions::registerEvent(Event_ptr event, const pugi::xml_node&)
{
	TalkAction_ptr talkAction{ static_cast<TalkAction*>(event.release()) }; // event is guaranteed to be a TalkAction
	std::vector<std::string>& wordsMap = talkAction->getWordsMap();
	if (!wordsMap.empty()) {
		for (std::string& words : wordsMap) {
			auto result = talkActions.emplace(words, talkAction);
			if (!result.second) {
				std::cout << "[Warning - Spells::registerEvent] Duplicate registered talkaction(" << ((talkAction->scripted) ? "script" : "xml") << ") with words: '" << words << "' script: " << talkAction->GetScriptName() << " | Check if you dont have any ; at the end of word commands it will load command as empty" << std::endl;
			}
		}
		wordsMap.clear();
		wordsMap.shrink_to_fit();
	}
	return true;
}

bool TalkActions::registerLuaEvent(TalkAction_ptr& event)
{
	bool result = false;

	std::vector<std::string>& wordsMap = event->getWordsMap();
	if (!wordsMap.empty()) {
		for (std::string& words : wordsMap) {
			auto res = talkActions.emplace(words, event);
			if (!res.second) {
				std::cout << "[Warning - Spells::registerEvent] Duplicate registered talkaction with words: " << words << std::endl;
				continue;
			}
			result = true;
		}
		wordsMap.clear();
		wordsMap.shrink_to_fit();
	}
	return result;
}

TalkActionResult_t TalkActions::playerSaySpell(Player* player, SpeakClasses type, const std::string& words) const
{
	std::string param, instantWords = words;
	if (instantWords.size() >= 3 && instantWords.front() != ' ') {
		size_t param_find = instantWords.find(' ');
		if (param_find != std::string::npos) {
			param = instantWords.substr(param_find + 1);
			instantWords = instantWords.substr(0, param_find);
			trim_right(instantWords, ' ');
		}
	}

	auto it = talkActions.find(instantWords);
	if (it != talkActions.end()) {
		char separator = it->second->getSeparator();
		if (separator != ' ' && !param.empty()) {
			return TALKACTION_CONTINUE;
		}

		if (it->second->executeSay(player, instantWords, param, type)) {
			return TALKACTION_CONTINUE;
		} else {
			return TALKACTION_BREAK;
		}
	}
	return TALKACTION_CONTINUE;
}

bool TalkAction::configureEvent(const pugi::xml_node& node)
{
	pugi::xml_attribute wordsAttribute = node.attribute("words");
	if (!wordsAttribute) {
		std::cout << "[Error - TalkAction::configureEvent] Missing words for talk action or spell" << std::endl;
		return false;
	}

	pugi::xml_attribute separatorAttribute = node.attribute("separator");
	if (separatorAttribute) {
		separator = pugi::cast<char>(separatorAttribute.value());
	}

	for (std::string& word : explodeString(wordsAttribute.as_string(), ";")) {
		setWords(std::move(word));
	}
	return true;
}

std::string TalkAction::getScriptEventName() const
{
	return "onSay";
}

bool TalkAction::executeSay(Player* player, const std::string& word, const std::string& param, SpeakClasses type) const
{
	//onSay(player, words, param, type)
	if (!scriptInterface->reserveScriptEnv()) {
		std::cout << "[Error - TalkAction::executeSay] Call stack overflow" << std::endl;
		return false;
	}

	ScriptEnvironment* env = scriptInterface->getScriptEnv();
	env->setScriptId(scriptId, scriptInterface);

	lua_State* L = scriptInterface->getLuaState();

	scriptInterface->pushFunction(scriptId);

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	LuaScriptInterface::pushString(L, word);
	LuaScriptInterface::pushString(L, param);
	lua_pushnumber(L, type);

	return scriptInterface->callFunction(4);
}
