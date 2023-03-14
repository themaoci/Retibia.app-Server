local TeleportTo = Position(686, 245, 8)
SecretPasagePressedCodes = {}
function onUse(cid, item, frompos, item2, topos)
    local itemActionId = item:getActionId()
    local itemUniqueId = item:getUniqueId()
    local itemCodeId = itemUniqueId - itemActionId
    local player = Player(cid)

    if secretPassage_code[#SecretPasagePressedCodes + 1] == itemCodeId then
        table.insert(SecretPasagePressedCodes, #SecretPasagePressedCodes + 1, itemCodeId)
        if #secretPassage_code == #SecretPasagePressedCodes then
            --perform teleportation
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            player:teleportTo(TeleportTo)
            return true
        end
        player:getPosition():sendMagicEffect(CONST_ME_ENERGYHIT)
    else
        SecretPasagePressedCodes = {}
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end
    return 1
  end