/**
 * The Forgotten Server - a free and open-source MMORPG server emulator
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

#include "modules.h"
#include "player.h"

#include "pugicast.h"
#include "networkmessage.h"

Modules::Modules() :
	scriptInterface("Module Interface")
{
	scriptInterface.initState();
}

bool Modules::load()
{
	pugi::xml_document doc;
	pugi::xml_parse_result result = doc.load_file("data/modules/modules.xml");
	if (!result) {
		printXMLError("Error - Events::load", "data/modules/modules.xml", result);
		return false;
	}

	modules.clear();

	std::map<std::string, int32_t> scripts;
	for (auto eventNode : doc.child("modules").children()) {
		pugi::xml_attribute attr;
		if ((attr = eventNode.attribute("versionmin"))) {
			uint32_t versionMin = pugi::cast<uint32_t>(attr.value());
			uint32_t versionMax = pugi::cast<uint32_t>(eventNode.attribute("versionmax").value());
			if (CLIENT_VERSION < versionMin || CLIENT_VERSION > versionMax) {
				continue;
			}
		} else if ((attr = eventNode.attribute("version"))) {
			uint32_t version = pugi::cast<uint32_t>(attr.value());
			if (CLIENT_VERSION < version) {
				continue;
			}
		}

		const std::string& scriptName = eventNode.attribute("script").as_string();
		const std::string& lowercase = asLowerCaseString(scriptName);

		int32_t scriptId = -1;
		auto it = scripts.find(lowercase);
		if (it != scripts.end()) {
			scriptId = it->second;
		} else {
			if (scriptInterface.loadFile("data/modules/scripts/" + lowercase) != 0) {
				std::cout << "[Warning - Modules::load] Can not load script: " << lowercase << std::endl;
				std::cout << scriptInterface.getLastLuaError() << std::endl;
			}

			scriptId = scriptInterface.getEvent("onRecvbyte");
			scripts[lowercase] = scriptId;
		}

		uint16_t byte = static_cast<uint16_t>(strtoul(eventNode.attribute("byte").as_string(), nullptr, 0));
		auto res = modules.emplace(static_cast<uint8_t>(byte), scriptId);
		if (!res.second) {
			std::cout << "[Warning - Modules::load] Duplicate registered module with byte: " << byte << std::endl;
		}
	}
	return true;
}

// Module
bool Modules::eventOnRecvByte(Player* player, uint8_t recvbyte, NetworkMessage& msg)
{
	auto it = modules.find(recvbyte);
	if (it == modules.end() || it->second == -1) {
		return false;
	}

	// onRecvbyte(player, msg, byte)
	if (!scriptInterface.reserveScriptEnv()) {
		std::cout << "[Error - Modules::eventOnRecvByte] Call stack overflow" << std::endl;
		return false;
	}

	ScriptEnvironment* env = scriptInterface.getScriptEnv();
	env->setScriptId(it->second, &scriptInterface);

	lua_State* L = scriptInterface.getLuaState();
	scriptInterface.pushFunction(it->second);

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	LuaScriptInterface::pushUserdata<NetworkMessage>(L, &msg);
	LuaScriptInterface::setWeakMetatable(L, -1, "NetworkMessage");

	lua_pushnumber(L, recvbyte);

	scriptInterface.callVoidFunction(3);
	return true;
}
