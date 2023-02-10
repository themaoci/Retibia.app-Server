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

#ifndef FS_MAP_H_E3953D57C058461F856F5221D359DAFA
#define FS_MAP_H_E3953D57C058461F856F5221D359DAFA

#include "position.h"
#include "item.h"
#include "fileloader.h"

#include "tools.h"
#include "tile.h"
#include "town.h"
#include "house.h"
#include "spawn.h"

class Creature;
class Player;
class Game;
class Tile;
class Map;

static constexpr int32_t MAP_MAX_LAYERS = 16;

struct FindPathParams;
struct AStarNode {
	AStarNode* parent;
	int_fast32_t f, g, c;
	uint16_t x, y;
};

static constexpr int32_t MAX_NODES = 512;

static constexpr int32_t MAP_NORMALWALKCOST = 10;
static constexpr int32_t MAP_DIAGONALWALKCOST = 25;

class AStarNodes
{
	public:
		AStarNodes(uint32_t x, uint32_t y, int_fast32_t extraCost);

		bool createOpenNode(AStarNode* parent, uint32_t x, uint32_t y, int_fast32_t f, int_fast32_t heuristic, int_fast32_t extraCost);
		AStarNode* getBestNode();
		void closeNode(AStarNode* node);
		void openNode(AStarNode* node);
		int32_t getClosedNodes() const;
		AStarNode* getNodeByPosition(uint32_t x, uint32_t y);

		static inline int_fast32_t getMapWalkCost(AStarNode* node, const Position& neighborPos);
		static inline int_fast32_t getTileWalkCost(const Creature& creature, const Tile* tile);

	private:
		#if defined(__SSE2__)
		alignas(16) uint32_t nodesTable[MAX_NODES];
		alignas(64) int32_t calculatedNodes[MAX_NODES];
		AStarNode nodes[MAX_NODES];
		#else
		AStarNode nodes[MAX_NODES];
		uint32_t nodesTable[MAX_NODES];
		#endif
		int32_t closedNodes;
		int32_t curNode;
		bool openNodes[MAX_NODES];
};

using SpectatorCache = std::map<Position, SpectatorVector>;

//SECTOR_SIZE must be power of 2 value
//The bigger the SECTOR_SIZE is the less hash map collision there should be but it'll consume more memory
static constexpr int32_t SECTOR_SIZE = 16;
static constexpr int32_t SECTOR_MASK = (SECTOR_SIZE - 1);

class FrozenPathingConditionCall;

class MapSector
{
	public:
		MapSector() = default;
		~MapSector();

		// non-copyable
		MapSector(const MapSector&) = delete;
		MapSector& operator=(const MapSector&) = delete;

		// non-moveable
		MapSector(const MapSector&&) = delete;
		MapSector& operator=(const MapSector&&) = delete;

		void createFloor(uint8_t z);
		bool getFloor(uint8_t z) const;

		void addCreature(Creature* c);
		void removeCreature(Creature* c);

	private:
		static bool newSector;
		MapSector* sectorS = nullptr;
		MapSector* sectorE = nullptr;
		CreatureVector creature_list;
		CreatureVector player_list;
		Tile* tiles[MAP_MAX_LAYERS][SECTOR_SIZE][SECTOR_SIZE] = {};
		uint32_t floorBits = 0;

		friend class Map;
};

/**
  * Map class.
  * Holds all the actual map-data
  */

class Map
{
	public:
		static constexpr int32_t maxClientViewportX = (CLIENT_MAP_WIDTH_OFFSET - 1);
		static constexpr int32_t maxClientViewportY = (CLIENT_MAP_HEIGHT_OFFFSET - 1);
		static constexpr int32_t maxViewportX = (CLIENT_MAP_WIDTH_OFFSET + 1); //min value: maxClientViewportX + 1(needs to be at least + 1 from Monster::canSee)
		static constexpr int32_t maxViewportY = (CLIENT_MAP_HEIGHT_OFFFSET + 1); //min value: maxClientViewportY + 1(needs to be at least + 1 from Monster::canSee)

		uint32_t clean() const;

		/**
		  * Load a map.
		  * \returns true if the map was loaded successfully
		  */
		bool loadMap(const std::string& identifier, bool loadHouses);

		/**
		  * Save a map.
		  * \returns true if the map was saved successfully
		  */
		static bool save();

		/**
		  * Creates a map sector.
		  * \returns A pointer to that map sector.
		  */
		MapSector* createMapSector(uint32_t x, uint32_t y);

		/**
		  * Gets a map sector.
		  * \returns A pointer to that map sector.
		  */
		MapSector* getMapSector(uint32_t x, uint32_t y);
		const MapSector* getMapSector(uint32_t x, uint32_t y) const;

		/**
		  * Get a single tile.
		  * \returns A pointer to that tile.
		  */
		Tile* getTile(uint16_t x, uint16_t y, uint8_t z) const;
		Tile* getTile(const Position& pos) const {
			return getTile(pos.x, pos.y, pos.z);
		}

		/**
		  * Set a single tile.
		  */
		void setTile(uint16_t x, uint16_t y, uint8_t z, Tile* newTile);
		void setTile(const Position& pos, Tile* newTile) {
			setTile(pos.x, pos.y, pos.z, newTile);
		}

		/**
		  * Place a creature on the map
		  * \param centerPos The position to place the creature
		  * \param creature Creature to place on the map
		  * \param extendedPos If true, the creature will in first-hand be placed 2 tiles away
		  * \param forceLogin If true, placing the creature will not fail becase of obstacles (creatures/chests)
		  */
		bool placeCreature(const Position& centerPos, Creature* creature, bool extendedPos = false, bool forceLogin = false);

		void moveCreature(Creature& creature, Tile& newTile, bool forceTeleport = false);


		std::vector<Tile*> getFloorTiles(int32_t x, int32_t y, int32_t width, int32_t height, int32_t z);

		void getSpectators(SpectatorVector& spectators, const Position& centerPos, bool multifloor = false, bool onlyPlayers = false,
		                   int32_t minRangeX = 0, int32_t maxRangeX = 0,
		                   int32_t minRangeY = 0, int32_t maxRangeY = 0);

		void clearSpectatorCache(bool clearPlayer);

		/**
		  * Checks if you can throw an object to that position
		  *	\param fromPos from Source point
		  *	\param toPos Destination point
		  *	\param rangex maximum allowed range horizontially
		  *	\param rangey maximum allowed range vertically
		  *	\param checkLineOfSight checks if there is any blocking objects in the way
		  *	\returns The result if you can throw there or not
		  */
		bool canThrowObjectTo(const Position& fromPos, const Position& toPos, SightLines_t lineOfSight = SightLine_CheckSightLine,
		                      int32_t rangex = Map::maxClientViewportX, int32_t rangey = Map::maxClientViewportY) const;

		/**
		  * Checks if path is clear from fromPos to toPos
		  * Notice: This only checks a straight line if the path is clear, for path finding use getPathTo.
		  *	\param fromPos from Source point
		  *	\param toPos Destination point
		  *	\param floorCheck if true then view is not clear if fromPos.z is not the same as toPos.z
		  *	\returns The result if there is no obstacles
		  */
		bool isSightClear(const Position& fromPos, const Position& toPos, bool floorCheck) const;
		bool checkSightLine(Position start, Position destination) const;

		const Tile* canWalkTo(const Creature& creature, const Position& pos) const;

		bool getPathMatching(const Creature& creature, const Position& targetPos, std::vector<Direction>& dirList,
			const FrozenPathingConditionCall& pathCondition, const FindPathParams& fpp) const;
		bool getPathMatchingCond(const Creature& creature, const Position& targetPos, std::vector<Direction>& dirList,
			const FrozenPathingConditionCall& pathCondition, const FindPathParams& fpp) const;

		std::map<std::string, Position> waypoints;

		Spawns spawns;
		Towns towns;
		Houses houses;

	private:
		SpectatorCache spectatorCache;
		SpectatorCache playersSpectatorCache;

		#if GAME_FEATURE_ROBINHOOD_HASH_MAP > 0
		robin_hood::unordered_map<uint32_t, MapSector> mapSectors;
		#else
		std::unordered_map<uint32_t, MapSector> mapSectors;
		#endif

		std::string spawnfile;
		std::string housefile;

		uint32_t width = 0;
		uint32_t height = 0;

		// Actually scans the map for spectators
		void getSpectatorsInternal(SpectatorVector& spectators, const Position& centerPos,
		                           int32_t minRangeX, int32_t maxRangeX,
		                           int32_t minRangeY, int32_t maxRangeY,
		                           int32_t minRangeZ, int32_t maxRangeZ, bool onlyPlayers) const;

		friend class Game;
		friend class IOMap;
};

#endif
