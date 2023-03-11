AddEventHandler('ox:playerLoaded', function()
    createBlip()
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        createBlip() 
    end
end)

function createBlip()
    for i, v in  ipairs( Config.Blips ) do 
        local blip = AddBlipForCoord(v.coords)
        SetBlipSprite (blip, v.sprite)
        SetBlipDisplay(blip, 2)
        SetBlipScale  (blip, 0.8)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(v.name)
        EndTextCommandSetBlipName(blip)
    end
end

for i, v in  ipairs( Config.Trees ) do 
    local point = lib.points.new(v.coords, 5, {})

    function point:onEnter()
        exports.ox_target:addBoxZone({
            coords = v.coords,
            size = vec3(2, 2, 2),
            rotation = 0,
            debug = false,
            options = {
                {
                    name = 'box',
                    event = 'ox_target:debug',
                    icon = 'fa-solid fa-cube',
                    label = 'Rinkti apelsinus',
                    canInteract = function(entity, distance, coords, name)
                        return true
                    end,
                    onSelect = function(data)
                        local canCarry = lib.callback.await('baylife-orangepicking:canCarry')
                         if not canCarry then return end

                        local success = lib.skillCheck({'easy', 'easy', {areaSize = 60, speedMultiplier = 1}, 'medium'})
                        if success then 
                            local giveOrange = lib.callback.await('baylife-orangepicking:giveOrange')      
                        else
                            lib.notify({
                                title = 'Apelsinu rinkimas',
                                description = 'Isidurei i saka ir nenuskynei apelsino',
                                type = 'error'
                            })
                        end    

                    end
                }
            }
        })
    end

    for i, v in  ipairs( Config.Tables ) do 
        local point = lib.points.new(v.coords, 5, {})
    
        function point:onEnter()
            exports.ox_target:addBoxZone({
                coords = v.coords,
                size = vec3(2, 2, 2),
                rotation = 0,
                debug = true,
                options = {
                    {
                        name = 'box',
                        event = 'ox_target:debug',
                        icon = 'fa-solid fa-citrus',
                        label = 'Spausti sultis',
                        canInteract = function(entity, distance, coords, name)
                            return true
                        end,
                        onSelect = function(data)

                            local convertJuice = lib.callback.await('baylife-orangepicking:doesHaveItem')
                            if convertJuice <= 0 then return end
                            
                                                            
                                print ('convertina')
                                local canConvert = lib.callback.await('baylife-orangepicking:canConvert') 
                                if not canConvert then return end

                                if canConvert then
                                    print(canConvert)
                                end
    
                        end
                    }
                }
            })
        end
    end

    function point:onExit()
        print('left range of point', self.id)
    end
end

