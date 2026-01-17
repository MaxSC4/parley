local Parley = require("parley/core.lua")

local asset = Parley.Load("Packages/parley/Examples/dialogues/Minimal.txt", { cache = true })

local custom_adapter = {
    show_line = function(player, line)
        print("[Parley Custom UI] " .. (line.speaker or "") .. ": " .. (line.text or ""))
    end,
    show_choices = function(player, choices)
        for _, choice in ipairs(choices) do
            print("[Choice] " .. choice.text)
        end
    end,
    hide = function(player)
        print("[Parley Custom UI] Closed")
    end
}

Parley.SetUIAdapter(custom_adapter)

Events.Subscribe("ChatCommand", function(player, command)
    if command == "/customui" then
        Parley.Start(player, asset, { entry = "start" })
    end
end)





