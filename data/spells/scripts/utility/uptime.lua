function onCastSpell(creature, variant, isHotkey)
	local uptime = getWorldUpTime()
	local hours = math.floor(uptime / 3600)
	local minutes = math.floor((uptime - (3600 * hours)) / 60)
    local hoursText = hours == 1 and "hour" or "hours"
    local minutesText = minutes == 1 and "minute" or "minutes"    
	doPlayerSendTextMessage(creature, MESSAGE_STATUS_CONSOLE_BLUE, "This world is constantly alive for " .. hours .. " " .. hoursText .. " and " .. minutes .. " " .. minutesText .. ".")
	return true
end