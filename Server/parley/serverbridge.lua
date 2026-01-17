local ServerBridge = {}

local function build_adapter(Parley)
    return {
        show_line = function(player, line, session)
            print("[Parley] show_line -> remote")
            Events.CallRemote("Parley:show_line", player, session.id, line.speaker, line.text, line.meta)
        end,
        show_choices = function(player, choices, session)
            print("[Parley] show_choices -> remote")
            Events.CallRemote("Parley:show_choices", player, session.id, choices)
        end,
        hide = function(player, session)
            print("[Parley] hide -> remote")
            Events.CallRemote("Parley:hide", player, session.id)
        end
    }
end

function ServerBridge.Setup(Parley)
    Parley.SetUIAdapter(build_adapter(Parley))

    Events.SubscribeRemote("Parley:next", function(player, session_id)
        print("[Parley] remote next")
        Parley.Continue(player, session_id)
    end)

    Events.SubscribeRemote("Parley:choose", function(player, session_id, choice_id)
        print("[Parley] remote choose")
        Parley.SelectChoice(player, session_id, choice_id)
    end)

    Events.SubscribeRemote("Parley:close", function(player, session_id)
        print("[Parley] remote close")
        Parley.Stop(player, session_id, "closed")
    end)
end

return ServerBridge
