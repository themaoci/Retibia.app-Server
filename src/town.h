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

#ifndef FS_TOWN_H_3BE21D2293B44AA4A3D22D25BE1B9350
#define FS_TOWN_H_3BE21D2293B44AA4A3D22D25BE1B9350

#include "position.h"

class Town
{
	public:
		explicit Town(uint32_t id) : id(id) {}

		const Position& getTemplePosition() const {
			return templePosition;
		}
		const std::string& getName() const {
			return name;
		}

		void setTemplePos(Position pos) {
			templePosition = pos;
		}
		void setName(std::string name) {
			this->name = std::move(name);
		}
		uint32_t getID() const {
			return id;
		}

	private:
		uint32_t id;
		std::string name;
		Position templePosition;
};

using TownMap = std::map<uint32_t, Town>;

class Towns
{
	public:
		Towns() = default;

		// non-copyable
		Towns(const Towns&) = delete;
		Towns& operator=(const Towns&) = delete;

		Town* addTown(uint32_t townId) {
			return &townMap.emplace(std::piecewise_construct, std::forward_as_tuple(townId), std::forward_as_tuple(townId)).first->second;
		}

		Town* getTown(const std::string& townName) {
			for (auto& it : townMap) {
				if (strcasecmp(townName.c_str(), it.second.getName().c_str()) == 0) {
					return &it.second;
				}
			}
			return nullptr;
		}

		Town* getTown(uint32_t townId) {
			auto it = townMap.find(townId);
			if (it == townMap.end()) {
				return nullptr;
			}
			return &it->second;
		}

		TownMap& getTowns() {
			return townMap;
		}

	private:
		TownMap townMap;
};

#endif
