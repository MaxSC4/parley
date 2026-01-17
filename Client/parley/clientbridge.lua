local UIAdapterDefault = require("parley/uiadapterdefault.lua")

local ClientBridge = {}

function ClientBridge.Setup()
    local ui = UIAdapterDefault.Create()

    Events.SubscribeRemote("Parley:show_line", function(session_id, speaker, text, meta)
        print("[Parley] client show_line")
        ui.show_line(session_id, speaker, text, meta)
    end)

    Events.SubscribeRemote("Parley:show_choices", function(session_id, choices)
        print("[Parley] client show_choices")
        ui.show_choices(session_id, choices)
    end)

    Events.SubscribeRemote("Parley:hide", function(session_id)
        print("[Parley] client hide")
        ui.hide(session_id)
    end)
end

return ClientBridge
