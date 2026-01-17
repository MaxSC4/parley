local Parley = require("parley/core.lua")

local asset = Parley.Load("Packages/parley/Examples/dialogues/Branching.txt", { cache = true })

Parley.RegisterStateProvider(function(player)
    return {
        get = function(_, path)
            if path == "player.name" then
                return player:GetName()
            end
            if path == "player.reputation" then
                return player:GetValue("reputation") or 0
            end
            return nil
        end,
        eval = function(_, expr)
            -- Provide your own evaluator if desired
            return expr ~= ""
        end,
        apply = function(_, action)
            if action == "reputation += 1" then
                player:SetValue("reputation", (player:GetValue("reputation") or 0) + 1)
            end
        end
    }
end)

Events.Subscribe("ChatCommand", function(player, command)
    if command == "/branch" then
        Parley.Start(player, asset, { entry = "start" })
    end
end)





