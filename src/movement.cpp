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

#include "game.h"

#include "pugicast.h"

#include "movement.h"

extern Game g_game;
extern Vocations g_vocations;

MoveEvents::MoveEvents() :
	scriptInterface("MoveEvents Interface")
{
	scriptInterface.initState();
}

MoveEvents::~MoveEvents()
{
	clear(false);
}

void MoveEvents::clearMap(MoveListMap& map, bool fromLua)
{
	for (auto it = map.begin(); it != map.end(); ++it) {
		for (int eventType = MOVE_EVENT_STEP_IN; eventType < MOVE_EVENT_LAST; ++eventType) {
			auto& moveEvent = it->second.moveEvent[eventType];
			if (moveEvent) {
				if (fromLua == moveEvent->fromLua) {
					moveEvent.reset();
				}
			}
		}
	}
}

void MoveEvents::clearPosMap(MovePosListMap& map, bool fromLua)
{
	for (auto it = map.begin(); it != map.end(); ++it) {
		for (int eventType = MOVE_EVENT_STEP_IN; eventType < MOVE_EVENT_LAST; ++eventType) {
			auto& moveEvent = it->second.moveEvent[eventType];
			if (moveEvent) {
				if (fromLua == moveEvent->fromLua) {
					moveEvent.reset();
				}
			}
		}
	}
}

void MoveEvents::clear(bool fromLua)
{
	clearMap(itemIdMap, fromLua);
	clearMap(actionIdMap, fromLua);
	clearMap(uniqueIdMap, fromLua);
	clearPosMap(positionMap, fromLua);

	reInitState(fromLua);
}

LuaScriptInterface& MoveEvents::getScriptInterface()
{
	return scriptInterface;
}

std::string MoveEvents::getScriptBaseName() const
{
	return "movements";
}

Event_ptr MoveEvents::getEvent(const std::string& nodeName)
{
	if (strcasecmp(nodeName.c_str(), "movevent") != 0) {
		return nullptr;
	}
	return Event_ptr(new MoveEvent(&scriptInterface));
}

bool MoveEvents::registerEvent(Event_ptr event, const pugi::xml_node& node)
{
	MoveEvent_ptr moveEvent{static_cast<MoveEvent*>(event.release())}; //event is guaranteed to be a MoveEvent

	const MoveEvent_t eventType = moveEvent->getEventType();
	if (eventType == MOVE_EVENT_ADD_ITEM || eventType == MOVE_EVENT_REMOVE_ITEM) {
		pugi::xml_attribute tileItemAttribute = node.attribute("tileitem");
		if (tileItemAttribute && pugi::cast<uint16_t>(tileItemAttribute.value()) == 1) {
			switch (eventType) {
				case MOVE_EVENT_ADD_ITEM:
					moveEvent->setEventType(MOVE_EVENT_ADD_ITEM_ITEMTILE);
					break;
				case MOVE_EVENT_REMOVE_ITEM:
					moveEvent->setEventType(MOVE_EVENT_REMOVE_ITEM_ITEMTILE);
					break;
				default:
					break;
			}
		}
	}

	pugi::xml_attribute attr;
	if ((attr = node.attribute("itemid"))) {
		for (std::string& itemId : explodeString(attr.as_string(), ";")) {
			try {
				std::vector<int32_t> itemIds = vectorAtoi(explodeString(itemId, "-"));
				addEvent(moveEvent, static_cast<uint16_t>(itemIds[0]), itemIdMap);
				if (moveEvent->getEventType() == MOVE_EVENT_EQUIP) {
					ItemType& it = Item::items.getItemType(itemIds[0]);
					it.wieldInfo = moveEvent->getWieldInfo();
					it.minReqLevel = moveEvent->getReqLevel();
					it.minReqMagicLevel = moveEvent->getReqMagLv();
					it.vocationString = moveEvent->getVocationString();
				}

				if (itemIds.size() > 1) {
					while (itemIds[0] < itemIds[1]) {
						addEvent(moveEvent, static_cast<uint16_t>(++itemIds[0]), itemIdMap);
						if (moveEvent->getEventType() == MOVE_EVENT_EQUIP) {
							ItemType& it = Item::items.getItemType(itemIds[0]);
							it.wieldInfo = moveEvent->getWieldInfo();
							it.minReqLevel = moveEvent->getReqLevel();
							it.minReqMagicLevel = moveEvent->getReqMagLv();
							it.vocationString = moveEvent->getVocationString();
						}
					}
				}
			} catch (const std::invalid_argument&) {
				std::cout << "[Warning - MoveEvents::registerEvent] Registered itemid have invalid id: " << itemId << std::endl;
				continue;
			} catch (const std::out_of_range&) {
				std::cout << "[Warning - MoveEvents::registerEvent] Registered itemid have too long id: " << itemId << std::endl;
				continue;
			}
		}
	} else if ((attr = node.attribute("fromid"))) {
		pugi::xml_attribute toIdAttribute = node.attribute("toid");
		if (!toIdAttribute) {
			std::cout << "[Warning - MoveEvents::registerEvent] Missing toid in fromid: " << attr.as_string() << std::endl;
			return false;
		}

		try {
			std::vector<int32_t> fromIds = vectorAtoi(explodeString(attr.as_string(), ";"));
			std::vector<int32_t> toIds = vectorAtoi(explodeString(toIdAttribute.as_string(), ";"));
			if (fromIds.size() != toIds.size()) {
				std::cout << "[Warning - MoveEvents::registerEvent] Registered range(fromid - toid) is malformed: (" << attr.as_string() << " - " << toIdAttribute.as_string() << ")" << std::endl;
				return false;
			}

			for (size_t i = 0, end = fromIds.size(); i < end; ++i) {
				addEvent(moveEvent, static_cast<uint16_t>(fromIds[i]), itemIdMap);
				if (moveEvent->getEventType() == MOVE_EVENT_EQUIP) {
					ItemType& it = Item::items.getItemType(fromIds[i]);
					it.wieldInfo = moveEvent->getWieldInfo();
					it.minReqLevel = moveEvent->getReqLevel();
					it.minReqMagicLevel = moveEvent->getReqMagLv();
					it.vocationString = moveEvent->getVocationString();
				}

				while (fromIds[i] < toIds[i]) {
					addEvent(moveEvent, static_cast<uint16_t>(++fromIds[i]), itemIdMap);
					if (moveEvent->getEventType() == MOVE_EVENT_EQUIP) {
						ItemType& it = Item::items.getItemType(fromIds[i]);
						it.wieldInfo = moveEvent->getWieldInfo();
						it.minReqLevel = moveEvent->getReqLevel();
						it.minReqMagicLevel = moveEvent->getReqMagLv();
						it.vocationString = moveEvent->getVocationString();
					}
				}
			}
		} catch (const std::invalid_argument&) {
			std::cout << "[Warning - MoveEvents::registerEvent] Registered range(fromid - toid) have invalid ids: (" << attr.as_string() << " - " << toIdAttribute.as_string() << ")" << std::endl;
		} catch (const std::out_of_range&) {
			std::cout << "[Warning - MoveEvents::registerEvent] Registered range(fromid - toid) have too long ids: (" << attr.as_string() << " - " << toIdAttribute.as_string() << ")" << std::endl;
		}
	} else if ((attr = node.attribute("uniqueid"))) {
		for (std::string& uniqueId : explodeString(attr.as_string(), ";")) {
			try {
				std::vector<int32_t> uniqueIds = vectorAtoi(explodeString(uniqueId, "-"));
				addEvent(moveEvent, static_cast<uint16_t>(uniqueIds[0]), uniqueIdMap);
				if (uniqueIds.size() > 1) {
					while (uniqueIds[0] < uniqueIds[1]) {
						addEvent(moveEvent, static_cast<uint16_t>(++uniqueIds[0]), uniqueIdMap);
					}
				}
			} catch (const std::invalid_argument&) {
				std::cout << "[Warning - MoveEvents::registerEvent] Registered uniqueid have invalid id: " << uniqueId << std::endl;
				continue;
			} catch (const std::out_of_range&) {
				std::cout << "[Warning - MoveEvents::registerEvent] Registered uniqueid have too long id: " << uniqueId << std::endl;
				continue;
			}
		}
	} else if ((attr = node.attribute("fromuid"))) {
		pugi::xml_attribute toIdAttribute = node.attribute("touid");
		if (!toIdAttribute) {
			std::cout << "[Warning - MoveEvents::registerEvent] Missing touid in fromuid: " << attr.as_string() << std::endl;
			return false;
		}

		try {
			std::vector<int32_t> fromIds = vectorAtoi(explodeString(attr.as_string(), ";"));
			std::vector<int32_t> toIds = vectorAtoi(explodeString(toIdAttribute.as_string(), ";"));
			if (fromIds.size() != toIds.size()) {
				std::cout << "[Warning - MoveEvents::registerEvent] Registered range(fromuid - touid) is malformed: (" << attr.as_string() << " - " << toIdAttribute.as_string() << ")" << std::endl;
				return false;
			}

			for (size_t i = 0, end = fromIds.size(); i < end; ++i) {
				addEvent(moveEvent, static_cast<uint16_t>(fromIds[i]), uniqueIdMap);
				while (fromIds[i] < toIds[i]) {
					addEvent(moveEvent, static_cast<uint16_t>(++fromIds[i]), uniqueIdMap);
				}
			}
		} catch (const std::invalid_argument&) {
			std::cout << "[Warning - MoveEvents::registerEvent] Registered range(fromuid - touid) have invalid ids: (" << attr.as_string() << " - " << toIdAttribute.as_string() << ")" << std::endl;
		} catch (const std::out_of_range&) {
			std::cout << "[Warning - MoveEvents::registerEvent] Registered range(fromuid - touid) have too long ids: (" << attr.as_string() << " - " << toIdAttribute.as_string() << ")" << std::endl;
		}
	} else if ((attr = node.attribute("actionid"))) {
		for (std::string& actionId : explodeString(attr.as_string(), ";")) {
			try {
				std::vector<int32_t> actionIds = vectorAtoi(explodeString(actionId, "-"));
				addEvent(moveEvent, static_cast<uint16_t>(actionIds[0]), actionIdMap);
				if (actionIds.size() > 1) {
					while (actionIds[0] < actionIds[1]) {
						addEvent(moveEvent, static_cast<uint16_t>(++actionIds[0]), actionIdMap);
					}
				}
			} catch (const std::invalid_argument&) {
				std::cout << "[Warning - MoveEvents::registerEvent] Registered actionid have invalid id: " << actionId << std::endl;
				continue;
			} catch (const std::out_of_range&) {
				std::cout << "[Warning - MoveEvents::registerEvent] Registered actionid have too long id: " << actionId << std::endl;
				continue;
			}
		}
	} else if ((attr = node.attribute("fromaid"))) {
		pugi::xml_attribute toIdAttribute = node.attribute("toaid");
		if (!toIdAttribute) {
			std::cout << "[Warning - MoveEvents::registerEvent] Missing toaid in fromaid: " << attr.as_string() << std::endl;
			return false;
		}

		try {
			std::vector<int32_t> fromIds = vectorAtoi(explodeString(attr.as_string(), ";"));
			std::vector<int32_t> toIds = vectorAtoi(explodeString(toIdAttribute.as_string(), ";"));
			if (fromIds.size() != toIds.size()) {
				std::cout << "[Warning - MoveEvents::registerEvent] Registered range(fromaid - toaid) is malformed: (" << attr.as_string() << " - " << toIdAttribute.as_string() << ")" << std::endl;
				return false;
			}

			for (size_t i = 0, end = fromIds.size(); i < end; ++i) {
				addEvent(moveEvent, static_cast<uint16_t>(fromIds[i]), actionIdMap);
				while (fromIds[i] < toIds[i]) {
					addEvent(moveEvent, static_cast<uint16_t>(++fromIds[i]), actionIdMap);
				}
			}
		} catch (const std::invalid_argument&) {
			std::cout << "[Warning - MoveEvents::registerEvent] Registered range(fromaid - toaid) have invalid ids: (" << attr.as_string() << " - " << toIdAttribute.as_string() << ")" << std::endl;
		} catch (const std::out_of_range&) {
			std::cout << "[Warning - MoveEvents::registerEvent] Registered range(fromaid - toaid) have too long ids: (" << attr.as_string() << " - " << toIdAttribute.as_string() << ")" << std::endl;
		}
	} else if ((attr = node.attribute("pos"))) {
		for (std::string& position : explodeString(attr.as_string(), ";")) {
			try {
				std::vector<int32_t> posList = vectorAtoi(explodeString(position, ","));
				if (posList.size() < 3) {
					std::cout << "[Warning - MoveEvents::registerEvent] Registered position don't have x/y/z coordinates: " << position << std::endl;
					continue;
				}

				Position pos(static_cast<uint16_t>(posList[0]), static_cast<uint16_t>(posList[1]), static_cast<uint8_t>(posList[2]));
				addEvent(moveEvent, pos, positionMap);
			} catch (const std::invalid_argument&) {
				std::cout << "[Warning - MoveEvents::registerEvent] Registered position have invalid coordinates: " << position << std::endl;
				continue;
			} catch (const std::out_of_range&) {
				std::cout << "[Warning - MoveEvents::registerEvent] Registered position have too long coordinates: " << position << std::endl;
				continue;
			}
		}
	} else {
		return false;
	}
	return true;
}

bool MoveEvents::registerLuaFunction(MoveEvent_ptr& event)
{
	std::vector<uint16_t>& itemIdRange = event->getItemIdRange();
	if (!itemIdRange.empty()) {
		for (uint16_t itemId : itemIdRange) {
			if (event->getEventType() == MOVE_EVENT_EQUIP) {
				ItemType& it = Item::items.getItemType(itemId);
				it.wieldInfo = event->getWieldInfo();
				it.minReqLevel = event->getReqLevel();
				it.minReqMagicLevel = event->getReqMagLv();
				it.vocationString = event->getVocationString();
			}

			addEvent(event, itemId, itemIdMap);
		}
		itemIdRange.clear();
		itemIdRange.shrink_to_fit();
	} else {
		return false;
	}
	return true;
}

bool MoveEvents::registerLuaEvent(MoveEvent_ptr& event)
{
	bool result = false;

	std::vector<uint16_t>& itemIdRange = event->getItemIdRange();
	if (!itemIdRange.empty()) {
		result = true;
		for (uint16_t itemId : itemIdRange) {
			if (event->getEventType() == MOVE_EVENT_EQUIP) {
				ItemType& it = Item::items.getItemType(itemId);
				it.wieldInfo = event->getWieldInfo();
				it.minReqLevel = event->getReqLevel();
				it.minReqMagicLevel = event->getReqMagLv();
				it.vocationString = event->getVocationString();
			}

			addEvent(event, itemId, itemIdMap);
		}
		itemIdRange.clear();
		itemIdRange.shrink_to_fit();
	}

	std::vector<uint16_t>& actionIdRange = event->getActionIdRange();
	if (!actionIdRange.empty()) {
		result = true;
		for (uint16_t actionId : actionIdRange) {
			addEvent(event, actionId, actionIdMap);
		}
		actionIdRange.clear();
		actionIdRange.shrink_to_fit();
	}

	std::vector<uint16_t>& uniqueIdRange = event->getUniqueIdRange();
	if (!uniqueIdRange.empty()) {
		result = true;
		for (uint16_t uniqueId : uniqueIdRange) {
			addEvent(event, uniqueId, uniqueIdMap);
		}
		uniqueIdRange.clear();
		uniqueIdRange.shrink_to_fit();
	}

	std::vector<Position>& posList = event->getPosList();
	if (!posList.empty()) {
		result = true;
		for (const Position& pos : posList) {
			addEvent(event, pos, positionMap);
		}
		posList.clear();
		posList.shrink_to_fit();
	}
	
	return result;
}

void MoveEvents::addEvent(MoveEvent_ptr moveEvent, uint16_t id, MoveListMap& map)
{
	auto it = map.find(id);
	if (it == map.end()) {
		map[id].moveEvent[moveEvent->getEventType()] = std::move(moveEvent);
	} else {
		if (it->second.moveEvent[moveEvent->getEventType()]) {
			std::cout << "[Warning - MoveEvents::addEvent] Duplicate move event found: " << id << std::endl;
			return;
		}
		it->second.moveEvent[moveEvent->getEventType()] = std::move(moveEvent);
	}
}

MoveEvent* MoveEvents::getEvent(Item* item, MoveEvent_t eventType, slots_t slot)
{
	uint32_t slotp;
	switch (slot) {
		case CONST_SLOT_HEAD: slotp = SLOTP_HEAD; break;
		case CONST_SLOT_NECKLACE: slotp = SLOTP_NECKLACE; break;
		case CONST_SLOT_BACKPACK: slotp = SLOTP_BACKPACK; break;
		case CONST_SLOT_ARMOR: slotp = SLOTP_ARMOR; break;
		case CONST_SLOT_RIGHT: slotp = SLOTP_RIGHT; break;
		case CONST_SLOT_LEFT: slotp = SLOTP_LEFT; break;
		case CONST_SLOT_LEGS: slotp = SLOTP_LEGS; break;
		case CONST_SLOT_FEET: slotp = SLOTP_FEET; break;
		case CONST_SLOT_AMMO: slotp = SLOTP_AMMO; break;
		case CONST_SLOT_RING: slotp = SLOTP_RING; break;
		default: slotp = 0; break;
	}

	auto it = itemIdMap.find(item->getID());
	if (it != itemIdMap.end()) {
		MoveEvent* moveEvent = it->second.moveEvent[eventType].get();
		if (moveEvent && (moveEvent->getSlot() & slotp) != 0) {
			return moveEvent;
		}
	}
	return nullptr;
}

MoveEvent* MoveEvents::getEvent(Item* item, MoveEvent_t eventType)
{
	MoveListMap::iterator it;

	if (item->hasAttribute(ITEM_ATTRIBUTE_UNIQUEID)) {
		it = uniqueIdMap.find(item->getUniqueId());
		if (it != uniqueIdMap.end()) {
			return it->second.moveEvent[eventType].get();
		}
	}

	if (item->hasAttribute(ITEM_ATTRIBUTE_ACTIONID)) {
		it = actionIdMap.find(item->getActionId());
		if (it != actionIdMap.end()) {
			return it->second.moveEvent[eventType].get();
		}
	}

	it = itemIdMap.find(item->getID());
	if (it != itemIdMap.end()) {
		return it->second.moveEvent[eventType].get();
	}
	return nullptr;
}

void MoveEvents::addEvent(MoveEvent_ptr moveEvent, const Position& pos, MovePosListMap& map)
{
	auto it = map.find(pos);
	if (it == map.end()) {
		map[pos].moveEvent[moveEvent->getEventType()] = std::move(moveEvent);
	} else {
		if (it->second.moveEvent[moveEvent->getEventType()]) {
			std::cout << "[Warning - MoveEvents::addEvent] Duplicate move event found: [x: " << pos.getX() << ", " << pos.getY() << ", " << pos.getZ() << "]" << std::endl;
			return;
		}
		it->second.moveEvent[moveEvent->getEventType()] = std::move(moveEvent);
	}
}

MoveEvent* MoveEvents::getEvent(const Tile* tile, MoveEvent_t eventType)
{
	auto it = positionMap.find(tile->getPosition());
	if (it != positionMap.end()) {
		return it->second.moveEvent[eventType].get();
	}
	return nullptr;
}

uint32_t MoveEvents::onCreatureMove(Creature* creature, const Tile* tile, MoveEvent_t eventType)
{
	const Position& pos = tile->getPosition();

	uint32_t ret = 1;

	MoveEvent* moveEvent = getEvent(tile, eventType);
	if (moveEvent) {
		ret &= moveEvent->fireStepEvent(creature, nullptr, pos);
	}

	for (size_t i = tile->getFirstIndex(), j = tile->getLastIndex(); i < j; ++i) {
		Thing* thing = tile->getThing(i);
		if (!thing) {
			continue;
		}

		Item* tileItem = thing->getItem();
		if (!tileItem) {
			continue;
		}

		moveEvent = getEvent(tileItem, eventType);
		if (moveEvent) {
			ret &= moveEvent->fireStepEvent(creature, tileItem, pos);
		}
	}
	return ret;
}

uint32_t MoveEvents::onPlayerEquip(Player* player, Item* item, slots_t slot, bool isCheck)
{
	MoveEvent* moveEvent = getEvent(item, MOVE_EVENT_EQUIP, slot);
	if (!moveEvent) {
		return 1;
	}
	return moveEvent->fireEquip(player, item, slot, isCheck);
}

uint32_t MoveEvents::onPlayerDeEquip(Player* player, Item* item, slots_t slot)
{
	MoveEvent* moveEvent = getEvent(item, MOVE_EVENT_DEEQUIP, slot);
	if (!moveEvent) {
		return 1;
	}
	return moveEvent->fireEquip(player, item, slot, false);
}

uint32_t MoveEvents::onItemMove(Item* item, Tile* tile, bool isAdd)
{
	MoveEvent_t eventType1, eventType2;
	if (isAdd) {
		eventType1 = MOVE_EVENT_ADD_ITEM;
		eventType2 = MOVE_EVENT_ADD_ITEM_ITEMTILE;
	} else {
		eventType1 = MOVE_EVENT_REMOVE_ITEM;
		eventType2 = MOVE_EVENT_REMOVE_ITEM_ITEMTILE;
	}

	uint32_t ret = 1;
	MoveEvent* moveEvent = getEvent(tile, eventType1);
	if (moveEvent) {
		ret &= moveEvent->fireAddRemItem(item, nullptr, tile->getPosition());
	}

	moveEvent = getEvent(item, eventType1);
	if (moveEvent) {
		ret &= moveEvent->fireAddRemItem(item, nullptr, tile->getPosition());
	}

	for (size_t i = tile->getFirstIndex(), j = tile->getLastIndex(); i < j; ++i) {
		Thing* thing = tile->getThing(i);
		if (!thing) {
			continue;
		}

		Item* tileItem = thing->getItem();
		if (!tileItem || tileItem == item) {
			continue;
		}

		moveEvent = getEvent(tileItem, eventType2);
		if (moveEvent) {
			ret &= moveEvent->fireAddRemItem(item, tileItem, tile->getPosition());
		}
	}
	return ret;
}

MoveEvent::MoveEvent(LuaScriptInterface* interface) : Event(interface) {}

std::string MoveEvent::getScriptEventName() const
{
	switch (eventType) {
		case MOVE_EVENT_STEP_IN: return "onStepIn";
		case MOVE_EVENT_STEP_OUT: return "onStepOut";
		case MOVE_EVENT_EQUIP: return "onEquip";
		case MOVE_EVENT_DEEQUIP: return "onDeEquip";
		case MOVE_EVENT_ADD_ITEM: return "onAddItem";
		case MOVE_EVENT_REMOVE_ITEM: return "onRemoveItem";
		default:
			std::cout << "[Error - MoveEvent::getScriptEventName] Invalid event type" << std::endl;
			return std::string();
	}
}

bool MoveEvent::configureEvent(const pugi::xml_node& node)
{
	pugi::xml_attribute eventAttr = node.attribute("event");
	if (!eventAttr) {
		std::cout << "[Error - MoveEvent::configureMoveEvent] Missing event" << std::endl;
		return false;
	}

	std::string tmpStr = asLowerCaseString(eventAttr.as_string());
	if (!tfs_strcmp(tmpStr.c_str(), "stepin")) {
		eventType = MOVE_EVENT_STEP_IN;
	} else if (!tfs_strcmp(tmpStr.c_str(), "stepout")) {
		eventType = MOVE_EVENT_STEP_OUT;
	} else if (!tfs_strcmp(tmpStr.c_str(), "equip")) {
		eventType = MOVE_EVENT_EQUIP;
	} else if (!tfs_strcmp(tmpStr.c_str(), "deequip")) {
		eventType = MOVE_EVENT_DEEQUIP;
	} else if (!tfs_strcmp(tmpStr.c_str(), "additem")) {
		eventType = MOVE_EVENT_ADD_ITEM;
	} else if (!tfs_strcmp(tmpStr.c_str(), "removeitem")) {
		eventType = MOVE_EVENT_REMOVE_ITEM;
	} else {
		std::cout << "Error: [MoveEvent::configureMoveEvent] No valid event name " << eventAttr.as_string() << std::endl;
		return false;
	}

	if (eventType == MOVE_EVENT_EQUIP || eventType == MOVE_EVENT_DEEQUIP) {
		pugi::xml_attribute slotAttribute = node.attribute("slot");
		if (slotAttribute) {
			tmpStr = asLowerCaseString(slotAttribute.as_string());
			if (!tfs_strcmp(tmpStr.c_str(), "head")) {
				slot = SLOTP_HEAD;
			} else if (!tfs_strcmp(tmpStr.c_str(), "necklace")) {
				slot = SLOTP_NECKLACE;
			} else if (!tfs_strcmp(tmpStr.c_str(), "backpack")) {
				slot = SLOTP_BACKPACK;
			} else if (!tfs_strcmp(tmpStr.c_str(), "armor")) {
				slot = SLOTP_ARMOR;
			} else if (!tfs_strcmp(tmpStr.c_str(), "right-hand")) {
				slot = SLOTP_RIGHT;
			} else if (!tfs_strcmp(tmpStr.c_str(), "left-hand")) {
				slot = SLOTP_LEFT;
			} else if (!tfs_strcmp(tmpStr.c_str(), "hand") || !tfs_strcmp(tmpStr.c_str(), "shield")) {
				slot = SLOTP_RIGHT | SLOTP_LEFT;
			} else if (!tfs_strcmp(tmpStr.c_str(), "legs")) {
				slot = SLOTP_LEGS;
			} else if (!tfs_strcmp(tmpStr.c_str(), "feet")) {
				slot = SLOTP_FEET;
			} else if (!tfs_strcmp(tmpStr.c_str(), "ring")) {
				slot = SLOTP_RING;
			} else if (!tfs_strcmp(tmpStr.c_str(), "ammo")) {
				slot = SLOTP_AMMO;
			} else {
				std::cout << "[Warning - MoveEvent::configureMoveEvent] Unknown slot type: " << slotAttribute.as_string() << std::endl;
			}
		}

		wieldInfo = 0;

		pugi::xml_attribute levelAttribute = node.attribute("level");
		if (levelAttribute) {
			reqLevel = pugi::cast<uint32_t>(levelAttribute.value());
			if (reqLevel > 0) {
				wieldInfo |= WIELDINFO_LEVEL;
			}
		}

		pugi::xml_attribute magLevelAttribute = node.attribute("maglevel");
		if (magLevelAttribute) {
			reqMagLevel = pugi::cast<uint32_t>(magLevelAttribute.value());
			if (reqMagLevel > 0) {
				wieldInfo |= WIELDINFO_MAGLV;
			}
		}

		pugi::xml_attribute premiumAttribute = node.attribute("premium");
		if (premiumAttribute) {
			premium = premiumAttribute.as_bool();
			if (premium) {
				wieldInfo |= WIELDINFO_PREMIUM;
			}
		}

		//Gather vocation information
		std::list<std::string> vocStringList;
		for (auto vocationNode : node.children()) {
			pugi::xml_attribute vocationNameAttribute = vocationNode.attribute("name");
			if (!vocationNameAttribute) {
				continue;
			}

			int32_t vocationId = g_vocations.getVocationId(vocationNameAttribute.as_string());
			if (vocationId != -1) {
				vocEquipMap[vocationId] = true;
				if (vocationNode.attribute("showInDescription").as_bool(true)) {
					vocStringList.push_back(asLowerCaseString(vocationNameAttribute.as_string()));
				}
			}
		}

		if (!vocEquipMap.empty()) {
			wieldInfo |= WIELDINFO_VOCREQ;
		}

		for (const std::string& str : vocStringList) {
			if (!vocationString.empty()) {
				if (str != vocStringList.back()) {
					vocationString.push_back(',');
					vocationString.push_back(' ');
				} else {
					vocationString += " and ";
				}
			}

			vocationString += str;
			vocationString.push_back('s');
		}
	}
	return true;
}

uint32_t MoveEvent::StepInField(Creature* creature, Item* item, const Position&)
{
	MagicField* field = item->getMagicField();
	if (field) {
		field->onStepInField(creature);
		return 1;
	}

	return LUA_ERROR_ITEM_NOT_FOUND;
}

uint32_t MoveEvent::StepOutField(Creature*, Item*, const Position&)
{
	return 1;
}

uint32_t MoveEvent::AddItemField(Item* item, Item*, const Position&)
{
	if (MagicField* field = item->getMagicField()) {
		Tile* tile = item->getTile();
		if (CreatureVector* creatures = tile->getCreatures()) {
			for (Creature* creature : *creatures) {
				field->onStepInField(creature);
			}
		}
		return 1;
	}
	return LUA_ERROR_ITEM_NOT_FOUND;
}

uint32_t MoveEvent::RemoveItemField(Item*, Item*, const Position&)
{
	return 1;
}

uint32_t MoveEvent::EquipItem(MoveEvent* moveEvent, Player* player, Item* item, slots_t slot, bool isCheck)
{
	if (player->isItemAbilityEnabled(slot)) {
		return 1;
	}

	if (!player->hasFlag(PlayerFlag_IgnoreWeaponCheck) && moveEvent->getWieldInfo() != 0) {
		if (player->getLevel() < moveEvent->getReqLevel() || player->getMagicLevel() < moveEvent->getReqMagLv()) {
			return 0;
		}

		if (moveEvent->isPremium() && !player->isPremium()) {
			return 0;
		}

		const VocEquipMap& vocEquipMap = moveEvent->getVocEquipMap();
		if (!vocEquipMap.empty() && vocEquipMap.find(player->getVocationId()) == vocEquipMap.end()) {
			return 0;
		}
	}

	if (isCheck) {
		return 1;
	}

	const ItemType& it = Item::items[item->getID()];
	if (it.transformEquipTo != 0) {
		g_game.transformItem(item, it.transformEquipTo);
	} else {
		player->setItemAbility(slot, true);
	}

	if (!it.abilities) {
		return 1;
	}

	if (it.abilities->invisible) {
		Condition* condition = Condition::createCondition(static_cast<ConditionId_t>(slot), CONDITION_INVISIBLE, -1, 0);
		player->addCondition(condition);
	}

	if (it.abilities->manaShield) {
		Condition* condition = Condition::createCondition(static_cast<ConditionId_t>(slot), CONDITION_MANASHIELD, -1, 0);
		player->addCondition(condition);
	}

	if (it.abilities->speed != 0) {
		g_game.changeSpeed(player, it.abilities->speed);
	}

	if (it.abilities->conditionSuppressions != 0) {
		player->addConditionSuppressions(it.abilities->conditionSuppressions);
		player->sendIcons();
	}

	if (it.abilities->regeneration) {
		Condition* condition = Condition::createCondition(static_cast<ConditionId_t>(slot), CONDITION_REGENERATION, -1, 0);

		if (it.abilities->healthGain != 0) {
			condition->setParam(CONDITION_PARAM_HEALTHGAIN, it.abilities->healthGain);
		}

		if (it.abilities->healthTicks != 0) {
			condition->setParam(CONDITION_PARAM_HEALTHTICKS, it.abilities->healthTicks);
		}

		if (it.abilities->manaGain != 0) {
			condition->setParam(CONDITION_PARAM_MANAGAIN, it.abilities->manaGain);
		}

		if (it.abilities->manaTicks != 0) {
			condition->setParam(CONDITION_PARAM_MANATICKS, it.abilities->manaTicks);
		}

		player->addCondition(condition);
	}

	//skill modifiers
	bool needUpdateSkills = false;

	for (int32_t i = SKILL_FIRST; i <= SKILL_LAST; ++i) {
		if (it.abilities->skills[i]) {
			needUpdateSkills = true;
			player->setVarSkill(static_cast<skills_t>(i), it.abilities->skills[i]);
		}
	}

	for (int32_t i = SPECIALSKILL_FIRST; i <= SPECIALSKILL_LAST; ++i) {
		if (it.abilities->specialSkills[i]) {
			needUpdateSkills = true;
			player->setVarSpecialSkill(static_cast<SpecialSkills_t>(i), it.abilities->specialSkills[i]);
		}
	}

	if (needUpdateSkills) {
		player->addScheduledUpdates(PlayerUpdate_Skills);
	}

	//stat modifiers
	bool needUpdateStats = false;

	for (int32_t s = STAT_FIRST; s <= STAT_LAST; ++s) {
		if (it.abilities->stats[s]) {
			needUpdateStats = true;
			player->setVarStats(static_cast<stats_t>(s), it.abilities->stats[s]);
		}

		if (it.abilities->statsPercent[s]) {
			needUpdateStats = true;
			player->setVarStats(static_cast<stats_t>(s), static_cast<int32_t>(player->getDefaultStats(static_cast<stats_t>(s)) * ((it.abilities->statsPercent[s] - 100) / 100.f)));
		}
	}

	if (needUpdateStats) {
		#if CLIENT_VERSION >= 1200
		//We have magic level in skills now so we need to send skills update too here
		player->addScheduledUpdates((PlayerUpdate_Stats | PlayerUpdate_Skills));
		#else
		player->addScheduledUpdates(PlayerUpdate_Stats);
		#endif
	}

	return 1;
}

uint32_t MoveEvent::DeEquipItem(MoveEvent*, Player* player, Item* item, slots_t slot, bool)
{
	if (!player->isItemAbilityEnabled(slot)) {
		return 1;
	}

	player->setItemAbility(slot, false);

	const ItemType& it = Item::items[item->getID()];
	if (it.transformDeEquipTo != 0) {
		g_game.transformItem(item, it.transformDeEquipTo);
	}

	if (!it.abilities) {
		return 1;
	}

	if (it.abilities->invisible) {
		player->removeCondition(CONDITION_INVISIBLE, static_cast<ConditionId_t>(slot));
	}

	if (it.abilities->manaShield) {
		player->removeCondition(CONDITION_MANASHIELD, static_cast<ConditionId_t>(slot));
	}

	if (it.abilities->speed != 0) {
		g_game.changeSpeed(player, -it.abilities->speed);
	}

	if (it.abilities->conditionSuppressions != 0) {
		player->removeConditionSuppressions(it.abilities->conditionSuppressions);
		player->sendIcons();
	}

	if (it.abilities->regeneration) {
		player->removeCondition(CONDITION_REGENERATION, static_cast<ConditionId_t>(slot));
	}

	//skill modifiers
	bool needUpdateSkills = false;

	for (int32_t i = SKILL_FIRST; i <= SKILL_LAST; ++i) {
		if (it.abilities->skills[i] != 0) {
			needUpdateSkills = true;
			player->setVarSkill(static_cast<skills_t>(i), -it.abilities->skills[i]);
		}
	}

	for (int32_t i = SPECIALSKILL_FIRST; i <= SPECIALSKILL_LAST; ++i) {
		if (it.abilities->specialSkills[i] != 0) {
			needUpdateSkills = true;
			player->setVarSpecialSkill(static_cast<SpecialSkills_t>(i), -it.abilities->specialSkills[i]);
		}
	}

	if (needUpdateSkills) {
		player->addScheduledUpdates(PlayerUpdate_Skills);
	}

	//stat modifiers
	bool needUpdateStats = false;

	for (int32_t s = STAT_FIRST; s <= STAT_LAST; ++s) {
		if (it.abilities->stats[s]) {
			needUpdateStats = true;
			player->setVarStats(static_cast<stats_t>(s), -it.abilities->stats[s]);
		}

		if (it.abilities->statsPercent[s]) {
			needUpdateStats = true;
			player->setVarStats(static_cast<stats_t>(s), -static_cast<int32_t>(player->getDefaultStats(static_cast<stats_t>(s)) * ((it.abilities->statsPercent[s] - 100) / 100.f)));
		}
	}

	if (needUpdateStats) {
		#if CLIENT_VERSION >= 1200
		//We have magic level in skills now so we need to send skills update too here
		player->addScheduledUpdates((PlayerUpdate_Stats | PlayerUpdate_Skills));
		#else
		player->addScheduledUpdates(PlayerUpdate_Stats);
		#endif
	}

	return 1;
}

bool MoveEvent::loadFunction(const pugi::xml_attribute& attr, bool isScripted)
{
	const char* functionName = attr.as_string();
	if (strcasecmp(functionName, "onstepinfield") == 0) {
		stepFunction = StepInField;
	} else if (strcasecmp(functionName, "onstepoutfield") == 0) {
		stepFunction = StepOutField;
	} else if (strcasecmp(functionName, "onaddfield") == 0) {
		moveFunction = AddItemField;
	} else if (strcasecmp(functionName, "onremovefield") == 0) {
		moveFunction = RemoveItemField;
	} else if (strcasecmp(functionName, "onequipitem") == 0) {
		equipFunction = EquipItem;
	} else if (strcasecmp(functionName, "ondeequipitem") == 0) {
		equipFunction = DeEquipItem;
	} else {
		if (!isScripted) {
			std::cout << "[Warning - MoveEvent::loadFunction] Function \"" << functionName << "\" does not exist." << std::endl;
			return false;
		}
	}

	if (!isScripted) {
		scripted = false;
	}
	return true;
}

MoveEvent_t MoveEvent::getEventType() const
{
	return eventType;
}

void MoveEvent::setEventType(MoveEvent_t type)
{
	eventType = type;
}

uint32_t MoveEvent::fireStepEvent(Creature* creature, Item* item, const Position& pos)
{
	if (scripted) {
		return executeStep(creature, item, pos);
	} else {
		return stepFunction(creature, item, pos);
	}
}

bool MoveEvent::executeStep(Creature* creature, Item* item, const Position& pos)
{
	//onStepIn(creature, item, pos, fromPosition)
	//onStepOut(creature, item, pos, fromPosition)
	if (!scriptInterface->reserveScriptEnv()) {
		std::cout << "[Error - MoveEvent::executeStep] Call stack overflow" << std::endl;
		return false;
	}

	ScriptEnvironment* env = scriptInterface->getScriptEnv();
	env->setScriptId(scriptId, scriptInterface);

	lua_State* L = scriptInterface->getLuaState();

	scriptInterface->pushFunction(scriptId);
	LuaScriptInterface::pushUserdata<Creature>(L, creature);
	LuaScriptInterface::setCreatureMetatable(L, -1, creature);
	LuaScriptInterface::pushThing(L, item);
	LuaScriptInterface::pushPosition(L, pos);
	LuaScriptInterface::pushPosition(L, creature->getLastPosition());

	return scriptInterface->callFunction(4);
}

uint32_t MoveEvent::fireEquip(Player* player, Item* item, slots_t slot, bool isCheck)
{
	if (scripted) {
		if (!equipFunction || equipFunction(this, player, item, slot, isCheck) == 1) {
			if (executeEquip(player, item, slot, isCheck)) {
				return 1;
			}
		}
		return 0;
	} else {
		return equipFunction(this, player, item, slot, isCheck);
	}
}

bool MoveEvent::executeEquip(Player* player, Item* item, slots_t slot, bool isCheck)
{
	//onEquip(player, item, slot, isCheck)
	//onDeEquip(player, item, slot, isCheck)
	if (!scriptInterface->reserveScriptEnv()) {
		std::cout << "[Error - MoveEvent::executeEquip] Call stack overflow" << std::endl;
		return false;
	}

	ScriptEnvironment* env = scriptInterface->getScriptEnv();
	env->setScriptId(scriptId, scriptInterface);

	lua_State* L = scriptInterface->getLuaState();

	scriptInterface->pushFunction(scriptId);
	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");
	LuaScriptInterface::pushThing(L, item);
	lua_pushnumber(L, slot);
	LuaScriptInterface::pushBoolean(L, isCheck);

	return scriptInterface->callFunction(4);
}

uint32_t MoveEvent::fireAddRemItem(Item* item, Item* tileItem, const Position& pos)
{
	if (scripted) {
		return executeAddRemItem(item, tileItem, pos);
	} else {
		return moveFunction(item, tileItem, pos);
	}
}

bool MoveEvent::executeAddRemItem(Item* item, Item* tileItem, const Position& pos)
{
	//onAddItem(moveitem, tileitem, pos)
	//onRemoveItem(moveitem, tileitem, pos)
	if (!scriptInterface->reserveScriptEnv()) {
		std::cout << "[Error - MoveEvent::executeAddRemItem] Call stack overflow" << std::endl;
		return false;
	}

	ScriptEnvironment* env = scriptInterface->getScriptEnv();
	env->setScriptId(scriptId, scriptInterface);

	lua_State* L = scriptInterface->getLuaState();

	scriptInterface->pushFunction(scriptId);
	LuaScriptInterface::pushThing(L, item);
	LuaScriptInterface::pushThing(L, tileItem);
	LuaScriptInterface::pushPosition(L, pos);

	return scriptInterface->callFunction(3);
}
