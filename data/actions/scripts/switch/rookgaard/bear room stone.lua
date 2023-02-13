function onUse(cid, item, frompos, item2, topos)
  stonepos = {x=430, y=276, z=11, stackpos=1}
  getstone = getThingfromPos(stonepos)
  --dumppos = {x=32145, y=32102, z=11}
  if item.itemid == 1945 then
    doRemoveItem(getstone.uid,1)
    doTransformItem(item.uid,item.itemid+1)

  elseif item.itemid == 1946 then
    doCreateItem(1304,1,stonepos)
    doTransformItem(item.uid,item.itemid-1)
  else
    doPlayerSendCancel(cid,"Sorry not possible.")
  end
  return 1
end