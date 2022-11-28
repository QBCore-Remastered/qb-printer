local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("printerdocument", function(source, item)
    TriggerClientEvent('qb-printer:client:UseDocument', source, item)
end)

QBCore.Commands.Add("spawnprinter", Lang:t('command.spawn_printer'), {}, true, function(source, _)
	TriggerClientEvent('qb-printer:client:SpawnPrinter', source)
end, "admin")

RegisterNetEvent('qb-printer:server:SaveDocument', function(url)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local extension = string.sub(url, -4)

    if not url then
        return
    end

    if not Config.ValidExtensions[extension] then
        TriggerClientEvent('ox_lib:notify', src, {
            description = Lang:t('error.invalid_ext'),
            type = 'error'
        })
        return
    end

    Player.Functions.AddItem('printerdocument', 1, nil, {
        url = url
    })
end)