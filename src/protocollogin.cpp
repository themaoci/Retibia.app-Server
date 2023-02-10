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

#include "protocollogin.h"

#include "outputmessage.h"
#include "tasks.h"

#include "configmanager.h"
#include "iologindata.h"
#include "ban.h"
#include "game.h"

extern ConfigManager g_config;
extern Game g_game;

void ProtocolLogin::disconnectClient(const std::string& message, uint32_t version)
{
	auto output = OutputMessagePool::getOutputMessage();
	output->addByte(version >= 1076 ? 0x0B : 0x0A);
	output->addString(message);
	send(output);

	disconnect();
}

#if GAME_FEATURE_SESSIONKEY > 0
void ProtocolLogin::getCharacterList(const std::string& accountName, const std::string& password, const std::string& token, uint32_t version)
#else
void ProtocolLogin::getCharacterList(const std::string& accountName, const std::string& password, uint32_t version)
#endif
{
	#if !(GAME_FEATURE_LOGIN_EXTENDED > 0)
	static uint32_t serverIp = INADDR_NONE;
	if (serverIp == INADDR_NONE) {
		std::string cfgIp = g_config.getString(ConfigManager::IP);
		serverIp = inet_addr(cfgIp.c_str());
		if (serverIp == INADDR_NONE) {
			struct hostent* he = gethostbyname(cfgIp.c_str());
			if (!he || he->h_addrtype != AF_INET) { //Only ipv4
				disconnectClient("ERROR: Cannot resolve hostname.", version);
				return;
			}
			memcpy(&serverIp, he->h_addr, sizeof(serverIp));
		}
	}
	#endif

	auto connection = getConnection();
	if (!connection) {
		return;
	}

	BanInfo banInfo;
	if (IOBan::isIpBanned(connection->getIP(), banInfo)) {
		if (banInfo.reason.empty()) {
			banInfo.reason = "(none)";
		}

		std::stringExtended ss(banInfo.bannedBy.length() + banInfo.reason.length() + static_cast<size_t>(64));
		ss << "Your IP has been banned until " << formatDateShort(banInfo.expiresAt) << " by " << banInfo.bannedBy << ".\n\nReason specified:\n" << banInfo.reason;
		disconnectClient(ss, version);
		return;
	}

	Account account;
	if (!IOLoginData::loginserverAuthentication(accountName, password, account)) {
		disconnectClient("Account name or password is not correct.", version);
		return;
	}

	auto output = OutputMessagePool::getOutputMessage();

	#if GAME_FEATURE_SESSIONKEY > 0
	uint32_t ticks = time(nullptr) / AUTHENTICATOR_PERIOD;
	if (!account.key.empty()) {
		if (token.empty() || !(token == generateToken(account.key, ticks) || token == generateToken(account.key, ticks - 1) || token == generateToken(account.key, ticks + 1))) {
			output->addByte(0x0D);
			output->addByte(0);
			send(output);
			disconnect();
			return;
		}
		output->addByte(0x0C);
		output->addByte(0);
	}
	#endif

	//Update premium days
	Game::updatePremium(account);

	//Check for MOTD
	const std::string& motd = g_config.getString(ConfigManager::MOTD);
	if (!motd.empty()) {
		//Add MOTD
		output->addByte(0x14);

		std::stringExtended ss(motd.length() + static_cast<size_t>(16));
		ss << g_game.getMotdNum() << "\n" << motd;
		output->addString(ss);
	}

	#if GAME_FEATURE_SESSIONKEY > 0
	//Add session key
	output->addByte(0x28);
	output->addString(accountName + "\n" + password + "\n" + token + "\n" + std::to_string(ticks));
	#endif

	//Add char list
	output->addByte(0x64);

	#if GAME_FEATURE_LOGIN_EXTENDED > 0
	output->addByte(1); // number of worlds

	output->addByte(0); // world id
	output->addString(g_config.getString(ConfigManager::SERVER_NAME));
	output->addString(g_config.getString(ConfigManager::IP));
	output->add<uint16_t>(g_config.getNumber(ConfigManager::GAME_PORT));
	output->addByte(0);

	uint8_t size = std::min<size_t>(std::numeric_limits<uint8_t>::max(), account.characters.size());
	output->addByte(size);
	for (uint8_t i = 0; i < size; i++) {
		output->addByte(0);
		output->addString(account.characters[i]);
	}
	#else
	uint8_t size = std::min<size_t>(std::numeric_limits<uint8_t>::max(), account.characters.size());
	output->addByte(size);
	for (uint8_t i = 0; i < size; i++) {
		output->addString(account.characters[i]);
		output->addString(g_config.getString(ConfigManager::SERVER_NAME));
		output->add<uint32_t>(serverIp);
		output->add<uint16_t>(g_config.getNumber(ConfigManager::GAME_PORT));
		#if GAME_FEATURE_PREVIEW_STATE > 0
		output->addByte(0);
		#endif
	}
	#endif

	//Add premium days
	#if GAME_FEATURE_LOGIN_PREMIUM_TIMESTAMP > 0
	#if GAME_FEATURE_LOGIN_PREMIUM_TYPE > 0
	output->addByte(0);
	#endif
	if (g_config.getBoolean(ConfigManager::FREE_PREMIUM)) {
		output->addByte(1);
		output->add<uint32_t>(0);
	} else {
		output->addByte(account.premiumDays > 0 ? 1 : 0);
		output->add<uint32_t>(time(nullptr) + (account.premiumDays * 86400));
	}
	#else
	if (g_config.getBoolean(ConfigManager::FREE_PREMIUM)) {
		output->add<uint16_t>(0xFFFF); //client displays free premium
	} else {
		output->add<uint16_t>(account.premiumDays);
	}
	#endif

	send(output);

	disconnect();
}

void ProtocolLogin::onRecvFirstMessage(NetworkMessage& msg)
{
	if (g_game.getGameState() == GAME_STATE_SHUTDOWN) {
		disconnect();
		return;
	}

	msg.skipBytes(2); // client OS

	uint32_t clientVersion = static_cast<uint32_t>(msg.get<uint16_t>());
	if (clientVersion >= 971) {
		clientVersion = msg.get<uint32_t>();
		msg.skipBytes(13);
	} else {
		msg.skipBytes(12);
	}
	/*
	 * Skipped bytes:
	 * 4 bytes: protocolVersion(971+)
	 * 12 bytes: dat, spr, pic signatures (4 bytes each)
	 * 1 byte: preview world(971+)
	 */

	if (clientVersion >= 770) {
		if (!Protocol::RSA_decrypt(msg)) {
			disconnect();
			return;
		}

		uint32_t key[4] = {msg.get<uint32_t>(), msg.get<uint32_t>(), msg.get<uint32_t>(), msg.get<uint32_t>()};
		enableXTEAEncryption();
		setXTEAKey(key);

		if (clientVersion >= 830) {
			setChecksumMethod(CHECKSUM_METHOD_ADLER32);
		}
	}

	if (clientVersion != CLIENT_VERSION) {
		std::stringExtended ss(64);
		ss << "Only clients with protocol " << CLIENT_VERSION_UPPER << "." << CLIENT_VERSION_LOWER << " allowed!";
		disconnectClient(ss, clientVersion);
		return;
	}

	if (g_game.getGameState() == GAME_STATE_STARTUP) {
		disconnectClient("Gameworld is starting up. Please wait.", clientVersion);
		return;
	}

	if (g_game.getGameState() == GAME_STATE_MAINTAIN) {
		disconnectClient("Gameworld is under maintenance.\nPlease re-connect in a while.", clientVersion);
		return;
	}

	#if GAME_FEATURE_ACCOUNT_NAME > 0
	std::string accountName = msg.getString();
	#else
	std::string accountName = std::to_string(msg.get<uint32_t>());
	#endif
	if (accountName.empty()) {
		disconnectClient("Invalid account name.", clientVersion);
		return;
	}

	std::string password = msg.getString();
	if (password.empty()) {
		disconnectClient("Invalid password.", clientVersion);
		return;
	}

	#if GAME_FEATURE_SESSIONKEY > 0
	// read authenticator token and stay logged in flag from last 128 bytes
	msg.skipBytes((msg.getLength() - 128) - msg.getBufferPosition());
	if (!Protocol::RSA_decrypt(msg)) {
		disconnectClient("Invalid authentification token.", clientVersion);
		return;
	}

	std::string authToken = msg.getString();

	auto thisPtr = std::static_pointer_cast<ProtocolLogin>(shared_from_this());
	g_dispatcher.addTask(std::bind(&ProtocolLogin::getCharacterList, thisPtr, std::move(accountName), std::move(password), std::move(authToken), clientVersion));
	#else
	auto thisPtr = std::static_pointer_cast<ProtocolLogin>(shared_from_this());
	g_dispatcher.addTask(std::bind(&ProtocolLogin::getCharacterList, thisPtr, std::move(accountName), std::move(password), clientVersion));
	#endif
}
