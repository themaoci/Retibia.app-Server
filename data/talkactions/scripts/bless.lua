local blessings = {
    "Spiritual Shielding",
    "Embrace of the World",
    "Fire of the Suns",
    "Spark of the Phoenix",
    "Wisdom of Solitude",
    "Twist of Fate"
}
function onSay(player, words, param)
	local message = {"Received blessings:"}
    for i, blessing in pairs(blessings) do
        if player:hasBlessing(i) then
            message[#message + 1] = blessing
        end
    end
    player:sendTextMessage(MESSAGE_INFO_DESCR, #message == 1 and "No blessings received." or table.concat(message, '\n'))
	return false
end