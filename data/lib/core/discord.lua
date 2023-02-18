DiscordHelper = {}
DiscordHelper.channelTypes = {
    SERVER = 0,
    BROADCAST = 1,
    GLOBALCHAT = 2,
    EVENT = 10,
    STATUS = 11,
    DEBUG = 80,
    ADM_INFO = 90
}
DiscordHelper.broadcastChannel = "1022938910361387120/SADLVfZd2NWT_H1YEQGUcT_ucrz-g9_DV4ya3Abv2EWkwxrgTZH0zN6oHx7KSbYSw_cW"
DiscordHelper.serverChannel = "1022947548610187288/P2TwdzMiAe-9Ei9cYGhb3KtHL4XeGkEMbfOWjm06B2Hg5rY_ODbNK3UBJt2Ww1dSX3B_"
DiscordHelper.debugChannel = "1023191912716443668/FEQEmEedzY6s6J57wTPweUMYiAkAKGHBfHgeQgZASp0i_RYMT0ypAuWy7Vjxin3U_XPM"
DiscordHelper.eventChannel = "1023192744056852490/rsOlrCg8yrNs8U8jTjAR_mrJSr_TVeacqUO6WHdR5iwc2mhkxZhgn3FzlgIWcQ7DD5Bw"
DiscordHelper.statusChannel = "1022947548610187288/P2TwdzMiAe-9Ei9cYGhb3KtHL4XeGkEMbfOWjm06B2Hg5rY_ODbNK3UBJt2Ww1dSX3B_"
DiscordHelper.admInfoChannel = "1022949135449608274/PzK5sXneCWIfjaDQd7-yusVdcD5wC_nbOVD0Vti94tQ-46FcUSpqcyJ-uEF7kbzOUaMo"


DiscordHelper.sendMessage = function(message, type)
  -- need to add this to server first...
    if type == 0 then
		Discord.webhook(
			"https://discord.com/api/webhooks/" .. DiscordHelper.serverChannel, 
			message)
    end
    if type == 1 then
		Discord.webhook(
			"https://discord.com/api/webhooks/" .. DiscordHelper.broadcastChannel, 
			message)
    end
    if type == 2 then
		-- Discord.webhook(
		-- 	"https://discord.com/api/webhooks/" .. DiscordHelper.broadcastChannel, 
		-- 	message)
    end
    if type == 10 then
		Discord.webhook(
			"https://discord.com/api/webhooks/" .. DiscordHelper.eventChannel, 
			message)
    end
    if type == 11 then
		Discord.webhook(
			"https://discord.com/api/webhooks/" .. DiscordHelper.statusChannel, 
			message)
    end
    if type == 80 then
		Discord.webhook(
			"https://discord.com/api/webhooks/" .. DiscordHelper.debugChannel, 
			message)
    end
    if type == 90 then
		Discord.webhook(
			"https://discord.com/api/webhooks/" .. DiscordHelper.admInfoChannel, 
			message)
    end

end