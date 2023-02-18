-- Made by TheMaoci & TheSxW for Retibia server at 18.09.2022
-- Shared on OTLand.net on 11.02.2023
-- All rights reserved for original creators
-- Script should work on most OTS'es was running on TFS 1.4

if GameConfig.EnableDevTestingChest then
  print("*** DEVELOPER CHEST: ACTIVE ***")
  local BackpackItems = {
    [2365] = { amount = 1, cap = 15, name = "backpack of holding" }, -- bp 24 slots
  }
  local ItemsToGive = {
    [6132] = { amount = 1, cap = 8, name = "soft boots" }, -- soft boots
    [2323] = { amount = 1, cap = 4.5, name = "had of the mad" }, -- had of the mad
    [8871] = { amount = 1, cap = 21, name = "focus cape" }, -- focus cape
    [2195] = { amount = 1, cap = 7.5, name = "boh" }, -- boh
    [7730] = { amount = 1, cap = 18, name = "blue legs" }, -- blue legs
    [2173] = { amount = 1, cap = 4.2, name = "aol" }, -- aol
    [2520] = { amount = 1, cap = 26, name = "demon shield" }, -- demon shield
    [2409] = { amount = 1, cap = 41, name = "serpent sword" }, -- serpent sword
    [2403] = { amount = 1, cap = 4.2, name = "knife" }, -- knife
    [21696] = { amount = 1, cap = 42, name = "icicle bow" }, -- icicle bow
    [2455] = { amount = 1, cap = 40, name = "crossbow" } -- crossbow
    --[10513] = { amount = 1, cap = 0 } -- scyzoryk
  }
  local ItemsToGiveFood = {
    [2789] = { amount = 100, cap = 0.2, name = "brown mushroom" } -- brown mushroom
  }
  local ItemsToGivePotions = {
    [7618] = { amount = 20, cap = 2.7, name = "health potion" }, -- health potion
    [7620] = { amount = 20, cap = 2.7, name = "mana potion" } -- mana potion
  }
  local ItemsToGiveAmmo = {
    [2544] = { amount = 50, cap = 0.7, name = "arrow bow" }, -- arrow bow
    [2543] = { amount = 50, cap = 0.8, name = "arrow crossbow" }, -- arrow crossbow
    [1294] = { amount = 10, cap = 3.6, name = "small stone" }, -- small stone
    [2389] = { amount = 5, cap = 20, name = "spear" } -- spear
  }
  local ItemsToGiveCashOnly = {
    [2160] = { amount = 10, cap = 0.1, name = "crystal coin" } -- crystal coin
  }
  local ItemsToGiveRings = {
    [2169] = { amount = 5, cap = 0.9, name = "time ring" }, -- time ring
    [2214] = { amount = 5, cap = 0.8, name = "ring of healing" } -- ring of healing
  }

  local developerChest = Action()

  function developerChest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    player:registerEvent("DeveloperChest_Modal_Window")

    local title = "Dev Chest"
    local message = "List of options:"
      
    local window = ModalWindow(item.actionid, title, message)
    window:addButton(100, "Get")
    window:addButton(101, "Cancel")
      
    window:addChoice(1, "Start Equipment")
    window:addChoice(2, "Food")
    window:addChoice(3, "Potions")
    window:addChoice(4, "Ammunition")
    window:addChoice(5, "Crystal coins x10")
    window:addChoice(6, "Rings")
    window:addChoice(7, "Backpack of Holding")

    window:setDefaultEnterButton(100)
    window:setDefaultEscapeButton(101)
    
    window:sendToPlayer(player)
    return true
  end

  developerChest:aid(13370) -- item action id you want to use for this menu!!!
  developerChest:register()

  local modalDeveloperChest = CreatureEvent("DeveloperChest_Modal_Window")
  modalDeveloperChest:type("modalwindow")

  function modalDeveloperChest.onModalWindow(player, modalWindowId, buttonId, choiceId)
      player:unregisterEvent("DeveloperChest_Modal_Window")
        if buttonId == 100 then
          player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
          local ItemsToGiveTable = nil
          if choiceId == 1 then
            ItemsToGiveTable = ItemsToGive
          elseif choiceId == 2 then
            ItemsToGiveTable = ItemsToGiveFood
          elseif choiceId == 3 then
            ItemsToGiveTable = ItemsToGivePotions
          elseif choiceId == 4 then
            ItemsToGiveTable = ItemsToGiveAmmo
          elseif choiceId == 5 then
            ItemsToGiveTable = ItemsToGiveCashOnly
          elseif choiceId == 6 then
            ItemsToGiveTable = ItemsToGiveRings
          elseif choiceId == 7 then
            ItemsToGiveTable = BackpackItems
          end
          if(ItemsToGiveTable == nil) then
            return true
          end
          if getPlayerFreeCap(player) > BackpackItems[2365].cap then
            if(choiceId == 7) then
              local backpack = doPlayerAddItem(player, 2365, 1)
              print(player:getName() .. " used Dev chest with option " .. choiceId .. " backpack of holding")
              return true
            end
            local backpack = doPlayerAddItem(player, 2365, 1)
            print(player:getName() .. " used Dev chest with option " .. choiceId)
            for id in pairs(ItemsToGiveTable) do 
              if getPlayerFreeCap(player) >= (ItemsToGiveTable[id].cap * ItemsToGiveTable[id].amount) then
                doAddContainerItem(backpack, id, ItemsToGiveTable[id].amount)
                doPlayerSendTextMessage(player,22,"Received " .. ItemsToGiveTable[id].name .. " x" .. (ItemsToGiveTable[id].amount) .. "!")
              else 
                doPlayerSendTextMessage(cid,22,"You dont have cap to receive " .. ItemsToGiveTable[id].name .. " which requires at last " .. (ItemsToGiveTable[id].cap * ItemsToGiveTable[id].amount) .. "!")
              end
            end
          end
        end
      return true
  end

  modalDeveloperChest:register()
end

