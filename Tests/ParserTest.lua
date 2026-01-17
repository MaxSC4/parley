local Parley = require("parley/core.lua")

local function try(path, expect_fail)
    local ok, result = pcall(function()
        return Parley.Load(path)
    end)
    if ok and not expect_fail then
        print("[PASS] " .. path)
    elseif (not ok) and expect_fail then
        print("[PASS] " .. path .. " (failed as expected)")
    else
        print("[FAIL] " .. path .. " -> " .. tostring(result))
    end
end

try("Packages/parley/Examples/dialogues/Minimal.txt")
try("Packages/parley/Examples/dialogues/Branching.txt")
try("Packages/parley/Examples/dialogues/EdgeCases.txt")
try("Packages/parley/Examples/dialogues/Invalid.txt", true)





