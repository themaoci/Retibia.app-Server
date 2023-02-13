local bridgePosition = {x=385, y=380, z=8, stackpos=1}
local leverPosition_1 = {x=383, y=379, z=8}
local leverPosition_2 = {x=389, y=379, z=8}

function updateSwitches(pos1, pos2, state)
  if state then
    doTransformItem(getTileItemById(pos1, 1945).uid,1946)
    doTransformItem(getTileItemById(pos2, 1945).uid,1946)		
  else 
    doTransformItem(getTileItemById(pos1, 1946).uid,1945)
    doTransformItem(getTileItemById(pos2, 1946).uid,1945)
  end
end

function onUse(cid, item, frompos, item2, topos)
    
  if item.itemid == 1945 then	

    doCreateItem(405,1,bridgePosition)
    updateSwitches(leverPosition_1, leverPosition_2, true)

  elseif item.itemid == 1946 then

    doCreateItem(4608,1,bridgePosition)
    updateSwitches(leverPosition_1, leverPosition_2, false)

  else
    doPlayerSendCancel(cid,"Sorry not possible.")
  end
  return 1
end