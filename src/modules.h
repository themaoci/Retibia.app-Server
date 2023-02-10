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

#ifndef FS_MODULES_H_DDCB58C4028C6CA8AFBAC4EBF0782250A789AE4889CEEBAA2A43E53B
#define FS_MODULES_H_DDCB58C4028C6CA8AFBAC4EBF0782250A789AE4889CEEBAA2A43E53B

#include "luascript.h"

class NetworkMessage;

class Modules
{
	public:
		Modules();

		bool load();
		
		// Module
		bool eventOnRecvByte(Player* player, uint8_t recvbyte, NetworkMessage& msg);

	private:
		LuaScriptInterface scriptInterface;
		std::map<uint8_t, int32_t> modules;
};

#endif
