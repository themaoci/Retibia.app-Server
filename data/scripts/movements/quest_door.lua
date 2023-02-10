local questdoor = MoveEvent()
questdoor:type("stepin")

function questdoor.onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return false
	end

	if creature:getStorageValue(item.actionid) == -1 then
		creature:sendTextMessage(MESSAGE_INFO_DESCR, "The door seems to be sealed against unwanted intruders.")
		creature:teleportTo(fromPosition, true)
		return false
	end
	return true
end

for _, i in ipairs(openQuestDoors) do
	questdoor:id(i)
end
questdoor:register()