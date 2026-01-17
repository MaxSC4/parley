local Parley = require("parley/core.lua")
local ServerBridge = require("parley/serverbridge.lua")
local MinimalStart = require("Examples/MinimalStart.lua")

ServerBridge.Setup(Parley)

Console.RegisterCommand("parley", function()
    for _, player in pairs(Player.GetAll()) do
        MinimalStart.StartFor(player)
    end
end, "Start Parley dialogue for all players")

return Parley
