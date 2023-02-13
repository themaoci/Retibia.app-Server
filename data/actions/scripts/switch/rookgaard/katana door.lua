-- quest door position
local doorPosition = Position(462, 323, 11)
-- where to move player/creature when doors are leaver closed
local relocatePosition = Position(463, 323, 11)

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 1946 then
		local doorItem = Tile(doorPosition):getItemById(5108)
		if doorItem then
			doorItem:transform(5109)
			doorItem:setActionId(1002)
			item:transform(1945)
		end
	else
		local tile = Tile(doorPosition)
		local doorItem = tile:getItemById(5109)
		if doorItem then
			tile:relocateTo(relocatePosition, true)

			doorItem:transform(5108)
			doorItem:setActionId(1001)
			item:transform(1946)
		end
	end
	return true
end

-- function onUse(cid, item, frompos, item2, topos)
  -- gatepos = {x=32177, y=32148, z=11, stackpos=1}
  -- getgate = getThingfromPos(gatepos)
  -- teleportpos = {x=32171, y=32149, z=11, stackpos=1}
  -- getteleport = getThingfromPos(gatepos)
  -- dooropen = {x=32173, y=32148, z=11}
  -- wallclosed = {x=32178, y=32148, z=11}
  -- dumppos = {x=32178, y=32148, z=11}

  -- if item.itemid == 1945 then
  -- doRemoveItem(getgate.uid,1)
  -- doRemoveItem(getteleport.uid,1)
  -- doCreateTeleport(1387, dooropen, teleportpos)
  -- doCreateItem(1210,1,gatepos)
  -- doTransformItem(item.uid,item.itemid+1)

  -- elseif item.itemid == 1946 then
  -- doRemoveItem(getgate.uid,1)
  -- doRemoveItem(getteleport.uid,1)
  -- doCreateTeleport(1387, wallclosed, teleportpos)
  -- doCreateItem(1025,1,gatepos)
  -- doTransformItem(item.uid,item.itemid-1)
  -- else
  -- doPlayerSendCancel(cid,"Sorry not possible.")
  -- end
  -- return 1
-- end
  