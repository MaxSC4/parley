local Parley = require("parley/core.lua")

local asset = Parley.Load([[start:
Narrator: Welcome, {{player.name}}.
if flags.met == true: Narrator: We have met before.
- Who are you? -> who
- What can I do here? -> help
- Show me options. -> options
- Goodbye. -> end

who:
Narrator: I am just a guide.
do flags.met = true
goto options

help:
Narrator: You can ask questions, take actions, and branch.
goto options

options:
Narrator: Choose your path.
if player.reputation >= 2: - I am trusted here. -> trusted
- I am new here. -> newcomer
- Increase my reputation. -> repup
- End this. -> end

trusted:
Narrator: Welcome back, honored guest.
end

newcomer:
Narrator: Everyone starts somewhere.
end

repup:
Narrator: Let's help someone first.
do reputation += 1
goto options
]], { is_string = true, cache = true })

Parley.RegisterStateProvider(function(player)
    return {
        get = function(_, path)
            if path == "player.name" then
                return player:GetName()
            end
            if path == "player.reputation" then
                return player:GetValue("parley_reputation") or 0
            end
            if path == "flags.met" then
                return player:GetValue("parley_met") or false
            end
            return nil
        end,
        apply = function(_, action)
            if action == "reputation += 1" then
                local current = player:GetValue("parley_reputation") or 0
                player:SetValue("parley_reputation", current + 1)
            elseif action == "flags.met = true" then
                player:SetValue("parley_met", true)
            end
        end
    }
end)

local MinimalStart = {}

function MinimalStart.StartFor(player)
    Parley.Start(player, asset, { entry = "start" })
end

return MinimalStart
