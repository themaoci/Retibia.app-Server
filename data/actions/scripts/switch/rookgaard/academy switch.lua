function onUse(cid, item, frompos, item2, topos)
  gatepos = {x=380, y=348, z=8, stackpos=1}
  getgate = getThingfromPos(gatepos)
  --dumppos = {x=32095, y=32174, z=8}

  if item.itemid == 1945 then
    doRemoveItem(getgate.uid, 1)
    doTransformItem(item.uid, item.itemid+1)
  elseif item.itemid == 1946 then
    doCreateItem(1050, 1, gatepos)
    doTransformItem(item.uid, item.itemid-1)
  else
    doPlayerSendCancel(cid,"Sorry not possible.")
  end
  return 1
end