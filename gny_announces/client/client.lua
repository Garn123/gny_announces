local timer, loaded = 0, false
local QBCore, ESX = nil, nil

if Config.Framework == 'QBCore' then
    QBCore = exports['qb-core']:GetCoreObject()
    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    loaded = true
    end)
elseif Config.Framework == 'ESX' then
    ESX = exports['es_extended']:getSharedObject()
    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(playerData)
        loaded = true
    end)
end

AddEventHandler('onResourceStart', function(resourceName)
    loaded = true
end)

local timerLoop = function(tiempo)
    timer = tiempo
    CreateThread(function()
        while timer > 0 do
            Wait(1000)
            timer = timer - 1000
        end
    end)
end

local ShowAnnounce = function(announce, tipo)
    if loaded then
        for k, v in pairs(Config.Announces) do
            if tipo == k then
                SendNUIMessage({
                    type = 'announce',
                    text = announce,
                    background = v.background,
                    color = v.color,
                    shadow = v.shadow,
                    duration = Config.Duration
                })
            end
        end
    end
end

RegisterNetEvent('gny:ShowAnnounce', ShowAnnounce)

RegisterCommand(Config.Command, function(source, args)
    local mensaje = ''
    for i, valor in ipairs(args) do
        if i > 1 then
            mensaje = mensaje .. " "
        end
        mensaje = mensaje .. valor
    end
    if Config.Framework == 'QBCore' then
        local gny_player = QBCore.Functions.GetPlayerData()
        local gny_job = gny_player.job
        for k, v in pairs(Config.Announces) do
            if k == gny_job.name then
                if gny_job.grade.level >= v.minRank then
                    if timer == 0 then
                        timerLoop(Config.Delay)
                        TriggerServerEvent('gny:SyncAnnounce', mensaje, k)
                    else
                        QBCore.Functions.Notify(
                            'Tienes que esperar ' ..
                            math.floor(timer / 1000) .. ' segundos para poder enviar otro anuncio',
                            'error')
                    end
                else
                    QBCore.Functions.Notify('No tienes el rango suficiente para enviar un anuncio', 'error')
                end
            end
        end
    elseif Config.Framework == 'ESX' then
        local gny_player = ESX.GetPlayerData()
        local gny_job = gny_player.job
        for k, v in pairs(Config.Announces) do
            if k == gny_job.name then
                if gny_job.grade >= v.minRank then
                    if timer == 0 then
                        timerLoop(Config.Delay)
                        TriggerServerEvent('gny:SyncAnnounce', mensaje, k)
                    else
                        ESX.ShowNotification('Tienes que esperar ' ..
                            math.floor(timer / 1000) .. ' segundos para poder enviar otro anuncio', 5000, 'error')
                    end
                else
                    ESX.ShowNotification('No tienes el rango suficiente para enviar un anuncio', 5000, 'error')
                end
            end
        end
    end
end, false)
