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

#ifndef FS_TALKACTION_H_E6AABAC0F89843469526ADF310F3131C
#define FS_TALKACTION_H_E6AABAC0F89843469526ADF310F3131C

#include "luascript.h"
#include "baseevents.h"
#include "const.h"

class TalkAction;
using TalkAction_ptr = std::shared_ptr<TalkAction>;

enum TalkActionResult_t {
	TALKACTION_CONTINUE,
	TALKACTION_BREAK,
	TALKACTION_FAILED,
};

class TalkAction : public Event
{
	public:
		explicit TalkAction(LuaScriptInterface* interface) : Event(interface) {}

		bool configureEvent(const pugi::xml_node& node) override;

		std::vector<std::string>& getWordsMap() {
			return wordsMap;
		}
		const std::string& getWords() const {
			return words;
		}
		void setWords(std::string word) {
			words = word;
			wordsMap.emplace_back(std::move(word));
		}
		char getSeparator() const {
			return separator;
		}
		void setSeparator(char sep) {
			separator = sep;
		}

		//scripting
		bool executeSay(Player* player, const std::string& word, const std::string& param, SpeakClasses type) const;
		//

	private:
		std::string getScriptEventName() const override;

		std::vector<std::string> wordsMap;
		std::string words;
		char separator = '"';
};

class TalkActions final : public BaseEvents
{
	public:
		TalkActions();
		~TalkActions();

		// non-copyable
		TalkActions(const TalkActions&) = delete;
		TalkActions& operator=(const TalkActions&) = delete;

		TalkActionResult_t playerSaySpell(Player* player, SpeakClasses type, const std::string& words) const;

		bool registerLuaEvent(TalkAction_ptr& event);
		void clear(bool fromLua) override final;

	private:
		LuaScriptInterface& getScriptInterface() override;
		std::string getScriptBaseName() const override;
		Event_ptr getEvent(const std::string& nodeName) override;
		bool registerEvent(Event_ptr event, const pugi::xml_node& node) override;
		
		#if GAME_FEATURE_ROBINHOOD_HASH_MAP > 0
		robin_hood::unordered_map<std::string, TalkAction_ptr> talkActions;
		#else
		std::unordered_map<std::string, TalkAction_ptr> talkActions;
		#endif

		LuaScriptInterface scriptInterface;
};

#endif
