local Session = {}

function Session.New(id, player, asset, opts)
    local entry = "start"
    if opts and opts.entry then
        entry = opts.entry
    end
    return {
        id = id,
        player = player,
        asset = asset,
        label = entry,
        index = 1,
        waiting_choices = nil,
        opts = opts or {}
    }
end

return Session
