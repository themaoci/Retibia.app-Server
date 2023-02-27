function onSay(player, words, param)
    local currentTime = Game.getCurrentTibianTime()
    local sunsetTime = Game.getSunsetTime()
    local sunriseTime = Game.getSunriseTime()

    local leftTillSunset = math.abs(currentTime - sunsetTime)
    local leftTillSunrise = math.abs(currentTime - sunriseTime)
	local hours = math.floor(currentTime / 60)
	local minutes = math.floor((currentTime - (60 * hours)))
    local type = "sunset"
    local special_hours = 0
    local special_minutes = 0
    if(currentTime < sunriseTime) then
        type = "sunrise"
        special_hours = math.floor(leftTillSunrise / 60)
        special_minutes = math.floor((leftTillSunrise - (60 * special_hours)))
    else
        special_hours = math.floor(leftTillSunset / 60)
        special_minutes = math.floor((leftTillSunset - (60 * special_hours)))
    end
    
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "It's " .. hours .. ":" .. minutes .. ". ".. special_hours .. " hours and " .. special_minutes .. " minutes till " .. type)
	return false
end
