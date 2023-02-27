function onCastSpell(creature, variant, isHotkey)
    local position = player:getPosition()
	doPlayerSendTextMessage(creature, MESSAGE_STATUS_CONSOLE_BLUE, ("Your current position is: %d, %d, %d"):format(position.x, position.y, position.z))
	return true
end