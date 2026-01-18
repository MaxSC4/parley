# Guide: State and Conditions

Parley expressions are evaluated through a state provider. This gives you full control over where data comes from and how mutations are applied.

## Example: reputation gates

This example is adapted from `Examples/StateProviderExample.lua`.

```lua
local Parley = require("parley/core.lua")
local asset = Parley.Load("Packages/Parley/Examples/dialogues/Branching.txt", { cache = true })

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
        apply = function(_, action)
            if action == "reputation += 1" then
                player:SetValue("reputation", (player:GetValue("reputation") or 0) + 1)
            end
        end
    }
end)
```

## Expression rules

The built-in evaluator supports:

- Booleans: `true`, `false`
- Comparisons: `==`, `!=`, `<`, `<=`, `>`, `>=`
- Logic: `and`, `or`, `not`
- Numbers and quoted strings
- Identifiers like `player.reputation` resolved via `get`

If you want a custom evaluator (for example, to add functions), implement `eval(ctx, expr)` in your provider.

