function onUse(cid, item, frompos, item2, topos)
  Switch1Pos = {x=272, y=404, z=11, stackpos=1}
  Switch2Pos = {x=283, y=406, z=11, stackpos=1}
  getSwitch1 = getThingfromPos(Switch1Pos)
  getSwitch2 = getThingfromPos(Switch2Pos)
  DoorPos = {x=277, y=406, z=12, stackpos=1}
  getDoor = getThingfromPos(DoorPos)
  if item.itemid == 1946 then
    doPlayerSendCancel(cid,"The switch seems to be stuck.")
    return 1
  end
  if getSwitch1.itemid == 1946 or getSwitch2.itemid == 1946 then
    doRemoveItem(getDoor.uid,1)
    ACTIONDOOR = doCreateItem(1225,1,DoorPos)
    doSetItemActionId(ACTIONDOOR, 7037)
  end
  doTransformItem(item.uid,item.itemid+1)

  return 1
end
  