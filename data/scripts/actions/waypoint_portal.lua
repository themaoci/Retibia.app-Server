local waypoint_portal = Action()
function waypoint_portal.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	--print(GameConfig.Waypoint.Config.PlayerStorageValue + item:getUniqueId());
  local isDev = player:getAccountType() == ACCOUNT_TYPE_GOD
  -- add this waypoint to player saved waypoints 
  if GameConfig.Waypoint.Config.EnableSavingWaypoints then
    if player:getStorageValue(GameConfig.Waypoint.Config.PlayerStorageValue + item:getUniqueId()) ~= 1 then
      player:setStorageValue(GameConfig.Waypoint.Config.PlayerStorageValue + item:getUniqueId(), 1)
    end
  end
  
  player:registerEvent("WaypointPortal_Modal_Window")

  local title = "Waypoint Globe - Teleporter"
  local message = "Choose visided waypoint:"
    
  local window = ModalWindow(item.actionid, title, message)
  window:addButton(100, "Teleport")
  window:addButton(101, "Close")

  -- Create an array of keys sorted in ascending order
  local keys = {}
  for k in pairs(GameConfig.Waypoint.Locations) do
    table.insert(keys, k)
  end
  table.sort(keys)
  -- Iterate over the keys and access the corresponding data
  for i, k in ipairs(keys) do 
    if item:getUniqueId() == k + 1000 then
      goto continue
    end
    if isDev or player:getStorageValue(GameConfig.Waypoint.Config.PlayerStorageValue + item:getUniqueId()) == 1 then
      local devText = ""
      if isDev and player:getStorageValue(GameConfig.Waypoint.Config.PlayerStorageValue + item:getUniqueId()) == 1 then
        devText = " (Known)"
      end
      window:addChoice(k, GameConfig.Waypoint.Locations[k].Name .. devText)
    end
    ::continue::
  end

  window:setDefaultEnterButton(100)
  window:setDefaultEscapeButton(101)
  window:sendToPlayer(player)
  
	return true
end
waypoint_portal:aid(GameConfig.Waypoint.Config.ObjectActionId) -- item action id you want to use for this menu!!!
waypoint_portal:register()


local modalWaypointPortalObject = CreatureEvent("WaypointPortal_Modal_Window")
modalWaypointPortalObject:type("modalwindow")

function modalWaypointPortalObject.onModalWindow(player, modalWindowId, buttonId, choiceId)
    player:unregisterEvent("WaypointPortal_Modal_Window")
      if buttonId == 100 then
        if GameConfig.Waypoint.Locations[choiceId] ~= nil then
          player:getPosition():sendMagicEffect(GameConfig.Waypoint.Config.TeleportEffectOut)
          player:teleportTo(GameConfig.Waypoint.Locations[choiceId].pos)
          player:getPosition():sendMagicEffect(GameConfig.Waypoint.Config.TeleportEffectIn)
        end
      end
    return true
end

modalWaypointPortalObject:register()
