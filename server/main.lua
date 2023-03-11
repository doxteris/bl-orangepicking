lib.callback.register('baylife-orangepicking:canCarry', function(source, item, amount)
    
    if exports.ox_inventory:CanCarryItem(source, 'orange', 1) then
        return true
    else
        return false
    end

end)

local function getTree()
    local ped = GetPlayerPed(source)
    local coords = GetEntityCoords(ped)

    for k, v in pairs(Config.Trees) do
        local dist = #(coords - v.coords)

        if dist < 3.0 then
            return v
        end
    end

    return false
end

lib.callback.register('baylife-orangepicking:giveOrange', function(source, item, amount)
    
    local playerCoords = GetEntityCoords(GetPlayerPed(source))
    local targetCoords = getTree().coords

    local distance = #(playerCoords - targetCoords)
    
    if (distance <= 3.0) then
        exports.ox_inventory:AddItem(source, 'orange', math.random(1, 3))
  --[[  else
        print('ID: '.. source .. ' may have cheats.')
        print('Tried to get weed at Weed Field')
        print('His distance from Weed Field is: ' .. distance)

        --add your log system]]
    end

end)

lib.callback.register('baylife-orangepicking:doesHaveItem', function(source, item, amount)

    local itemCount = exports.ox_inventory:GetItem(source, 'orange', nil,  true)
    return itemCount

end)

lib.callback.register('baylife-orangepicking:canConvert', function(source, item, amount)

    exports.ox_inventory:CanSwapItem(source, 'orange', 3, 'orangejuice', 1)
    return 

end)
