local SessionManager = {}

function SessionManager.Start(Parley, player, asset_or_id, opts)
    return Parley.Start(player, asset_or_id, opts)
end

function SessionManager.Stop(Parley, player, session_id, reason)
    return Parley.Stop(player, session_id, reason)
end

return SessionManager

