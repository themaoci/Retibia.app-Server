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

#ifndef FS_TILE_H_96C7EE7CF8CD48E59D5D554A181F0C56
#define FS_TILE_H_96C7EE7CF8CD48E59D5D554A181F0C56

#include "cylinder.h"
#include "item.h"
#include "tools.h"

class Creature;
class Teleport;
class TrashHolder;
class Mailbox;
class MagicField;
class QTreeLeafNode;
class BedItem;

using CreatureVector = std::vector<Creature*>;
using ItemVector = std::vector<Item*>;

enum tileflags_t : uint32_t {
	TILESTATE_NONE = 0,

	TILESTATE_FLOORCHANGE_DOWN = 1 << 0,
	TILESTATE_FLOORCHANGE_NORTH = 1 << 1,
	TILESTATE_FLOORCHANGE_SOUTH = 1 << 2,
	TILESTATE_FLOORCHANGE_EAST = 1 << 3,
	TILESTATE_FLOORCHANGE_WEST = 1 << 4,
	TILESTATE_FLOORCHANGE_SOUTH_ALT = 1 << 5,
	TILESTATE_FLOORCHANGE_EAST_ALT = 1 << 6,
	TILESTATE_PROTECTIONZONE = 1 << 7,
	TILESTATE_NOPVPZONE = 1 << 8,
	TILESTATE_NOLOGOUT = 1 << 9,
	TILESTATE_PVPZONE = 1 << 10,
	TILESTATE_TELEPORT = 1 << 11,
	TILESTATE_MAGICFIELD = 1 << 12,
	TILESTATE_MAILBOX = 1 << 13,
	TILESTATE_TRASHHOLDER = 1 << 14,
	TILESTATE_BED = 1 << 15,
	TILESTATE_DEPOT = 1 << 16,
	TILESTATE_BLOCKSOLID = 1 << 17,
	TILESTATE_BLOCKPATH = 1 << 18,
	TILESTATE_IMMOVABLEBLOCKSOLID = 1 << 19,
	TILESTATE_IMMOVABLEBLOCKPATH = 1 << 20,
	TILESTATE_IMMOVABLENOFIELDBLOCKPATH = 1 << 21,
	TILESTATE_NOFIELDBLOCKPATH = 1 << 22,
	TILESTATE_SUPPORTS_HANGABLE = 1 << 23,
	TILESTATE_BLOCKPROJECTILE = 1 << 24,

	TILESTATE_FLOORCHANGE = TILESTATE_FLOORCHANGE_DOWN | TILESTATE_FLOORCHANGE_NORTH | TILESTATE_FLOORCHANGE_SOUTH | TILESTATE_FLOORCHANGE_EAST | TILESTATE_FLOORCHANGE_WEST | TILESTATE_FLOORCHANGE_SOUTH_ALT | TILESTATE_FLOORCHANGE_EAST_ALT,
};

enum ZoneType_t {
	ZONE_PROTECTION,
	ZONE_NOPVP,
	ZONE_PVP,
	ZONE_NOLOGOUT,
	ZONE_NORMAL,
};

class SpectatorVector
{
	public:
		SpectatorVector() {
			specs.reserve(32);
		}

		inline CreatureVector::iterator begin() noexcept { return specs.begin(); }
		inline CreatureVector::iterator end() noexcept { return specs.end(); }
		inline CreatureVector::const_iterator begin() const noexcept { return specs.begin(); }
		inline CreatureVector::const_iterator end() const noexcept { return specs.end(); }
		inline bool empty() const noexcept { return specs.empty(); }
		inline size_t size() const noexcept { return specs.size(); }
		inline size_t capacity() const noexcept { return specs.capacity(); }
		inline void clear() noexcept { specs.clear(); }
		inline void reserve(size_t count) { specs.reserve(count); }
		inline void push_back(CreatureVector::value_type element) { specs.push_back(element); }
		inline void emplace_back(CreatureVector::value_type element) { specs.emplace_back(element); }
		inline CreatureVector::reference operator[](size_t index) { return specs.operator[](index); }
		inline CreatureVector::const_reference operator[](size_t index) const { return specs.operator[](index); }

		template<class inputIterator>
		inline void insert(CreatureVector::const_iterator it, inputIterator first, inputIterator last) { specs.insert(it, first, last); }

		void mergeSpectators(const SpectatorVector& spectators) {
			size_t it = 0, end = spectators.size();
			while (it < end) {
				Creature* spectator = spectators[it];

				size_t cit = 0, cend = size();
				while (cit < cend) {
					if (specs[cit] == spectator) {
						goto Skip_Duplicate;
					} else {
						++cit;
					}
				}

				specs.emplace_back(spectator);
				Skip_Duplicate:
				++it;
			}
		}

		void erase(Creature* spectator) {
			size_t it = 0, end = size();
			while (it < end) {
				if (specs[it] == spectator) {
					specs[it] = specs.back();
					specs.pop_back();
					return;
				} else {
					++it;
				}
			}
		}

		//Allow implicit conversion to CreatureVector&
		operator CreatureVector&() { return specs; }

	private:
		CreatureVector specs;
};

class TileItemVector
{
	public:
		TileItemVector() = default;

		inline ItemVector::iterator begin() noexcept { return vec.begin(); }
		inline ItemVector::iterator end() noexcept { return vec.end(); }
		inline ItemVector::const_iterator begin() const noexcept { return vec.begin(); }
		inline ItemVector::const_iterator end() const noexcept { return vec.end(); }
		inline ItemVector::reverse_iterator rbegin() noexcept { return vec.rbegin(); }
		inline ItemVector::reverse_iterator rend() noexcept { return vec.rend(); }
		inline ItemVector::const_reverse_iterator rbegin() const noexcept { return vec.rbegin(); }
		inline ItemVector::const_reverse_iterator rend() const noexcept { return vec.rend(); }
		inline size_t size() const noexcept { return vec.size(); }
		inline void clear() noexcept { vec.clear(); }
		inline void push_back(ItemVector::value_type element) { vec.push_back(element); }
		inline void emplace_back(ItemVector::value_type element) { vec.emplace_back(element); }
		inline ItemVector::iterator erase(ItemVector::const_iterator it) { return vec.erase(it); }
		inline ItemVector::iterator erase(ItemVector::const_iterator first, ItemVector::const_iterator last) { return vec.erase(first, last); }
		inline ItemVector::reference operator[](size_t index) { return vec.operator[](index); }
		inline ItemVector::const_reference operator[](size_t index) const { return vec.operator[](index); }

		template<class inputIterator>
		inline void insert(ItemVector::const_iterator it, inputIterator first, inputIterator last) { vec.insert(it, first, last); }
		inline void insert(ItemVector::const_iterator it, ItemVector::value_type element) { vec.insert(it, element); }

		inline ItemVector::iterator getBeginDownItem() { return begin() + topItemCount; }
		inline ItemVector::const_iterator getBeginDownItem() const { return begin() + topItemCount; }
		inline ItemVector::iterator getEndDownItem() noexcept { return end(); }
		inline ItemVector::const_iterator getEndDownItem() const noexcept { return end(); }
		inline ItemVector::iterator getBeginTopItem() noexcept { return begin(); }
		inline ItemVector::const_iterator getBeginTopItem() const noexcept { return begin(); }
		inline ItemVector::iterator getEndTopItem() { return getBeginDownItem(); }
		inline ItemVector::const_iterator getEndTopItem() const { return getBeginDownItem(); }

		inline uint32_t getTopItemCount() const noexcept { return topItemCount; }
		inline uint32_t getDownItemCount() const noexcept { return size() - topItemCount; }
		inline void addTopItemCount(int32_t increment) noexcept { topItemCount += increment; }
		inline Item* getTopTopItem() const noexcept {
			if (topItemCount == 0) {
				return nullptr;
			}
			return *(getEndTopItem() - 1);
		}
		inline Item* getTopDownItem() const noexcept {
			if (getDownItemCount() == 0) {
				return nullptr;
			}
			return *(getEndDownItem() - 1);
		}

		//Allow implicit conversion to ItemVector&
		operator ItemVector&() { return vec; }

	private:
		ItemVector vec;
		uint16_t topItemCount = 0;
};

class Tile : public Cylinder
{
	public:
		static Tile& nullptr_tile;
		Tile(uint16_t x, uint16_t y, uint8_t z) : tilePos(x, y, z) {}
		virtual ~Tile() {
			delete ground;
		};

		// non-copyable
		Tile(const Tile&) = delete;
		Tile& operator=(const Tile&) = delete;

		virtual TileItemVector* getItemList() = 0;
		virtual const TileItemVector* getItemList() const = 0;
		virtual TileItemVector* makeItemList() = 0;

		virtual CreatureVector* getCreatures() = 0;
		virtual const CreatureVector* getCreatures() const = 0;
		virtual CreatureVector* makeCreatures() = 0;

		int32_t getThrowRange() const override final {
			return 0;
		}
		bool isPushable() const override final {
			return false;
		}

		MagicField* getFieldItem() const;
		Teleport* getTeleportItem() const;
		TrashHolder* getTrashHolder() const;
		Mailbox* getMailbox() const;
		BedItem* getBedItem() const;

		Creature* getTopCreature() const;
		const Creature* getBottomCreature() const;
		Creature* getTopVisibleCreature(const Creature* creature) const;
		const Creature* getBottomVisibleCreature(const Creature* creature) const;
		Item* getTopTopItem() const;
		Item* getTopDownItem() const;
		bool isMoveableBlocking() const;
		Thing* getTopVisibleThing(const Creature* creature);
		Item* getItemByTopOrder(int32_t topOrder);

		size_t getThingCount() const {
			size_t thingCount = getCreatureCount() + getItemCount();
			if (ground) {
				thingCount++;
			}
			return thingCount;
		}
		// If these return != 0 the associated vectors are guaranteed to exists
		size_t getCreatureCount() const;
		size_t getItemCount() const;
		uint32_t getTopItemCount() const;
		uint32_t getDownItemCount() const;

		bool hasProperty(ITEMPROPERTY prop) const;
		bool hasProperty(const Item* exclude, ITEMPROPERTY prop) const;

		bool hasFlag(uint32_t flag) const {
			return hasBitSet(flag, this->flags);
		}
		void setFlag(uint32_t flag) {
			this->flags |= flag;
		}
		void resetFlag(uint32_t flag) {
			this->flags &= ~flag;
		}

		ZoneType_t getZone() const {
			if (hasFlag(TILESTATE_PROTECTIONZONE)) {
				return ZONE_PROTECTION;
			} else if (hasFlag(TILESTATE_NOPVPZONE)) {
				return ZONE_NOPVP;
			} else if (hasFlag(TILESTATE_PVPZONE)) {
				return ZONE_PVP;
			} else {
				return ZONE_NORMAL;
			}
		}

		bool hasHeight(uint32_t n) const;

		std::string getDescription(int32_t lookDistance) const override final;

		int32_t getClientIndexOfCreature(const Player* player, const Creature* creature) const;
		int32_t getStackposOfCreature(const Player* player, const Creature* creature) const;
		int32_t getStackposOfItem(const Player* player, const Item* item) const;

		//cylinder implementations
		ReturnValue queryAdd(int32_t index, const Thing& thing, uint32_t count,
				uint32_t flags, Creature* actor = nullptr) const override;
		ReturnValue queryMaxCount(int32_t index, const Thing& thing, uint32_t count,
				uint32_t& maxQueryCount, uint32_t flags) const override final;
		ReturnValue queryRemove(const Thing& thing, uint32_t count, uint32_t flags) const override final;
		Tile* queryDestination(int32_t& index, const Thing& thing, Item** destItem, uint32_t& flags) override;

		void addThing(Thing* thing) override final;
		void addThing(int32_t index, Thing* thing) override;

		void updateThing(Thing* thing, uint16_t itemId, uint32_t count) override final;
		void replaceThing(uint32_t index, Thing* thing) override final;

		void removeThing(Thing* thing, uint32_t count) override final;
		#if GAME_FEATURE_FASTER_CLEAN > 0
		void cleanItem(Item* item, int32_t index, uint32_t count);
		#endif

		void removeCreature(Creature* creature);

		int32_t getThingIndex(const Thing* thing) const override final;
		size_t getFirstIndex() const override final;
		size_t getLastIndex() const override final;
		uint32_t getItemTypeCount(uint16_t itemId, int32_t subType = -1) const override final;
		Thing* getThing(size_t index) const override final;

		void postAddNotification(Thing* thing, const Cylinder* oldParent, int32_t index, cylinderlink_t link = LINK_OWNER) override final;
		void postRemoveNotification(Thing* thing, const Cylinder* newParent, int32_t index, cylinderlink_t link = LINK_OWNER) override final;

		void internalAddThing(Thing* thing) override final;
		void internalAddThing(uint32_t index, Thing* thing) override;

		const Position& getPosition() const override final {
			return tilePos;
		}

		bool isRemoved() const override final {
			return false;
		}

		Item* getUseItem(int32_t index) const;

		Item* getGround() const {
			return ground;
		}
		void setGround(Item* item) {
			ground = item;
		}

	private:
		void onAddTileItem(Item* item);
		void onUpdateTileItem(Item* oldItem, const ItemType& oldType, Item* newItem, const ItemType& newType);
		void onRemoveTileItem(const SpectatorVector& spectators, const std::vector<int32_t>& oldStackPosVector, Item* item);
		void onUpdateTile(const SpectatorVector& spectators);

		void setTileFlags(const Item* item);
		void resetTileFlags(const Item* item);

		Item* ground = nullptr;
		uint32_t flags = 0;
		Position tilePos;
};

// Used for walkable tiles, where there is high likeliness of
// items being added/removed
class DynamicTile : public Tile
{
		// By allocating the vectors in-house, we avoid some memory fragmentation
		TileItemVector items;
		CreatureVector creatures;

	public:
		DynamicTile(uint16_t x, uint16_t y, uint8_t z) : Tile(x, y, z) {}
		~DynamicTile() {
			for (Item* item : items) {
				item->decrementReferenceCounter();
			}
		}

		// non-copyable
		DynamicTile(const DynamicTile&) = delete;
		DynamicTile& operator=(const DynamicTile&) = delete;

		TileItemVector* getItemList() override {
			return &items;
		}
		const TileItemVector* getItemList() const override {
			return &items;
		}
		TileItemVector* makeItemList() override {
			return &items;
		}

		CreatureVector* getCreatures() override {
			return &creatures;
		}
		const CreatureVector* getCreatures() const override {
			return &creatures;
		}
		CreatureVector* makeCreatures() override {
			return &creatures;
		}
};

// For blocking tiles, where we very rarely actually have items
class StaticTile final : public Tile
{
	// We very rarely even need the vectors, so don't keep them in memory
	std::unique_ptr<TileItemVector> items;
	std::unique_ptr<CreatureVector> creatures;

	public:
		StaticTile(uint16_t x, uint16_t y, uint8_t z) : Tile(x, y, z) {}
		~StaticTile() {
			if (items) {
				for (Item* item : *items) {
					item->decrementReferenceCounter();
				}
			}
		}

		// non-copyable
		StaticTile(const StaticTile&) = delete;
		StaticTile& operator=(const StaticTile&) = delete;

		TileItemVector* getItemList() override {
			return items.get();
		}
		const TileItemVector* getItemList() const override {
			return items.get();
		}
		TileItemVector* makeItemList() override {
			if (!items) {
				items.reset(new TileItemVector);
			}
			return items.get();
		}

		CreatureVector* getCreatures() override {
			return creatures.get();
		}
		const CreatureVector* getCreatures() const override {
			return creatures.get();
		}
		CreatureVector* makeCreatures() override {
			if (!creatures) {
				creatures.reset(new CreatureVector);
			}
			return creatures.get();
		}
};

#endif
