local SyncAnnounce = function(msg, tipo)
    TriggerClientEvent('gny:ShowAnnounce', -1, msg, tipo)
end

RegisterNetEvent('gny:SyncAnnounce', SyncAnnounce)
