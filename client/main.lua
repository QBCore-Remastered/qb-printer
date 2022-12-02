RegisterNetEvent('qb-printer:client:UseDocument', function(ItemData)
    local DocumentUrl = ItemData.info.url or false

    SendNUIMessage({
        action = "open",
        url = DocumentUrl
    })
    SetNuiFocus(true, false)
end)

RegisterNetEvent('qb-printer:client:SpawnPrinter', function()
    local coords = GetEntityCoords(cache.ped)
    local forward = GetEntityForwardVector(cache.ped)
    local x, y, z = table.unpack(coords + forward * 1.0)
    local model = joaat('prop_printer_01')

    lib.requestModel(model)

    local obj = CreateObject(model, x, y, z, true, false, true)

    PlaceObjectOnGroundProperly(obj)
    SetModelAsNoLongerNeeded(model)
    SetEntityAsMissionEntity(obj)
end)

-- NUI
RegisterNUICallback('SaveDocument', function(data, cb)
    if data.url then
        TriggerServerEvent('qb-printer:server:SaveDocument', data.url)
    end

    cb('ok')
end)

RegisterNUICallback('CloseDocument', function(_, cb)
    SetNuiFocus(false, false)

    cb('ok')
end)

RegisterNetEvent('qb-printer:printer', function()
    SendNUIMessage({
        action = "start"
    })
    SetNuiFocus(true, true)
end)

if Config.UseTarget then
    CreateThread(function()
        exports.ox_target:addModel(joaat('prop_printer_01'), {
            {
                name = 'printer:print',
                icon = "fa-solid fa-print",
                label = Lang:t('info.use_printer'),
                event = 'qb-printer:printer'
            }
        })
    end)
else
    RegisterCommand('useprinter', function()
        local pos = GetEntityCoords(cache.ped)
        local PrinterObject = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.5, joaat('prop_printer_01'), false, false, false)

        if PrinterObject ~= 0 then
            SendNUIMessage({
                action = "start"
            })
            SetNuiFocus(true, true)
        end
    end)
end